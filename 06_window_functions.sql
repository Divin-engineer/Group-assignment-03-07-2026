--------------------------------------------------------------------------
-- File: 06_window_functions.sql
-- Purpose: Demonstrates WINDOW FUNCTIONS
-- For each center, shows total kits distributed, its rank within its
-- district, and a running total across centers in the same district.
--------------------------------------------------------------------------

SELECT
    d.district_name,
    c.center_name,
    SUM(dist.quantity)                                              AS total_distributed,
    RANK() OVER (
        PARTITION BY d.district_id
        ORDER BY SUM(dist.quantity) DESC
    )                                                                AS rank_in_district,
    SUM(SUM(dist.quantity)) OVER (
        PARTITION BY d.district_id
        ORDER BY c.center_name
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                                                                AS running_total_in_district
FROM   distributions dist
JOIN   beneficiaries b ON dist.beneficiary_id = b.beneficiary_id
JOIN   centers c        ON b.center_id = c.center_id
JOIN   districts d       ON c.district_id = d.district_id
GROUP BY d.district_id, d.district_name, c.center_id, c.center_name
ORDER BY d.district_name, rank_in_district;
