DELIMITER //

CREATE PROCEDURE UpdateBooking(booking_id INT, booking_date DATE)
BEGIN

SET @exists = EXISTS (SELECT BookingID FROM Bookings WHERE BookingID = booking_id);
SELECT TableNum INTO @table_number FROM Bookings WHERE BookingID = booking_id;
SET @available = EXISTS (SELECT BookingID FROM Bookings WHERE Date = booking_date AND TableNum = @table_number);

START TRANSACTION;

UPDATE Bookings
SET Date = booking_date
WHERE BookingID = booking_id;

IF @exists = 0 
	THEN SELECT 'This booking does not exist' AS 'Status';
	ROLLBACK;
ELSEIF @available > 0
	THEN SELECT 'This table is already booked.' AS 'Status';
	ROLLBACK;
ELSE SELECT CONCAT('Booking ', booking_id, ' updated.') AS 'Confirmation';
	COMMIT;
END IF;

END //

DELIMITER ;