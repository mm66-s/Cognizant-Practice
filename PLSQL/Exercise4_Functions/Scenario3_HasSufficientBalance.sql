CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_account_id IN NUMBER,
    p_amount     IN NUMBER
) RETURN BOOLEAN AS
    v_balance NUMBER;
BEGIN
    SELECT Balance INTO v_balance
    FROM Accounts
    WHERE AccountID = p_account_id;

    IF v_balance >= p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
/

-- Example usage (PL/SQL boolean can't be selected directly, so test in a block):
DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := HasSufficientBalance(1, 500);
    IF v_result THEN
        DBMS_OUTPUT.PUT_LINE('Sufficient balance');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient balance');
    END IF;
END;
/