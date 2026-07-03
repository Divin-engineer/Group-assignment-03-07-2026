--------------------------------------------------------------------------
-- File: 05_anonymous_blocks.sql
-- Purpose: Demonstrates an ANONYMOUS BLOCK
-- Loops through all kits and prints a low-stock alert for any kit
-- below the reorder threshold.
--------------------------------------------------------------------------

SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_kits IS
        SELECT kit_id, kit_name, stock_quantity FROM kits;

    v_threshold NUMBER := 20;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Low Stock Report (threshold = ' || v_threshold || ') ---');

    FOR rec IN c_kits LOOP
        IF rec.stock_quantity < v_threshold THEN
            DBMS_OUTPUT.PUT_LINE('ALERT: ' || rec.kit_name ||
                                  ' - only ' || rec.stock_quantity || ' left in stock');
        ELSE
            DBMS_OUTPUT.PUT_LINE('OK: ' || rec.kit_name ||
                                  ' - ' || rec.stock_quantity || ' in stock');
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--- End of Report ---');
END;
/
