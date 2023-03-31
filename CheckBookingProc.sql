DELIMITER //

CREATE PROCEDURE CheckBooking(booking_date DATE, table_number INT)
BEGIN
SELECT 
CASE  
	WHEN 
    (SELECT EXISTS( 
		SELECT BookingID 
        FROM Bookings 
        WHERE Date = booking_date
        AND TableNum = table_number)) > 0 THEN CONCAT('Table ', table_number, ' is already booked')
	ELSE CONCAT('Table ', table_number, ' is available')
END AS "Booking status";
END //

DELIMITER ;