DECLARE
    CURSOR ApplyAnnualFee IS
        SELECT AccountID, Balance FROM Accounts;
    v_fee NUMBER := 50; -- example flat annual maintenance fee
BEGIN
    FOR acc IN ApplyAnnualFee LOOP
        UPDATE Accounts
        SET Balance = Balance - v_fee,
            LastModified = SYSDATE
        WHERE AccountID = acc.AccountID;

        DBMS_OUTPUT.PUT_LINE('Annual fee deducted from AccountID: ' || acc.AccountID);
    END LOOP;

    COMMIT;
END;
/