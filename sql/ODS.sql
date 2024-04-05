CREATE SCHEMA ods

CREATE TABLE ods.Retail_Customers (     
	CustomerID INT PRIMARY KEY,     
	FirstName VARCHAR(50),     
	LastName VARCHAR(50),     
	Gender VARCHAR(50),     
	DateOfBirth DATE,     
	Address VARCHAR(100),     
	City VARCHAR(50),     
	State VARCHAR(50),     
	ZipCode VARCHAR(10),     
	Phone BIGINT,     
	Email VARCHAR(100) 
);

CREATE TABLE ods.Retail_Categories( 
	CategoryID INT PRIMARY KEY, 
	CategoryName VARCHAR(100), 
	Description TEXT
	);

CREATE TABLE ods.Retail_Brands ( 
	BrandID INT PRIMARY KEY,
	BrandName VARCHAR(255),
	Description TEXT 
);


CREATE TABLE ods.Retail_Employees( 
    EmployeeId INT PRIMARY KEY, 
    Firstname VARCHAR(100), 
    LastName VARCHAR(100),
	Position VARCHAR(100),
    ContactNumber BIGINT, 
    HireDate DATE, 
    Email VARCHAR(255),

);


CREATE TABLE ods.Retail_Stores( 
	StoreID INT PRIMARY KEY, 
	StoreName VARCHAR(100), 
	Address VARCHAR(100), 
	City VARCHAR(100), 
	State VARCHAR(50), 
	ZipCode INT, 
	ManagerID INT REFERENCES ods.Retail_Employees(EmployeeID)
);     

CREATE TABLE ods.Retail_Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT references ods.Retail_Categories(CategoryID),
    BrandID INT references ods.Retail_Brands(BrandId),
    Description TEXT,
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT
);


CREATE TABLE ods.Retail_Sales(
	TransactionID INT PRIMARY KEY,
	CustomerID INT FOREIGN KEY REFERENCES ods.Retail_Customers(CustomerID),
	ProductID INT FOREIGN KEY REFERENCES ods.Retail_Products(ProductID),
	Quantity INT,
	UnitPrice INT,
	TransactionDate DATE,
	StoreID INT FOREIGN KEY REFERENCES ods.Retail_Stores(StoreID)
);



drop table ods.Retail_Sales
drop table ods.Retail_Products
drop table ods.Retail_Stores
drop table ods.Retail_Employees 
drop table ods.Retail_Brands
drop table ods.Retail_Categories 
drop table ods.Retail_Customers

Select * from ods.Retail_Customers

Select * from ods.Retail_Categories

Select * from ods.Retail_Brands

Select * from ods.Retail_Employees

Select * from ods.Retail_Stores

Select * from  ods.Retail_Products

Select * from ods.Retail_Sales

