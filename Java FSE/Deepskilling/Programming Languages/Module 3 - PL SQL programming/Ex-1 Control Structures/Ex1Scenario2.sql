ALTER TABLE Customers
ADD COLUMN IsVIP BOOLEAN DEFAULT FALSE;

UPDATE Customers
SET Balance = 15000
WHERE CustomerID = 1;

SELECT CustomerID, Name, Balance
FROM Customers;

DELIMITER $$

CREATE PROCEDURE UpdateVIPCustomers()
BEGIN

    UPDATE Customers
    SET IsVIP = TRUE
    WHERE Balance > 10000;

END $$

DELIMITER ;
SET SQL_SAFE_UPDATES = 0;

CALL UpdateVIPCustomers();

SELECT CustomerID, Name, Balance, IsVIP
FROM Customers;