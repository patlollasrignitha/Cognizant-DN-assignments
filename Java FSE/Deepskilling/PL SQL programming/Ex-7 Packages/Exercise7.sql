-- =========================================
-- CUSTOMER MANAGEMENT
-- =========================================

DROP PROCEDURE IF EXISTS AddCustomer;
DROP PROCEDURE IF EXISTS UpdateCustomer;
DROP FUNCTION IF EXISTS GetCustomerBalance;

DELIMITER $$

CREATE PROCEDURE AddCustomer(
    IN p_CustomerID INT,
    IN p_Name VARCHAR(100),
    IN p_DOB DATE,
    IN p_Balance DECIMAL(10,2)
)
BEGIN
    INSERT INTO Customers
    VALUES(
        p_CustomerID,
        p_Name,
        p_DOB,
        p_Balance,
        NOW(),
        FALSE
    );
END $$


CREATE PROCEDURE UpdateCustomer(
    IN p_CustomerID INT,
    IN p_Name VARCHAR(100)
)
BEGIN
    UPDATE Customers
    SET Name = p_Name
    WHERE CustomerID = p_CustomerID;
END $$


CREATE FUNCTION GetCustomerBalance(
    p_CustomerID INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_Balance DECIMAL(10,2);

    SELECT Balance
    INTO v_Balance
    FROM Customers
    WHERE CustomerID = p_CustomerID;

    RETURN v_Balance;
END $$

DELIMITER ;



-- =========================================
-- EMPLOYEE MANAGEMENT
-- =========================================

DROP PROCEDURE IF EXISTS HireEmployee;
DROP PROCEDURE IF EXISTS UpdateEmployee;
DROP FUNCTION IF EXISTS CalculateAnnualSalary;

DELIMITER $$

CREATE PROCEDURE HireEmployee(
    IN p_EmployeeID INT,
    IN p_Name VARCHAR(100),
    IN p_Position VARCHAR(50),
    IN p_Salary DECIMAL(10,2),
    IN p_Department VARCHAR(50)
)
BEGIN
    INSERT INTO Employees
    VALUES(
        p_EmployeeID,
        p_Name,
        p_Position,
        p_Salary,
        p_Department,
        CURDATE()
    );
END $$


CREATE PROCEDURE UpdateEmployee(
    IN p_EmployeeID INT,
    IN p_Salary DECIMAL(10,2)
)
BEGIN
    UPDATE Employees
    SET Salary = p_Salary
    WHERE EmployeeID = p_EmployeeID;
END $$


CREATE FUNCTION CalculateAnnualSalary(
    p_EmployeeID INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_AnnualSalary DECIMAL(10,2);

    SELECT Salary * 12
    INTO v_AnnualSalary
    FROM Employees
    WHERE EmployeeID = p_EmployeeID;

    RETURN v_AnnualSalary;
END $$

DELIMITER ;



-- =========================================
-- ACCOUNT OPERATIONS
-- =========================================

DROP PROCEDURE IF EXISTS OpenAccount;
DROP PROCEDURE IF EXISTS CloseAccount;
DROP FUNCTION IF EXISTS GetTotalCustomerBalance;

DELIMITER $$

CREATE PROCEDURE OpenAccount(
    IN p_AccountID INT,
    IN p_CustomerID INT,
    IN p_AccountType VARCHAR(20),
    IN p_Balance DECIMAL(10,2)
)
BEGIN
    INSERT INTO Accounts
    VALUES(
        p_AccountID,
        p_CustomerID,
        p_AccountType,
        p_Balance,
        NOW()
    );
END $$


CREATE PROCEDURE CloseAccount(
    IN p_AccountID INT
)
BEGIN
    DELETE FROM Accounts
    WHERE AccountID = p_AccountID;
END $$


CREATE FUNCTION GetTotalCustomerBalance(
    p_CustomerID INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_Total DECIMAL(10,2);

    SELECT SUM(Balance)
    INTO v_Total
    FROM Accounts
    WHERE CustomerID = p_CustomerID;

    RETURN IFNULL(v_Total,0);
END $$

DELIMITER ;


-- test1
CALL AddCustomer(
    3,
    'David Miller',
    '1995-08-10',
    5000
);

CALL UpdateCustomer(
    3,
    'David Smith'
);

SELECT GetCustomerBalance(3);