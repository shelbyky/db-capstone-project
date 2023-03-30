SELECT c.CustomerID,
c.FullName,
o.OrderID,
o.TotalCost AS Cost,
m.Name AS MenuName,
mi.Course AS CourseName,
mi.Starter AS StarterName
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN Menu m ON o.MenuID = m.MenuID
INNER JOIN MenuItems mi on m.MenuItemsID = mi.MenuItemsID
WHERE TotalCost > 150
ORDER BY Cost;
