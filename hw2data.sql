-- Main table (contains all customer information)
CREATE TABLE Customer(
	customer_id SERIAL PRIMARY KEY,
	phone_number BIGINT NOT NULL UNIQUE,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	payment_method VARCHAR(10),
	phone_plan VARCHAR(20),
	bill_amount DECIMAL (10, 2),
	data_usage DECIMAL(10, 2) -- Represented in megabytes
);

-- Demo info
INSERT INTO Customer (customer_id, phone_number, first_name, last_name, payment_method, phone_plan, bill_amount, data_usage)
VALUES (1, 1234567890, 'John', 'Doe', 'Automatic', 'Pre-paid', 50.00, 1024.50),
	   (2, 9876543210, 'Jane', 'Doe', 'Manual', 'Post-paid', 75.00, 1030.25),
	   (3, 1111111111, 'Mark', 'Zuckerberg', 'Automatic', 'Post-paid', 157.00, 2450.10);

-- Phone plan (contains only information about customer and their chosen plan)
CREATE TABLE Phone_Plan(
	customer_id SERIAL PRIMARY KEY,
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
	phone_number BIGINT NOT NULL UNIQUE,
	FOREIGN KEY (phone_number) REFERENCES Customer(phone_number),
	phone_plan VARCHAR(20),
	first_name VARCHAR(20),
	last_name VARCHAR(20)
);

-- The two types of phone plan demo
INSERT INTO Phone_Plan (customer_id, first_name, last_name, phone_number, phone_plan)
	VALUES(1, 'John', 'Doe', 1234567890, 'Pre-paid'),
		  (2, 'Jane', 'Doe', 9876543210, 'Post-paid'),
		  (3, 'Mark', 'Zuckerberg', 1111111111, 'Post-paid');

-- Payment method (contains only information about customer and their method of payment)
CREATE TABLE Payment_Method(
	customer_id SERIAL PRIMARY KEY,
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
	phone_number BIGINT NOT NULL UNIQUE,
	FOREIGN KEY (phone_number) REFERENCES Customer(phone_number),
	payment_method VARCHAR(10),
	bill_amount DECIMAL (10, 2)
);

-- The 2 types of payment methods demo
INSERT INTO Payment_Method (customer_id, phone_number, payment_method, bill_amount)
	VALUES (1, 1234567890, 'Automatic', 50.00), 
		   (2, 9876543210, 'Manual', 75.00),
		   (3, 1111111111, 'Automatic', 157.00);

-- Data usage (contains only information about customer and the amount of data being used)
CREATE TABLE Data_Usage(
	customer_id SERIAL PRIMARY KEY,
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
	phone_number BIGINT NOT NULL UNIQUE,
	FOREIGN KEY (phone_number) REFERENCES Customer(phone_number),
	data_usage DECIMAL(10, 2),
	call_time INTERVAL, -- duration of the call
	call_cost DECIMAL (10, 2),
	call_date DATE
);

-- demo info (if each minute is about 10 cents)
INSERT INTO Data_Usage(customer_id, phone_number, data_usage, call_time, call_cost, call_date)
	VALUES (1, 1234567890, 1024.50, '00:14:50', 1.48, '2023-10-26'),
		   (2, 9876543210, 1030.25, '00:00:45', .74, '2023-10-27'),
		   (3, 1111111111, 2450.10, '00:15:23', 1.53, '2023-11-01');
		   
-- Cell phone transactions (contains only information about customer id and their transaction record)
CREATE TABLE Transactions (
    t_id SERIAL PRIMARY KEY, -- transaction id
    customer_id SERIAL,
    transaction_date DATE,
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- demo
INSERT INTO Transactions (t_id, customer_id, transaction_date)
VALUES		(1, 1, '2023-10-25'),
			(2, 2, '2023-10-26'),
			(3, 3, '2023-10-31');

CREATE TABLE Bank_Account(
	credit_card VARCHAR(15) PRIMARY KEY,
	balance DECIMAL(10, 2)
);

-- Insert money in bank
INSERT INTO Bank_Account(credit_card, balance)
VALUES ('123456789012345', 1000.00),
	   ('234567890123456', 500.00),
	   ('345678901234567', 750.00),
	   ('456789012345678', 1200.50),
	   ('567890123456789', 230.00);
