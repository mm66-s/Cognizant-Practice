CREATE OR REPLACE PACKAGE EmployeeManagement AS
    PROCEDURE HireEmployee(p_employee_id NUMBER, p_name VARCHAR2, p_position VARCHAR2,
                            p_salary NUMBER, p_department VARCHAR2);
    PROCEDURE UpdateEmployeeDetails(p_employee_id NUMBER, p_position VARCHAR2, p_department VARCHAR2);
    FUNCTION CalculateAnnualSalary(p_employee_id NUMBER) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    PROCEDURE HireEmployee(p_employee_id NUMBER, p_name VARCHAR2, p_position VARCHAR2,
                            p_salary NUMBER, p_department VARCHAR2) IS
    BEGIN
        INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
        VALUES (p_employee_id, p_name, p_position, p_salary, p_department, SYSDATE);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Employee ID already exists');
    END HireEmployee;

    PROCEDURE UpdateEmployeeDetails(p_employee_id NUMBER, p_position VARCHAR2, p_department VARCHAR2) IS
    BEGIN
        UPDATE Employees
        SET Position = p_position,
            Department = p_department
        WHERE EmployeeID = p_employee_id;
        COMMIT;
    END UpdateEmployeeDetails;

    FUNCTION CalculateAnnualSalary(p_employee_id NUMBER) RETURN NUMBER IS
        v_salary NUMBER;
    BEGIN
        SELECT Salary INTO v_salary
        FROM Employees
        WHERE EmployeeID = p_employee_id;
        RETURN v_salary * 12;
    END CalculateAnnualSalary;

END EmployeeManagement;
/