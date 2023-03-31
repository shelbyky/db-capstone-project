DELIMITER //

CREATE PROCEDURE AddBooking(booking_id INT, customer_id INT, booking_date DATE, table_number INT)
BEGIN

DECLARE EXIT HANDLER FOR 1062
	BEGIN
		SELECT 'This BookingID is already reserved. Choose another ID.' AS 'Booking status';
	END;

SET @available = EXISTS (SELECT BookingID FROM Bookings WHERE Date = booking_date AND TableNum = table_number);
SELECT CustomerID INTO @customer_ID FROM Bookings WHERE Date = booking_date AND TableNum = table_number;
SET @booking_id = EXISTS (SELECT BookingID from Bookings);

START TRANSACTION;

INSERT INTO Bookings(BookingID, Date, Time, TableNum, CustomerID)
VALUES
(booking_id, booking_date, CURRENT_TIME(), table_number, customer_id);

IF @available > 0 AND customer_ID != @customer_ID
	THEN SELECT CONCAT('Table ', table_number, ' is already booked - booking cancelled') AS 'Booking status';
	ROLLBACK;
ELSEIF @available > 0 AND customer_ID = @customer_ID
	THEN SELECT 'The customer already has this booking' AS 'Booking status';
	ROLLBACK;
ELSE SELECT CONCAT('New booking added.') AS 'Booking status';
	COMMIT;
END IF;
    
END //

DELIMITER ;