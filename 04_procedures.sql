--------------------------------------------------------------------------
-- File: 04_procedures.sql
-- Purpose: Demonstrates a STORED PROCEDURE
-- distribute_kit: records a new distribution to a beneficiary and
-- reduces stock accordingly. Refuses the transaction if stock is too low.
--------------------------------------------------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE distribute_kit (
    p_beneficiary_id IN NUMBER,
    p_kit_id         IN NUMBER,
    p_quantity       IN NUMBER
)
IS
    v_available        NUMBER;
    insufficient_stock EXCEPTION;
BEGIN
    -- Lock the kit row while we check stock, to avoid a race condition
    SELECT stock_quantity
    INTO   v_available
    FROM   kits
    WHERE  kit_id = p_kit_id
    FOR UPDATE;

    IF v_available < p_quantity THEN
        RAISE insufficient_stock;
    END IF;

    INSERT INTO distributions (beneficiary_id, kit_id, quantity)
    VALUES (p_beneficiary_id, p_kit_id, p_quantity);

    UPDATE kits
    SET    stock_quantity = stock_quantity - p_quantity
    WHERE  kit_id = p_kit_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Success: ' || p_quantity || ' kit(s) distributed to beneficiary ' || p_beneficiary_id);

EXCEPTION
    WHEN insufficient_stock THEN
        DBMS_OUTPUT.PUT_LINE('Error: Not enough stock for kit ID ' || p_kit_id ||
                              ' (available: ' || v_available || ', requested: ' || p_quantity || ')');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
        ROLLBACK;
END distribute_kit;
/

-- Example calls
BEGIN
    distribute_kit(p_beneficiary_id => 2, p_kit_id => 2, p_quantity => 3);  -- should succeed
    distribute_kit(p_beneficiary_id => 3, p_kit_id => 2, p_quantity => 100); -- should fail (not enough stock)
END;
/
