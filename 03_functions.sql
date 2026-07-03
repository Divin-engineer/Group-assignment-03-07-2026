--------------------------------------------------------------------------
-- File: 03_functions.sql
-- Purpose: Demonstrates a FUNCTION
-- get_beneficiary_total: returns the total number of kits a given
-- beneficiary has received in total.
--------------------------------------------------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION get_beneficiary_total (
    p_beneficiary_id IN NUMBER
) RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(quantity), 0)
    INTO   v_total
    FROM   distributions
    WHERE  beneficiary_id = p_beneficiary_id;

    RETURN v_total;
END get_beneficiary_total;
/

-- Quick test of the function
BEGIN
    DBMS_OUTPUT.PUT_LINE('Total kits received by beneficiary 1: ' ||
        get_beneficiary_total(1));
END;
/
