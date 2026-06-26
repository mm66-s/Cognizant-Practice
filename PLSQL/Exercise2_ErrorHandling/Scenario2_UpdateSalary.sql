CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_employee_id IN NUMBER,
    p_percentage  IN NUMBER
) AS
    v_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_exists
    FROM Employees
    WHERE EmployeeID = p_employee_id;

    IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Employee ID does not exist');
    END IF;

    UPDATE Employees
    SET Salary = Salary + (Salary * p_percentage / 100)
    WHERE EmployeeID = p_employee_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Salary updated successfully');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating salary: ' || SQLERRM);
END;
/