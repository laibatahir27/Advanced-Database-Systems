CREATE DATABASE SalesAnalysis; -- creating database
USE SalesAnalysis;
CREATE TABLE SalesData (  -- creating table
    SaleID INT PRIMARY KEY,
    SaleDate DATE,
    Country VARCHAR(50),
    Region VARCHAR(50),
    City VARCHAR(50),
    ProductCategory VARCHAR(50),
    ProductName VARCHAR(100),
    SalesAmount DECIMAL(10,2),
    Quantity INT
);
INSERT INTO SalesData VALUES  -- inserting data
(1, '2024-01-05', 'Pakistan', 'Punjab', 'Multan', 'Electronics', 'Mobile', 50000, 5),
(2, '2024-01-06', 'Pakistan', 'Punjab', 'Lahore', 'Electronics', 'Laptop', 120000, 3),
(3, '2024-01-07', 'Pakistan', 'Sindh', 'Karachi', 'Furniture', 'Chair', 15000, 10),
(4, '2024-01-08', 'Pakistan', 'Sindh', 'Karachi', 'Furniture', 'Table', 30000, 4),
(5, '2024-01-09', 'Pakistan', 'KPK', 'Peshawar', 'Clothing', 'Shirt', 8000, 20),
(6, '2024-02-01', 'Pakistan', 'Punjab', 'Multan', 'Electronics', 'Tablet', 40000, 6),
(7, '2024-02-02', 'Pakistan', 'Punjab', 'Lahore', 'Clothing', 'Jeans', 20000, 8),
(8, '2024-02-03', 'Pakistan', 'Sindh', 'Karachi', 'Electronics', 'Mobile', 60000, 7),
(9, '2024-02-04', 'Pakistan', 'KPK', 'Peshawar', 'Furniture', 'Sofa', 70000, 2),
(10, '2024-02-05', 'Pakistan', 'Punjab', 'Faisalabad', 'Clothing', 'Jacket', 25000, 5),
(11, '2024-03-01', 'Pakistan', 'Punjab', 'Lahore', 'Electronics', 'Laptop', 150000, 4),
(12, '2024-03-02', 'Pakistan', 'Sindh', 'Karachi', 'Clothing', 'Shirt', 10000, 15),
(13, '2024-03-03', 'Pakistan', 'Punjab', 'Peshawar', 'Electronics', 'Mobile', 45000, 6),
(14, '2024-03-04', 'Pakistan', 'Punjab', 'Multan', 'Furniture', 'Table', 35000, 3),
(15, '2024-03-05', 'Pakistan', 'Punjab', 'Faisalabad', 'Electronics', 'Tablet', 30000, 4);

-- TASK 3 (CUBE)

SELECT YEAR(SaleDate) AS Year,MONTH(SaleDate) AS Month,     -- Time Dimensions
    Country, Region,City,    -- Location Dimensions
   ProductCategory, ProductName,    -- Product Dimensions 
    SUM(SalesAmount) AS TotalSales,   -- AggregatION Functions
    AVG(SalesAmount) AS AvgSaleValue,  -- AVERAEGE
    SUM(Quantity) AS TotalQuantity
    FROM SalesData
    GROUP BY CUBE (
    YEAR(SaleDate), MONTH(SaleDate),
    Country, Region, City,
    ProductCategory, ProductName
    );


SELECT Region,SUM(SalesAmount) AS TotalSales
FROM SalesData
GROUP BY Region
ORDER BY TotalSales DESC;  -- Highest sales will show first


SELECT Region,SUM(SalesAmount) AS TotalSales
FROM SalesData
GROUP BY Region
ORDER BY TotalSales ASC;   -- Lowest sales will show first


--TASK 4 (ROLLUP)

-- Aggregate data from city -> region -> country level
SELECT Country,Region,City,SUM(SalesAmount) AS TotalSales
FROM SalesData
GROUP BY ROLLUP (Country, Region, City);

--Compare Sales Trends 
SELECT MONTH(SaleDate) AS Month,Region,SUM(SalesAmount) AS TotalSales
FROM SalesData
GROUP BY MONTH(SaleDate),Region
ORDER BY Month,Region;


SELECT MONTH(SaleDate) AS Month,ProductCategory,SUM(SalesAmount) AS TotalSales
FROM SalesData
GROUP BY MONTH(SaleDate),ProductCategory
ORDER BY Month,TotalSales DESC;