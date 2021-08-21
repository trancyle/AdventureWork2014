SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.SalesTerritory
--What is the order for each month From June 2013 to June 2014? by each country?
SELECT oh.OrderDate, COUNT(oh.SalesOrderID) AS SaleQuantity
FROM Sales.SalesOrderHeader AS oh
INNER JOIN Sales.SalesTerritory AS t
ON oh.TerritoryID = t.TerritoryID
WHERE oh.OrderDate BETWEEN '2013-06-01 00:00:00.000' AND '2014-06-30 12:59:59.000'
GROUP BY oh.OrderDate;

--Which country/ region received highest/lowest order from Jun 2013 to Jun 2014?
SELECT oh.OrderDate, t.Name as CountryName,COUNT(oh.SalesOrderID) AS SaleQuantity
FROM Sales.SalesOrderHeader AS oh
INNER JOIN Sales.SalesTerritory AS t
ON oh.TerritoryID = t.TerritoryID
WHERE oh.OrderDate BETWEEN '2013-06-01 00:00:00.000' AND '2014-06-30 12:59:59.000'
GROUP BY t.Name, oh.OrderDate
ORDER BY COUNT(oh.SalesOrderID) ASC;

--What are the most popular shipping methods?
SELECT sm.Name, COUNT(oh.SalesOrderID) AS OrderQuantity
FROM Sales.SalesOrderHeader AS oh 
INNER JOIN Purchasing.ShipMethod AS sm
ON oh.ShipMethodID = sm.ShipMethodID
WHERE oh.OrderDate BETWEEN '2013-06-01 00:00:00.000' AND '2014-06-30 12:59:59.000'
GROUP BY sm.Name;

--What is the Average Leading time for each shipping method?
SELECT * FROM Purchasing.ShipMethod
SELECT * FROM Purchasing.ProductVendor
SELECT * FROM Purchasing.PurchaseOrderDetail

--What is the shipping status of transactions from Jun 2013 to Jun 2014
SELECT soh.SalesOrderID, sm.ShipMethodID, sm.Name AS ShippingVendorName, pv.AverageLeadTime, poh.OrderDate, poh.ShipDate, pod.DueDate,
CASE WHEN poh.ShipDate <= pod.DueDate THEN 'On-Time' ELSE 'Late' END AS ShippingStatus
FROM Sales.SalesOrderHeader AS soh 
INNER JOIN Purchasing.ShipMethod AS sm
ON soh.ShipMethodID = sm.ShipMethodID
INNER JOIN Purchasing.PurchaseOrderHeader AS poh
ON poh.ShipMethodID = sm.ShipMethodID
INNER JOIN Purchasing.PurchaseOrderDetail AS pod
ON pod.PurchaseOrderID = poh.PurchaseOrderID
INNER JOIN Purchasing.ProductVendor AS pv
ON pv.BusinessEntityID = poh.VendorID
WHERE poh.OrderDate BETWEEN '2013-06-01 00:00:00.000' AND '2014-06-30 12:59:59.000'