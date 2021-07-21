--Find All product in product Category 'Accessories'
SELECT p.Name AS ProductName, cate.Name AS Category
FROM Production.ProductSubcategory AS SubID INNER JOIN Production.Product AS p
ON SubID.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS Cate
ON SubID.ProductCategoryID = Cate.ProductCategoryID
WHERE Cate.Name = 'Accessories';

--Find all products that have 'seat' on its name
SELECT p.Name AS ProductName FROM Production.Product AS p
WHERE Name LIKE '%seat%'

--Number of product in each cate
SELECT c.Name AS Category, COUNT (1)
FROM Production.Product AS p INNER JOIN Production.ProductSubcategory AS SubID 
ON p.ProductSubcategoryID = SubID.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS c
ON SubID.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name

--Average prices of all product
SELECT subcate.Name, AVG(ListPrice)
FROM Production.Product AS p 
INNER JOIN Production.ProductSubcategory AS Subcate
ON p.ProductSubcategoryID = subcate.ProductSubcategoryID
GROUP BY subcate.Name

--Highest price of order for each customer in 2011
SELECT c.CustomerID, MAX(TotalDue) AS HighestOrderPrice, oh.OrderDate
FROM Sales.SalesOrderHeader AS oh 
INNER JOIN Sales.Customer AS c
ON oh.CustomerID = c.CustomerID
WHERE oh.OrderDate BETWEEN '2011-01-01 00:00:00.000' AND '2011-12-31 12:59:59.000'
GROUP BY c.CustomerID, oh.OrderDate ORDER BY HighestOrderPrice DESC;

--Customer made the most order in term of product quantity
SELECT oh.CustomerID, MAX (OrderQty) AS HighestOrderQty
FROM Sales.Customer AS c 
INNER JOIN Sales.SalesOrderHeader AS oh
ON oh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesOrderDetail AS d
ON d.SalesOrderID = oh.SalesOrderID
GROUP BY oh.CustomerID, d.OrderQty; 

--- Customer made the most order in term of product total price
SELECT oh.CustomerID, MAX(TotalDue) AS HighestOrderPrice
FROM Sales.Customer AS c 
INNER JOIN Sales.SalesOrderHeader AS oh
ON oh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesOrderDetail AS d
ON d.SalesOrderID = oh.SalesOrderID
GROUP BY oh.CustomerID;

--Orders that were made between the dates 2011-06-13 and 2011-06-18
SELECT oh.CustomerID, oh.OrderDate, oh.TotalDue FROM Sales.SalesOrderHeader AS oh
WHERE OrderDate BETWEEN '2011-06-13 00:00:00.000' AND '2011-06-18 12:59:59.000'
