CREATE SCHEMA dwh;

CREATE TABLE dwh.EmployeesDim(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(100),
	LastName VARCHAR(100),
	Position VARCHAR(100),
	HireDate DATE,
	ContactNumber BIGINT,
	Email VARCHAR(255)
);
Select * from dwh.EmployeesDim

CREATE TABLE dwh.BrandsDim(
	BrandID INT PRIMARY KEY,
    BrandName VARCHAR(225)
);
Select * from dwh.BrandsDim

Create table dwh.CustomersDim (
	CustomerID INT Primary key not null,
    FirstName varchar (100),
    LastName varchar (100),
    Gender varchar (50),
    DateOfBirth DATE,
    Address varchar (100),
    City varchar (50),
    State varchar (50),
    ZipCode varchar (50),
    Phone BIGINT,
    Email varchar (100)
);
Select * from dwh.CustomersDim

CREATE TABLE dwh.StoresDim(
	StoreID INT PRIMARY KEY, 
	StoreName VARCHAR(100), 
	Address VARCHAR(100), 
	City VARCHAR(100), 
	State VARCHAR(50), 
	ZipCode INT,
	ManagerID INT REFERENCES dwh.EmployeesDim(EmployeeID)
);
Select * from dwh.StoresDim


CREATE TABLE dwh.CategoriesDim(
	CategoryID int primary key,
	categoryName varchar(100)
);
Select * from dwh.CategoriesDim

CREATE TABLE dwh.ProductsDim(

    ProductId int Primary Key,

    ProductName varchar(100),

    CategoryID int,

    BrandID int,

    UnitPrice float, 

    UnitsInStock int

    FOREIGN KEY(CategoryID) references dwh.CategoriesDim(CategoryID),

    FOREIGN KEY(BrandID) references dwh.BrandsDim(BrandID),

    );
Select * from  dwh.ProductsDim

CREATE TABLE dwh.SalesFact (

    TransactionID INT PRIMARY KEY,

    CustomerID INT,

    ProductID INT,

    StoreID INT,
	Quantity INT,

    UnitPrice FLOAT,

    TotalAmount FLOAT,

    TransactionDate DATE

    FOREIGN KEY (CustomerID) REFERENCES dwh.CustomersDim(CustomerID),

    FOREIGN KEY (ProductID) REFERENCES dwh.ProductsDim(ProductID),

    FOREIGN KEY (StoreID) REFERENCES dwh.StoresDim(StoreID)

);
Select * from dwh.SalesFact


drop table dwh.SalesFact
drop table dwh.ProductsDim
drop table dwh.StoresDim
drop table dwh.EmployeesDim
drop table dwh.BrandsDim
drop table dwh.CategoriesDim
drop table dwh.CustomersDim









