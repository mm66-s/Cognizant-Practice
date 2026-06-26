CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department      IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus_percentage / 100)
    WHERE Department = p_department;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No employees found in department: ' || p_department);
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Bonus applied to ' || SQL%ROWCOUNT || ' employees');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating bonus: ' || SQLERRM);
END;
/