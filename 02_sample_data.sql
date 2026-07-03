--------------------------------------------------------------------------
-- File: 02_sample_data.sql
-- Purpose: Inserts sample data so the project can be demonstrated
--------------------------------------------------------------------------

-- Districts
INSERT INTO districts (district_name) VALUES ('Nyanza');
INSERT INTO districts (district_name) VALUES ('Huye');
INSERT INTO districts (district_name) VALUES ('Rulindo');

-- Centers (2 per district)
INSERT INTO centers (center_name, district_id) VALUES ('Nyanza Health Post', 1);
INSERT INTO centers (center_name, district_id) VALUES ('Busasamana Center', 1);
INSERT INTO centers (center_name, district_id) VALUES ('Huye Girls School', 2);
INSERT INTO centers (center_name, district_id) VALUES ('Tumba Center', 2);
INSERT INTO centers (center_name, district_id) VALUES ('Rulindo Community Hall', 3);

-- Kits
INSERT INTO kits (kit_name, unit_price, stock_quantity) VALUES ('Reusable Pad Kit - Standard', 3500, 50);
INSERT INTO kits (kit_name, unit_price, stock_quantity) VALUES ('Reusable Pad Kit - Teen', 3000, 15);
INSERT INTO kits (kit_name, unit_price, stock_quantity) VALUES ('Hygiene Add-on Pack', 1500, 40);

-- Beneficiaries
INSERT INTO beneficiaries (full_name, age, center_id) VALUES ('Aline Uwase', 15, 1);
INSERT INTO beneficiaries (full_name, age, center_id) VALUES ('Divine Mukamana', 14, 1);
INSERT INTO beneficiaries (full_name, age, center_id) VALUES ('Grace Iradukunda', 16, 2);
INSERT INTO beneficiaries (full_name, age, center_id) VALUES ('Josiane Umutoni', 13, 3);
INSERT INTO beneficiaries (full_name, age, center_id) VALUES ('Clarisse Ingabire', 15, 4);
INSERT INTO beneficiaries (full_name, age, center_id) VALUES ('Denyse Uwimana', 14, 5);

COMMIT;

-- Distributions are created through the stored procedure (see 04_procedures.sql)
-- but a few are inserted directly here to have historical data for the
-- window functions report.
INSERT INTO distributions (beneficiary_id, kit_id, quantity, distribution_date) VALUES (1, 1, 2, DATE '2026-05-10');
INSERT INTO distributions (beneficiary_id, kit_id, quantity, distribution_date) VALUES (2, 1, 1, DATE '2026-05-10');
INSERT INTO distributions (beneficiary_id, kit_id, quantity, distribution_date) VALUES (3, 2, 1, DATE '2026-05-12');
INSERT INTO distributions (beneficiary_id, kit_id, quantity, distribution_date) VALUES (4, 1, 3, DATE '2026-05-15');
INSERT INTO distributions (beneficiary_id, kit_id, quantity, distribution_date) VALUES (5, 3, 2, DATE '2026-05-18');
INSERT INTO distributions (beneficiary_id, kit_id, quantity, distribution_date) VALUES (6, 1, 1, DATE '2026-05-20');

COMMIT;
