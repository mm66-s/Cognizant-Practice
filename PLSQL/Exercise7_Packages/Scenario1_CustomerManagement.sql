CREATE OR REPLACE PACKAGE CustomerManagement AS
    PROCEDURE AddCustomer(p_customer_id NUMBER, p_name VARCHAR2, p_dob DATE, p_balance NUMBER);
    PROCEDURE UpdateCustomerDetails(p_customer_id NUMBER, p_name VARCHAR2, p_balance NUMBER);
    FUNCTION GetCustomerBalance(p_customer_id NUMBER) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

    PROCEDURE AddCustomer(p_customer_id NUMBER, p_name VARCHAR2, p_dob DATE, p_balance NUMBER) IS
    BEGIN
        INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
        VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE);
        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Customer ID already exists');
    END AddCustomer;

    PROCEDURE UpdateCustomerDetails(p_customer_id NUMBER, p_name VARCHAR2, p_balance NUMBER) IS
    BEGIN
        UPDATE Customers
        SET Name = p_name,
            Balance = p_balance,
            LastModified = SYSDATE
        WHERE CustomerID = p_customer_id;
        COMMIT;
    END UpdateCustomerDetails;

    FUNCTION GetCustomerBalance(p_customer_id NUMBER) RETURN NUMBER IS
        v_balance NUMBER;
    BEGIN
        SELECT Balance INTO v_balance
        FROM Customers
        WHERE CustomerID = p_customer_id;
        RETURN v_balance;
    END GetCustomerBalance;

END CustomerManagement;
/