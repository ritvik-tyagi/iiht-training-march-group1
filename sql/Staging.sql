CREATE SCHEMA STAGING

CREATE TABLE staging.Retail_Stores(
	StoreID INT PRIMARY KEY,
	StoreName VARCHAR(100),
	Address VARCHAR(100),
	City VARCHAR(100),
	State VARCHAR(50),
	ZipCode INT,
	ManagerID INT
);

CREATE TABLE staging.Retail_Brands ( 
	BrandID INT PRIMARY KEY, 
	BrandName VARCHAR(255), 
	Description TEXT 
);

CREATE TABLE staging.Retail_Categories(
	CategoryID INT PRIMARY KEY,
	CategoryName VARCHAR(100),
	Description TEXT
);
 
CREATE TABLE staging.Retail_Employees(
	EmployeeId INT PRIMARY KEY,
	Firstname VARCHAR(100),
	LastName VARCHAR(100),
	Position VARCHAR(100),
	HireDate datetime,
	ContactNumber VARCHAR(100),
	Email varchar(50)            
);

CREATE TABLE staging.Retail_Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    BrandID INT,
    Description TEXT,
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT
);
 
CREATE TABLE staging.Retail_Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(50),
    DateOfBirth DATE,
    Address VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Phone VARCHAR(50),
    Email VARCHAR(100)
);


CREATE TABLE staging.Retail_Sales(
	TransactionID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
	Quantity INT,
	UnitPrice INT NOT NULL,
	TotalAmount DECIMAL(10,2) NOT NULL,
	TransactionDate DATE,
	StoreID INT
	
);

select * from staging.Retail_Stores 

select * from staging.Retail_Brands

select * from staging.Retail_Sales

select * from staging.Retail_Products

select * from staging.Retail_Products

select * from staging.Retail_Categories

select * from staging.Retail_Employees

select * from staging.Retail_Customers

