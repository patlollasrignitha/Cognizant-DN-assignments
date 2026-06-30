DROP PROCEDURE IF EXISTS BankCursorOperations;

DELIMITER $$

CREATE PROCEDURE BankCursorOperations()
BEGIN

    -- Variables for Transactions Cursor
    DECLARE done1 INT DEFAULT FALSE;
    DECLARE v_TransactionID INT;
    DECLARE v_AccountID INT;
    DECLARE v_Amount DECIMAL(10,2);
    DECLARE v_Type VARCHAR(20);

    -- Variables for Accounts Cursor
    DECLARE done2 INT DEFAULT FALSE;
    DECLARE v_AccID INT;

    -- Variables for Loans Cursor
    DECLARE done3 INT DEFAULT FALSE;
    DECLARE v_LoanID INT;

    -- Cursor 1: Monthly Statements
    DECLARE curTransactions CURSOR FOR
        SELECT TransactionID,
               AccountID,
               Amount,
               TransactionType
        FROM Transactions
        WHERE MONTH(TransactionDate) = MONTH(CURDATE())
          AND YEAR(TransactionDate) = YEAR(CURDATE());

    -- Cursor 2: Accounts
    DECLARE curAccounts CURSOR FOR
        SELECT AccountID
        FROM Accounts;

    -- Cursor 3: Loans
    DECLARE curLoans CURSOR FOR
        SELECT LoanID
        FROM Loans;

    -- Handlers
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done1 = TRUE;

    /* Scenario 1: Generate Monthly Statements */

    OPEN curTransactions;

    transaction_loop: LOOP

        FETCH curTransactions
        INTO v_TransactionID,
             v_AccountID,
             v_Amount,
             v_Type;

        IF done1 THEN
            LEAVE transaction_loop;
        END IF;

        SELECT CONCAT(
            'Transaction ID: ', v_TransactionID,
            ', Account ID: ', v_AccountID,
            ', Amount: ', v_Amount,
            ', Type: ', v_Type
        ) AS MonthlyStatement;

    END LOOP;

    CLOSE curTransactions;

    /* Scenario 2: Apply Annual Fee */

    SET done2 = FALSE;

    OPEN curAccounts;

    account_loop: LOOP

        FETCH curAccounts INTO v_AccID;

        IF done2 THEN
            LEAVE account_loop;
        END IF;

        UPDATE Accounts
        SET Balance = Balance - 100
        WHERE AccountID = v_AccID;

    END LOOP;

    CLOSE curAccounts;

    /* Scenario 3: Update Loan Interest Rates */

    SET done3 = FALSE;

    OPEN curLoans;

    loan_loop: LOOP

        FETCH curLoans INTO v_LoanID;

        IF done3 THEN
            LEAVE loan_loop;
        END IF;

        UPDATE Loans
        SET InterestRate = InterestRate + 0.5
        WHERE LoanID = v_LoanID;

    END LOOP;

    CLOSE curLoans;

END $$

DELIMITER ;

CALL BankCursorOperations();

SELECT * FROM Accounts;

SELECT * FROM Loans;

SELECT * FROM Transactions;