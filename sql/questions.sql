--Q1. Total sales amount for each product category.
CREATE PROCEDURE category_amount
AS
BEGIN
	SELECT D.CategoryName, SUM(F.TotalAmount) as TotalSales FROM dwh.SalesFact F 
	JOIN dwh.ProductsDim P ON F.ProductID = P.ProductID JOIN dwh.CategoriesDim D 
	ON D.CategoryID = P.CategoryID 
	GROUP BY D.CategoryName;
END
GO
EXEC  category_amount;
--Q2. Monthly sales trend for a specific product.
CREATE PROCEDURE monthly_product @product_id INT
AS
BEGIN
	SELECT DATENAME(MONTH,TransactionDate) as Month, Quantity, SUM(TotalAmount) as Sales,
	  CASE 
		WHEN SUM(TotalAmount) > LAG(SUM(TotalAmount)) OVER (ORDER BY MONTH(TransactionDate))
		THEN 'Up'
		WHEN SUM(TotalAmount) < LAG(SUM(TotalAmount)) OVER (ORDER BY MONTH(TransactionDate))
		THEN 'Down'
		ELSE 'Flat'
	  END AS PriceMovement
	FROM  dwh.SalesFact WHERE ProductID = @product_id
	GROUP BY DATENAME(MONTH,TransactionDate), MONTH(TransactionDate), Quantity
	ORDER BY MONTH(TransactionDate)
END
GO
EXEC monthly_product @product_id = 10;

--Q3. Top-selling products by quantity.
CREATE PROCEDURE top_sellers @top_n INT
AS
BEGIN
	SELECT TOP(@top_n) ProductsDim.ProductName, SUM(SalesFact.Quantity) as TotalQuantity
	FROM dwh.SalesFact
	INNER JOIN dwh.ProductsDim ON dwh.SalesFact.ProductID = dwh.ProductsDim.ProductId
	GROUP BY ProductsDim.ProductName 
	ORDER BY TotalQuantity DESC;
END
GO
EXEC top_sellers @top_n = 10;
--Q4. Total revenue generated by each store.
CREATE PROCEDURE revenue_by_store
AS
BEGIN
	SELECT dwh.StoresDim.StoreName, SUM(dwh.SalesFact.TotalAmount) as TotalRevenue
	FROM dwh.SalesFact LEFT JOIN dwh.StoresDim ON dwh.SalesFact.StoreID = dwh.StoresDim.StoreID
	GROUP BY dwh.StoresDim.StoreName;
END
GO
EXEC revenue_by_store;
--Q5. Sales distribution by customer gender.
CREATE PROCEDURE sales_by_gender
AS
BEGIN
	SELECT dwh.CustomersDim.Gender, SUM(dwh.SalesFact.TotalAmount) as TotalSales
	FROM dwh.SalesFact
	LEFT JOIN dwh.CustomersDim ON dwh.SalesFact.CustomerID = dwh.CustomersDim.CustomerID
	GROUP BY dwh.CustomersDim.Gender;
END
GO
EXEC sales_by_gender;
--Q6. Quarterly sales comparison between different product brands.
CREATE PROCEDURE quarterly_brands
AS
BEGIN
	SELECT dwh.BrandsDim.BrandName, DATEPART(QUARTER,dwh.SalesFact.TransactionDate) as Quarter, 
	SUM(dwh.SalesFact.TotalAmount) as TotalSales FROM dwh.SalesFact
	LEFT JOIN dwh.ProductsDim ON dwh.SalesFact.ProductID = dwh.ProductsDim.ProductID
	LEFT JOIN dwh.BrandsDim ON dwh.BrandsDim.BrandID = dwh.ProductsDim.BrandID
	GROUP BY dwh.BrandsDim.BrandName, DATEPART(QUARTER,dwh.SalesFact.TransactionDate);
END
GO
EXEC quarterly_brands;
--Q7. Average transaction amount per customer.
CREATE PROCEDURE avg_customer_transaction
AS
BEGIN
	SELECT dwh.CustomersDim.CustomerID, dwh.CustomersDim.FirstName,ROUND(AVG(dwh.SalesFact.TotalAmount),2) as AvgTransactionAmount
	FROM dwh.SalesFact
	LEFT JOIN dwh.CustomersDim ON dwh.SalesFact.CustomerID = dwh.CustomersDim.CustomerID
	GROUP BY dwh.CustomersDim.CustomerID, dwh.CustomersDim.FirstName
	ORDER BY AVG(dwh.SalesFact.TotalAmount) DESC;
END
GO
EXEC avg_customer_transaction;
--Q8. Customer demographics analysis based on purchase behavior.
CREATE PROCEDURE customer_demographics 
AS
BEGIN
	SELECT dwh.CustomersDim.CustomerID, dwh.CustomersDim.FirstName, DATEDIFF(YEAR, dwh.CustomersDim.DateOfBirth, GETDATE()) AS Age, 
	COUNT(dwh.SalesFact.TransactionID) as PurchaseFrequency
	FROM dwh.SalesFact
	LEFT JOIN dwh.CustomersDim ON dwh.SalesFact.CustomerID = dwh.CustomersDim.CustomerID
	GROUP BY dwh.CustomersDim.CustomerID, dwh.CustomersDim.FirstName, DATEDIFF(YEAR, dwh.CustomersDim.DateOfBirth,  GETDATE())
	ORDER BY PurchaseFrequency DESC;
END
GO
EXEC customer_demographics;

--Q9. Average sales per day of the week.
CREATE PROCEDURE avg_by_day
AS
BEGIN
	SELECT DATENAME(WEEKDAY,TransactionDate) as Month, SUM(TotalAmount) as Sales
	FROM dwh.SalesFact
	GROUP BY DATENAME(WEEKDAY,TransactionDate),DATEPART(WEEKDAY, TransactionDate)
	ORDER BY DATEPART(WEEKDAY, TransactionDate)
END
GO
EXEC avg_by_day;
--Q10.Products with the highest profit margins.
CREATE PROCEDURE highest_margins
AS
BEGIN
	SELECT pd.ProductName, ROUND(AVG(((sf.UnitPrice - pd.UnitPrice) / sf.UnitPrice) * 100),2) as AvgProfitMargin
	FROM dwh.ProductsDim pd
	LEFT JOIN dwh.SalesFact sf ON pd.ProductID = sf.ProductID
	GROUP BY pd.ProductName
	ORDER BY AvgProfitMargin DESC;
END
GO
EXEC highest_margins;

--Q11.Total Revenue generated by the city
CREATE PROCEDURE revenue_by_city
AS
BEGIN
	SELECT dwh.StoresDim.City, SUM(dwh.SalesFact.TotalAmount) as TotalSales
	FROM dwh.SalesFact
	LEFT JOIN dwh.StoresDim ON dwh.SalesFact.StoreID = dwh.StoresDim.StoreID
	GROUP BY dwh.StoresDim.City
	ORDER BY SUM(dwh.SalesFact.TotalAmount) DESC;
END
GO
EXEC revenue_by_city;
--Q12. Revenue contribution of each product category to total sales.
CREATE PROCEDURE category_by_percent
AS
BEGIN
	SELECT cd.categoryName, SUM(sf.TotalAmount) as TotalSales,
		   ROUND(((SUM(sf.TotalAmount) / (SELECT SUM(TotalAmount) FROM dwh.SalesFact)) * 100),2) as PercentageContribution
	FROM dwh.SalesFact sf
	LEFT JOIN dwh.ProductsDim pd ON sf.ProductID = pd.ProductId
	LEFT JOIN dwh.CategoriesDim cd ON pd.CategoryID = cd.CategoryID
	GROUP BY cd.categoryName;
END
GO
EXEC category_by_percent;


DROP PROCEDURE category_amount;
DROP PROCEDURE monthly_product;
DROP PROCEDURE avg_customer_transaction;
DROP PROCEDURE avg_by_day;
DROP PROCEDURE highest_margins;