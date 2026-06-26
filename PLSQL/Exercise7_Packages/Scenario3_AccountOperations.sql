CREATE OR REPLACE PACKAGE AccountOperations AS
    PROCEDURE OpenAccount(p_account_id NUMBER, p_customer_id NUMBER, p_account_type VARCHAR2, p_balance NUMBER);
    PROCEDURE CloseAccount(p_account_id NUMBER);
    FUNCTION GetTotalBalance(p_customer_id NUMBER) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    PROCEDURE OpenAccount(p_account_id NUMBER, p_customer_id NUMBER, p_account_type VARCHAR2, p_balance NUMBER) IS
    BEGIN
        INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
        VALUES (p_account_id, p_customer_id, p_account_type, p_balance, SYSDATE);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Account ID already exists');
    END OpenAccount;

    PROCEDURE CloseAccount(p_account_id NUMBER) IS
    BEGIN
        DELETE FROM Accounts WHERE AccountID = p_account_id;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error closing account: ' || SQLERRM);
    END CloseAccount;

    FUNCTION GetTotalBalance(p_customer_id NUMBER) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT SUM(Balance) INTO v_total
        FROM Accounts
        WHERE CustomerID = p_customer_id;
        RETURN NVL(v_total, 0);
    END GetTotalBalance;

END AccountOperations;
/