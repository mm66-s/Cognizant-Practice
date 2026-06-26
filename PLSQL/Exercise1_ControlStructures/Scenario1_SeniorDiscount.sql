DECLARE
    CURSOR cust_cursor IS
        SELECT CustomerID, DOB FROM Customers;
    v_age NUMBER;
BEGIN
    FOR cust IN cust_cursor LOOP
        v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, cust.DOB) / 12);

        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - (InterestRate * 0.01)
            WHERE CustomerID = cust.CustomerID;

            DBMS_OUTPUT.PUT_LINE('Discount applied for CustomerID: ' || cust.CustomerID);
        END IF;
    END LOOP;

    COMMIT;
END;
/