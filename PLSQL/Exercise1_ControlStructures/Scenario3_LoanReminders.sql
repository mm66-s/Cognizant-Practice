DECLARE
    CURSOR loan_cursor IS
        SELECT l.LoanID, l.CustomerID, l.EndDate, c.Name
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30;
BEGIN
    FOR loan IN loan_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Customer ' || loan.Name ||
                              ' has a loan (ID: ' || loan.LoanID ||
                              ') due on ' || TO_CHAR(loan.EndDate, 'DD-MON-YYYY'));
    END LOOP;
END;
/