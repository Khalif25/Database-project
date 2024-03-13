-- Drop tables if they exist
DROP TABLE IF EXISTS TransactionTB CASCADE;
DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS Warehouse CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;
DROP TABLE IF EXISTS Store CASCADE;

-- Warehouse table
CREATE TABLE Warehouse (
    warehouse_id SERIAL PRIMARY KEY,
    warehouse_name VARCHAR(50),
    city VARCHAR(60),
    tell_number VARCHAR(15)
);

-- Insert sample data into warehouse table
INSERT INTO Warehouse (warehouse_name, city, tell_number)
VALUES 
    ('TXB warehouse', 'Texas', '+1-8979679697'),
    ('Refery warehouse', 'Garowe', '+387-8768763'),
    ('Turbine warehouse', 'Delhi', '+241-87687686'),
    ('MSB warehouse', 'TexaTokyo', '+231-7757653'),
    ('GPS warehouse', 'Tokyo', '+333-097776565');

-- Customer table
CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    dob DATE,
    email VARCHAR(60) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    address VARCHAR(100),
    account_number VARCHAR(16) NOT NULL,
    bank_name VARCHAR(80) NOT NULL,
    sort_code INT
);

-- Insert sample data into customer table
INSERT INTO Customer (name, dob, email, phone_number, address, account_number, bank_name, sort_code)
VALUES 
    ('John Eastman', '1970-12-01', 'eastman12@gmail.com', '443-4657653', '30 Street Eastlie', '987938383', 'Premium Bank', 554733),
    ('Jessica Frey', '1989-11-03', 'jessica.john@gmail.com', '651-7657673', '190 Street', '887008383', 'Amal Bank', 999733),
    ('Nadia Amy', '1990-01-02', 'Amy@gmail.com', '571-7657653', '1005 Street', '003938345', 'Rival Bank', 895733),
    ('John Frey', '1978-08-02', 'frey.john@gmail.com', '453-7650653', '100 Street', '882238383', 'American Express', 004733),
    ('Sara James', '1991-02-04', 'sara.john@gmail.com', '446-7957653', '104 Street', '33938003', 'Golman Sacks', 87733);

-- Transaction table
CREATE TABLE TransactionTB (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT,
    transaction_date TIMESTAMP,
    item_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Insert sample data into transaction table
INSERT INTO TransactionTB (customer_id, transaction_date, item_name, quantity, price, description)
VALUES 
    (1, '2023-02-01 08:10:00', 'Guitar', 2, 150.00, 'DP aurora'),
    (2, '2023-02-01 09:40:20', 'Melodious Grand Piano', 2, 150.00, 'DP aurora'),
    (3, '2023-02-01 09:00:12', 'MelodyMinds DVD', 10, 150.00, 'DP aurora'),
    (4, '2023-02-02 10:11:00', 'VintageVibe', 2, 150.00, 'Exor'),
    (5, '2023-02-02 11:13:50', 'MelodyMinds DVD', 2, 9.00, '2B 7GB');

-- Product table
CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    warehouse_id INT,
    product_name VARCHAR(30),
    price DECIMAL(10, 2),
    category VARCHAR(30),
    description TEXT,
    stock_qty NUMERIC,
    registered_date DATE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
);

-- Insert sample data into product table
INSERT INTO Product (warehouse_id, product_name, price, category, description, stock_qty, registered_date)
VALUES 
    (1, 'Keyboard', 7.8, '2B2 Wireless keyboards', 'Description 1', 12, '2023-01-01'),
    (2, 'PCs', 780, 'Dell XPS', 'Description 2', 15, '2023-01-02'),
    (3, 'Tablet', 500, 'Proversio 14', 'Description 3', 10, '2023-01-03'),
    (4, 'Bags', 25, 'packpack', 'Description 4', 12, '2023-01-04'),
    (5, 'HD', 50, 'Seatgate', 'Description 5', 100, '2023-01-05');

-- Store table
CREATE TABLE Store (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(30),
    manager VARCHAR(100),
    warehouse_id INT,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
);

-- Insert sample data into store table
INSERT INTO Store (store_name, city, manager, warehouse_id)
VALUES 
    ('Digital Millenia', 'Turku', 'Henna Eastman', 1),
    ('Musical Trends', 'Ben', 'John Becon', 2),
    ('TT Music Tech', 'Dubai', 'Brayan Bill', 3),
    ('Instrument Frontier', 'Dublin', 'Tina Lu', 4),
    ('Music Gadget dist. store', 'Ben', 'Terry Crews', 5);
-- stored procedure

CREATE OR REPLACE FUNCTION register_customer(
    customer_name VARCHAR(150),
    customer_dob DATE,
    customer_email VARCHAR(60),
    customer_phone VARCHAR(15),
    customer_address VARCHAR(100),
    customer_account_number VARCHAR(16),
    customer_bank_name VARCHAR(80),
    customer_sort_code INT
) RETURNS VOID AS $$
BEGIN
    -- Insert new customer data into the Customer table
    INSERT INTO Customer (name, dob, email, phone_number, address, account_number, bank_name, sort_code)
    VALUES (customer_name, customer_dob, customer_email, customer_phone, customer_address, customer_account_number, customer_bank_name, customer_sort_code);
    
    -- Output message indicating successful registration
    RAISE NOTICE 'Customer % registered successfully.', customer_name;
END;
$$ LANGUAGE plpgsql;

-- sample registration of new customer
SELECT register_customer(
    'Bill Dell',
    '1980-07-01',
    'Bill@gmsil.com',
    '123-456-7890',
    ' 158 St',
    '4564456444444',
    'Barclays Bank',
    123456
);

select* from Customer

-- purchase a product

CREATE OR REPLACE FUNCTION purchase_product(
    customer_id INT,
    product_id INT,
    delivery_datetime TIMESTAMP
) RETURNS VOID AS $$
DECLARE
    product_available BOOLEAN;
    delivery_slot_available BOOLEAN;
BEGIN
    -- Check if the product is available
    SELECT TRUE INTO product_available
    FROM Product
    WHERE product_id = product_id AND stock_qty > 0;

    -- Check if the delivery slot is available
    SELECT TRUE INTO delivery_slot_available
    FROM DeliverySchedule
    WHERE delivery_datetime = delivery_datetime;

    -- If both product and delivery slot are available, proceed with the purchase
    IF product_available AND delivery_slot_available THEN
        -- Insert transaction data into Transaction table
        INSERT INTO TransactionTB (customer_id, product_id, delivery_datetime)
        VALUES (customer_id, product_id, delivery_datetime);
        
        -- Decrement product stock quantity
        UPDATE Product
        SET stock_qty = stock_qty - 1
        WHERE product_id = product_id;
        
        -- Output message indicating successful purchase
        RAISE NOTICE 'Purchase of product % scheduled for % completed successfully.', product_id, delivery_datetime;
    ELSE
        -- Output error message if product or delivery slot is not available
        RAISE EXCEPTION 'Product or delivery slot not available for purchase.';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- sample purchase
SELECT purchase_product(
    2001, -- Customer_id
    1001, -- Product_id
    '2024-02-15 14:00:00' -- Delivery datetime
);


