-- Run once if IsVIP column doesn't exist:
-- ALTER TABLE Customers ADD IsVIP VARCHAR2(5) DEFAULT 'FALSE';

DECLARE
    CURSOR cust_cursor IS
        SELECT CustomerID, Balance FROM Customers;
BEGIN
    FOR cust IN cust_cursor LOOP
        IF cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = cust.CustomerID;

            DBMS_OUTPUT.PUT_LINE('CustomerID ' || cust.CustomerID || ' marked as VIP');
        END IF;
    END LOOP;

    COMMIT;
END;
/