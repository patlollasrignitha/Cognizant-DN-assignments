CREATE TABLE ErrorLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    ErrorMessage VARCHAR(255),
    LogDate DATETIME
);

-- =====================================
-- Scenario 1: SafeTransferFunds
-- =====================================

DROP PROCEDURE IF EXISTS SafeTransferFunds;

DELIMITER $$

CREATE PROCEDURE SafeTransferFunds(
    IN p_FromAccount INT,
    IN p_ToAccount INT,
    IN p_Amount DECIMAL(10,2)
)
BEGIN
    DECLARE v_Balance DECIMAL(10,2);

    START TRANSACTION;

    SELECT Balance
    INTO v_Balance
    FROM Accounts
    WHERE AccountID = p_FromAccount;

    IF v_Balance < p_Amount THEN

        INSERT INTO ErrorLog(ErrorMessage, LogDate)
        VALUES ('Insufficient Funds', NOW());

        ROLLBACK;

    ELSE

        UPDATE Accounts
        SET Balance = Balance - p_Amount
        WHERE AccountID = p_FromAccount;

        UPDATE Accounts
        SET Balance = Balance + p_Amount
        WHERE AccountID = p_ToAccount;

        COMMIT;

    END IF;

END $$

DELIMITER ;



-- =====================================
-- Scenario 2: UpdateSalary
-- =====================================

DROP PROCEDURE IF EXISTS UpdateSalary;

DELIMITER $$

CREATE PROCEDURE UpdateSalary(
    IN p_EmployeeID INT,
    IN p_Percentage DECIMAL(5,2)
)
BEGIN

    IF EXISTS (
        SELECT *
        FROM Employees
        WHERE EmployeeID = p_EmployeeID
    ) THEN

        UPDATE Employees
        SET Salary = Salary + (Salary * p_Percentage / 100)
        WHERE EmployeeID = p_EmployeeID;

    ELSE

        INSERT INTO ErrorLog(ErrorMessage, LogDate)
        VALUES ('Employee ID does not exist', NOW());

    END IF;

END $$

DELIMITER ;



-- =====================================
-- Scenario 3: AddNewCustomer
-- =====================================

DROP PROCEDURE IF EXISTS AddNewCustomer;

DELIMITER $$

CREATE PROCEDURE AddNewCustomer(
    IN p_CustomerID INT,
    IN p_Name VARCHAR(100),
    IN p_DOB DATE,
    IN p_Balance DECIMAL(10,2)
)
BEGIN

    IF EXISTS (
        SELECT *
        FROM Customers
        WHERE CustomerID = p_CustomerID
    ) THEN

        INSERT INTO ErrorLog(ErrorMessage, LogDate)
        VALUES ('Customer ID already exists', NOW());

    ELSE

        INSERT INTO Customers
        (
            CustomerID,
            Name,
            DOB,
            Balance,
            LastModified
        )
        VALUES
        (
            p_CustomerID,
            p_Name,
            p_DOB,
            p_Balance,
            NOW()
        );

    END IF;

END $$

DELIMITER ;

-- Scenerio 1 verification(S1)
CALL SafeTransferFunds(1, 2, 500);
SELECT * FROM Accounts;

-- Scenerio 2 verification(S2)
CALL UpdateSalary(1, 10);
SELECT * FROM Employees;

-- Scenerio 3 verification(S3)

CALL AddNewCustomer(
    3,
    'David Miller',
    '1995-08-10',
    5000
);

CALL AddNewCustomer(
    1,
    'Duplicate Customer',
    '1990-01-01',
    1000
);
SELECT * FROM ErrorLog;