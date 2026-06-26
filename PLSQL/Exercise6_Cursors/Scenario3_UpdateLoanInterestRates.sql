DECLARE
    CURSOR UpdateLoanInterestRates IS
        SELECT LoanID, InterestRate FROM Loans;
    v_new_policy_increment NUMBER := 0.5; -- example: +0.5% per new policy
BEGIN
    FOR loan IN UpdateLoanInterestRates LOOP
        UPDATE Loans
        SET InterestRate = InterestRate + v_new_policy_increment
        WHERE LoanID = loan.LoanID;

        DBMS_OUTPUT.PUT_LINE('Updated interest rate for LoanID: ' || loan.LoanID);
    END LOOP;

    COMMIT;
END;
/