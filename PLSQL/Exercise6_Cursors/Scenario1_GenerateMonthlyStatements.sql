DECLARE
    CURSOR GenerateMonthlyStatements IS
        SELECT t.TransactionID, t.AccountID, t.Amount, t.TransactionType,
               t.TransactionDate, c.Name
        FROM Transactions t
        JOIN Accounts a ON t.AccountID = a.AccountID
        JOIN Customers c ON a.CustomerID = c.CustomerID
        WHERE TRUNC(t.TransactionDate, 'MM') = TRUNC(SYSDATE, 'MM');
BEGIN
    FOR stmt IN GenerateMonthlyStatements LOOP
        DBMS_OUTPUT.PUT_LINE('Statement - Customer: ' || stmt.Name ||
                              ', Account: ' || stmt.AccountID ||
                              ', Type: ' || stmt.TransactionType ||
                              ', Amount: ' || stmt.Amount ||
                              ', Date: ' || TO_CHAR(stmt.TransactionDate, 'DD-MON-YYYY'));
    END LOOP;
END;
/