-- Drop tables if they exist

DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Warehouse;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Transaction;


-- Customer table
DROP TABLE IF EXISTS Customer;
create table Customer(
    customer_ID SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
	DOB date, -- adopted date format: MM/DD/YYYY
    email VARCHAR(60) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    address VARCHAR(100),
	account_number varchar(16) NOT NULL,
	bank_name varchar(80) NOT NULL,
	sort_code int);
	--primary key (customer_ID));
	--foreign k


insert into Customer values
(2001, 'John Eastman','1970-12-01','eastman12@gmail.com',443-4657653,'30 Street Eastlie',987938383,'Premium Bank',554733),
(2002, 'Jessica Frey','1989-11-03','jessica.john@gmail.com',651-7657673,'190 Street',887008383,'Amal Bank',999733),
(2003, 'Nadia Amy','1990-01-02','Amy@gmail.com',571-7657653,'1005 Street',003938345,'Rival Bank',895733),
(2004, 'John Frey','1978-08-02','frey.john@gmail.com',453-7650653,'100 Street',882238383,'American Express',004733),
(2005, 'Sara James','1991-02-04','sara.james@gmail.com',446-7957653,'104 Street',33938003,'Golman Sacks',87733),
(2006, 'George Albert','2000-12-25','sara.john@gmail.com',446-7957653,'104 Street',33938003,'Golman Sacks',87733)
select*from Customer

--  Transaction table
create table Transaction 
(
	Transaction_ID SERIAL PRIMARY KEY,
    Customer_ID smallint NOT NULL,
    Transaction_date TIMESTAMP,
	Item_ID varchar(50)
	Item_Name varchar(50)
	Quantity int
	Price decimal(10, 2) NOT NULL,
    Description TEXT
	
);
insert into Transaction
values(1001,2001, 2023-02-01 08:10:00,'BC01', 'Guitar' 2, 150.00 'DP aurora'),
      (1002,2002, 2023-02-01 09:40:20,'BC01', 'Melodious Grand Piano' 2, 150.00 'DP aurora'),  
	  (1003,2003, 2023-02-01 09:00:12,'BC01', 'MelodyMinds DVD ' 10, 150.00 'DP aurora'),
	  (1004,2004, 2023-02-02 10:11:00,'BC01', 'VintageVibe' 2, 150.00 'Exor'),
	  (1005,2005, 2023-02-02 11:13:50,'BC01', 'MelodyMinds DVD' 2, 9.00 '2B 7GB'),
	  (1006,2006, 2023-02-02 01:00:50,'BC01', 'MelodyMinds DVD' 1, 12.00 '10GB'),
	  (1007,2007, 2023-02-02 02:10:50,'BC01', 'MelodyMinds DVD' 5, 13.00 '10GB'),

-- Create product table

CREATE TABLE Product(
	product_ID smallint primary key,
	product_name varchar (30),
	price decimal(10,2)
	Category VARCHAR(30)
	description text,
	Stock_QTY numeric 
	Registered_date date
);
insert into Product 
values
(1001, 'Keyboard', 7.8, ' 2B2 Wireless keyboards', 12),
(1002, 'PCs', 780, ' Dell XPS', 15),
(1003, 'Tablet', 500, ' Proversio 14', 10),
(1004, 'Bags', 25, ' packpack', 12),
(1005, 'HD', 50, ' Seatgate', 100),
(1006, 'RAM', 35, ' DDR4 UUM2', 40),
(1007, 'Glass cleaner', 7, ' Liquid spray', 20)
SELECT * FROM
Product
alter table Product
alter column QTY numeric

-- Create product table
create table Warehouse (
    warehouse_id serial PRIMARY KEY,
    warehouse_name varchar(50),
    City varchar(60),
	Tell_number varchar (15)
);
	 	
create table Warehouse(
	warehouse_ID serial primary key,
	warehouse_name varchar(40),
	city varchar(40),
	Tell_Number varchar(20));
select* from Warehouse

INSERT INTO
Warehouse (warehouse_ID, warehouse_name, city, Tell_Number)
VALUES (001,'TXB warehouse', 'Texas','+1-8979679697'),
       (002,'Refery warehouse', 'Garowe','+387-8768763'),
	   (003,'Turbine warehouse', 'Delhi','+241-87687686'),
	   (004,'MSB warehouse', 'TexaTokyo','+231-7757653'),
	   (005,'GPS warehouse', 'Tokyo','+333-097776565');
	   
	   SELECT* from Warehouse

-- create store table
create table Store (
store_ID serial primary key,
store_name varchar(100),
city varchar (30),
manager varchar (100)
-- varchar (250) is sufficient for most names
)
insert into Store (store_ID, store_name,city, manager)
values (0001,'Digital Millenia','Turku','Henna Eastman'),
       (0002,'Musical Trends','Ben','John Becon'),
	   (0003,'TT Music Tech','Dubai','Brayan Bill'),
	   (0004,'Instrument Frontier','Dublin','Tina Lu'),
	   (0005,'Music Gadget dist. store ','Ben','Terry Crews');
	  select* from store
	  
----
DROP TABLE IF EXISTS Customer

Create table Customer (
    customer_ID serial primary key,
    name varchar(150) NOT NULL,
	DOB date,
    email VARCHAR(60) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    address VARCHAR(100),
	account_number varchar(16) NOT NULL,
	bank_name varchar(80) NOT NULL,
	sort code smallint NOT NULL,
	primary key (Customer_ID,account_number,Sort_code);
	--foreign ke)


insert into Customers values
(2001, 'John','Eastman','eastman12@gmail.com',443-4657653,'30 Street Eastlie',987938383,'Premium Bank',554733),
(2002, 'Jessica','Frey','jessica.john@gmail.com',651-7657673,'190 Street',887008383,'Amal Bank',999733),
(2003, 'Nadia','Amy','Amy@gmail.com',571-7657653,'1005 Street',003938345,'Rival Bank',895733),
(2004, 'John','Frey','frey.john@gmail.com',453-7650653,'100 Street',882238383,'American Express',004733),
(2005, 'Sara','James','sara.john@gmail.com',446-7957653,'104 Street',33938003,'Golman Sacks',87733)


