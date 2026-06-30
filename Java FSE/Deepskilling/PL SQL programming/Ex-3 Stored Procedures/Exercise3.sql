DROP PROCEDURE IF EXISTS BankOperations;

DELIMITER $$

CREATE PROCEDURE BankOperations(
    IN p_Department VARCHAR(50),
    IN p_BonusPercent DECIMAL(5,2),
    IN p_FromAccount INT,
    IN p_ToAccount INT,
    IN p_Amount DECIMAL(10,2)
)
BEGIN

    DECLARE v_Balance DECIMAL(10,2);

    -- Scenario 1: Monthly Interest
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';

    -- Scenario 2: Employee Bonus
    UPDATE Employees
    SET Salary = Salary + (Salary * p_BonusPercent / 100)
    WHERE Department = p_Department;

    -- Scenario 3: Fund Transfer
    SELECT Balance
    INTO v_Balance
    FROM Accounts
    WHERE AccountID = p_FromAccount;

    IF v_Balance >= p_Amount THEN

        UPDATE Accounts
        SET Balance = Balance - p_Amount
        WHERE AccountID = p_FromAccount;

        UPDATE Accounts
        SET Balance = Balance + p_Amount
        WHERE AccountID = p_ToAccount;

        SELECT 'Fund Transfer Successful' AS Message;

    ELSE

        SELECT 'Insufficient Balance' AS Message;

    END IF;

END $$

DELIMITER ;

CALL BankOperations(
    'IT',    -- Department
    10,      -- Bonus Percentage
    1,       -- From Account
    2,       -- To Account
    200      -- Transfer Amount
);

SELECT * FROM Accounts;

SELECT * FROM Employees;