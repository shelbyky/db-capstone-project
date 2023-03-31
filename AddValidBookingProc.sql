DELIMITER //

CREATE PROCEDURE AddValidBooking(booking_date DATE, table_number INT, customer_id INT)
BEGIN

SET @available = EXISTS (SELECT BookingID FROM Bookings WHERE Date = booking_date AND TableNum = table_number);
SELECT CustomerID INTO @customer_ID FROM Bookings WHERE Date = booking_date AND TableNum = table_number;

START TRANSACTION;

INSERT INTO Bookings(Date, Time, TableNum, CustomerID)
VALUES
(booking_date, CURRENT_TIME(), table_number, customer_id);

IF @available > 0 AND customer_ID != @customer_ID
	THEN SELECT CONCAT('Table ', table_number, ' is already booked - booking cancelled') AS 'Booking status';
	ROLLBACK;
ELSEIF @available > 0 AND customer_ID = @customer_ID
	THEN SELECT 'The customer already has this booking' AS 'Booking status';
	ROLLBACK;
ELSE SELECT CONCAT('Table ', table_number, ' is available. Booking successful.') AS 'Booking status';
	COMMIT;
END IF;
    
END //

DELIMITER ;