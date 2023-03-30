PREPARE GetOrderDetail FROM
'SELECT OrderID,
Quantity,  
TotalCost as Cost
FROM Orders
WHERE OrderID = ?;';