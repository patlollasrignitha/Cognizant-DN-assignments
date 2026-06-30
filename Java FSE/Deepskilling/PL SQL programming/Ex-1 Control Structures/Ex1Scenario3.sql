UPDATE Loans
SET EndDate = DATE_ADD(CURDATE(), INTERVAL 20 DAY)
WHERE LoanID = 1;

SELECT * FROM Loans;

DELIMITER $$

CREATE PROCEDURE LoanDueReminder()
BEGIN
    SELECT
        c.CustomerID,
        c.Name,
        l.LoanID,
        l.EndDate,
        CONCAT(
            'Reminder: Dear ',
            c.Name,
            ', your Loan ID ',
            l.LoanID,
            ' is due on ',
            l.EndDate
        ) AS ReminderMessage
    FROM Customers c
    JOIN Loans l
        ON c.CustomerID = l.CustomerID
    WHERE l.EndDate BETWEEN CURDATE()
                        AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);
END $$

DELIMITER ;

CALL LoanDueReminder();
