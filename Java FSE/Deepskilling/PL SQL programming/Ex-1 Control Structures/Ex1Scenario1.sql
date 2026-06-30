SELECT * FROM Customers;
SELECT * FROM Loans;

UPDATE Customers
SET DOB = '1960-05-15'
WHERE CustomerID = 1;

DELIMITER $$

CREATE PROCEDURE ApplySeniorCitizenDiscount()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_id INT;
    DECLARE c_dob DATE;
    DECLARE age_years INT;

    DECLARE cur CURSOR FOR
        SELECT CustomerID, DOB
        FROM Customers;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;

    OPEN cur;

    read_loop: LOOP

        FETCH cur INTO c_id, c_dob;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SET age_years = TIMESTAMPDIFF(YEAR, c_dob, CURDATE());

        IF age_years > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = c_id;
        END IF;

    END LOOP;

    CLOSE cur;

END $$

DELIMITER ;
CALL ApplySeniorCitizenDiscount();

SELECT * FROM Loans;