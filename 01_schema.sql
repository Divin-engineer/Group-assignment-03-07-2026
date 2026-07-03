--------------------------------------------------------------------------
-- Group Assignment III - Database Programming (C11665 - DPR400210)
-- Project: Reusable Pad Kit Distribution System
-- File: 01_schema.sql
-- Purpose: Creates all tables for the project with proper constraints
--------------------------------------------------------------------------

-- Clean up (only needed if re-running the script)
-- DROP TABLE distributions PURGE;
-- DROP TABLE beneficiaries PURGE;
-- DROP TABLE kits PURGE;
-- DROP TABLE centers PURGE;
-- DROP TABLE districts PURGE;

-- 1. Districts: the regions where MamaLink operates
CREATE TABLE districts (
    district_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    district_name   VARCHAR2(50) NOT NULL UNIQUE
);

-- 2. Centers: local distribution points inside each district
CREATE TABLE centers (
    center_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    center_name     VARCHAR2(100) NOT NULL,
    district_id     NUMBER NOT NULL,
    CONSTRAINT fk_center_district FOREIGN KEY (district_id)
        REFERENCES districts(district_id)
);

-- 3. Kits: the reusable pad kits held in stock
CREATE TABLE kits (
    kit_id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    kit_name        VARCHAR2(100) NOT NULL,
    unit_price      NUMBER(10,2) NOT NULL,
    stock_quantity  NUMBER DEFAULT 0 NOT NULL,
    CONSTRAINT chk_stock_nonneg CHECK (stock_quantity >= 0)
);

-- 4. Beneficiaries: the girls receiving kits, registered at a center
CREATE TABLE beneficiaries (
    beneficiary_id  NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name       VARCHAR2(100) NOT NULL,
    age             NUMBER(3) NOT NULL,
    center_id       NUMBER NOT NULL,
    CONSTRAINT fk_beneficiary_center FOREIGN KEY (center_id)
        REFERENCES centers(center_id)
);

-- 5. Distributions: transaction log - who received what, and when
CREATE TABLE distributions (
    distribution_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    beneficiary_id       NUMBER NOT NULL,
    kit_id                NUMBER NOT NULL,
    quantity              NUMBER NOT NULL,
    distribution_date     DATE DEFAULT SYSDATE,
    CONSTRAINT fk_dist_beneficiary FOREIGN KEY (beneficiary_id)
        REFERENCES beneficiaries(beneficiary_id),
    CONSTRAINT fk_dist_kit FOREIGN KEY (kit_id)
        REFERENCES kits(kit_id),
    CONSTRAINT chk_qty_positive CHECK (quantity > 0)
);
