-- =====================================
-- Function 1: CalculateAge
-- =====================================

DROP FUNCTION IF EXISTS CalculateAge;

DELIMITER $$

CREATE FUNCTION CalculateAge(
    p_DOB DATE
)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, p_DOB, CURDATE());
END $$

DELIMITER ;



-- =====================================
-- Function 2: CalculateMonthlyInstallment
-- =====================================

DROP FUNCTION IF EXISTS CalculateMonthlyInstallment;

DELIMITER $$

CREATE FUNCTION CalculateMonthlyInstallment(
    p_LoanAmount DECIMAL(10,2),
    p_InterestRate DECIMAL(5,2),
    p_Years INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE MonthlyInstallment DECIMAL(10,2);

    SET MonthlyInstallment =
        (p_LoanAmount +
        (p_LoanAmount * p_InterestRate * p_Years / 100))
        / (p_Years * 12);

    RETURN MonthlyInstallment;
END $$

DELIMITER ;



-- =====================================
-- Function 3: HasSufficientBalance
-- =====================================

DROP FUNCTION IF EXISTS HasSufficientBalance;

DELIMITER $$

CREATE FUNCTION HasSufficientBalance(
    p_AccountID INT,
    p_Amount DECIMAL(10,2)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE v_Balance DECIMAL(10,2);

    SELECT Balance
    INTO v_Balance
    FROM Accounts
    WHERE AccountID = p_AccountID;

    RETURN v_Balance >= p_Amount;
END $$

DELIMITER ;


-- Test1 scenerio1
SELECT Name,
       CalculateAge(DOB) AS Age
FROM Customers;

-- Test2 scenerio2
SELECT CalculateMonthlyInstallment(
    5000,
    5,
    5
) AS MonthlyInstallment;

-- Test3 scenerio3

SELECT HasSufficientBalance(
    1,
    500
) AS Result;