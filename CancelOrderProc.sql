DELIMITER //

CREATE PROCEDURE CancelOrder(order_id INT)
BEGIN
DELETE FROM Orders
WHERE OrderID = order_id;
SELECT CONCAT('Order ', order_id, ' is cancelled') AS Confirmation;
END //

DELIMITER ;