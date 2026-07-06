CREATE TABLE AuditLog (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    TransactionID INT,
    AccountID INT,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20),
    AuditDate DATETIME
);

-- =====================================
-- Trigger 1: UpdateCustomerLastModified
-- =====================================

DROP TRIGGER IF EXISTS UpdateCustomerLastModified;

DELIMITER $$

CREATE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    SET NEW.LastModified = NOW();
END $$

DELIMITER ;



-- =====================================
-- Trigger 2: LogTransaction
-- =====================================

DROP TRIGGER IF EXISTS LogTransaction;

DELIMITER $$

CREATE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN

    INSERT INTO AuditLog
    (
        TransactionID,
        AccountID,
        Amount,
        TransactionType,
        AuditDate
    )
    VALUES
    (
        NEW.TransactionID,
        NEW.AccountID,
        NEW.Amount,
        NEW.TransactionType,
        NOW()
    );

END $$

DELIMITER ;



-- =====================================
-- Trigger 3: CheckTransactionRules
-- =====================================

DROP TRIGGER IF EXISTS CheckTransactionRules;

DELIMITER $$

CREATE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN

    DECLARE v_Balance DECIMAL(10,2);

    SELECT Balance
    INTO v_Balance
    FROM Accounts
    WHERE AccountID = NEW.AccountID;

    IF NEW.TransactionType = 'Withdrawal'
       AND NEW.Amount > v_Balance THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Withdrawal exceeds account balance';

    END IF;

    IF NEW.TransactionType = 'Deposit'
       AND NEW.Amount <= 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Deposit amount must be positive';

    END IF;

END $$

DELIMITER ;


-- Testing trigger1
UPDATE Customers
SET Balance = 2000
WHERE CustomerID = 1;
-- verify
SELECT CustomerID,
       Name,
       LastModified
FROM Customers;

-- Testing trigger2
INSERT INTO Transactions
VALUES
(
    10,
    1,
    NOW(),
    200,
    'Deposit'
);
-- verify
SELECT * FROM AuditLog;

-- Testing trigger3
-- invalid withdrawl
INSERT INTO Transactions
VALUES
(
    4,
    1,
    NOW(),
    999999,
    'Withdrawal'
);
-- invalid deposit
INSERT INTO Transactions
VALUES
(
    5,
    1,
    NOW(),
    -100,
    'Deposit'
);