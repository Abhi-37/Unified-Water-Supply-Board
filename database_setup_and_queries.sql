CREATE DATABASE UnifiedWaterSupply_board;

USE UnifiedWaterSupply_board;

-- Create the schema

-- Customers
CREATE TABLE Customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  address VARCHAR(500),
  contact_number VARCHAR(20)
);

-- Watersupply Board
CREATE TABLE Watersupply_board (
  board_id INT AUTO_INCREMENT PRIMARY KEY,
  board_name VARCHAR(255),
  location VARCHAR(255)
);

-- Tariffs
CREATE TABLE Tariffs (
  tariff_id INT AUTO_INCREMENT PRIMARY KEY,
  tariff_name VARCHAR(255),
  rate_per_unit DECIMAL(10, 2)
);

-- Account
CREATE TABLE Account (
  account_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  account_number VARCHAR(255),
  connection_type VARCHAR(255),
  board_id INT,
  tariff_id INT,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY (board_id) REFERENCES Watersupply_board(board_id),
  FOREIGN KEY (tariff_id) REFERENCES Tariffs(tariff_id)
);

-- Billing
CREATE TABLE Billing (
  billing_id INT AUTO_INCREMENT PRIMARY KEY,
  account_id INT,
  billing_date DATE,
  total_amount DECIMAL(10, 2),
  FOREIGN KEY (account_id) REFERENCES Account(account_id)
);

-- Meters
CREATE TABLE Meters (
  meter_id INT AUTO_INCREMENT PRIMARY KEY,
  account_id INT,
  meter_number VARCHAR(255),
  installation_date DATE,
  FOREIGN KEY (account_id) REFERENCES Account(account_id)
);

-- Meter Reading
CREATE TABLE Meter_Reading (
  reading_id INT AUTO_INCREMENT PRIMARY KEY,
  meter_id INT,
  reading_date DATE,
  units_consumed INT,
  FOREIGN KEY (meter_id) REFERENCES Meters(meter_id)
);

-- Payments
CREATE TABLE Payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  payment_date DATE,
  amount DECIMAL(10, 2),
  payment_mode VARCHAR(255),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Invoice
CREATE TABLE Invoice (
  invoice_id INT AUTO_INCREMENT PRIMARY KEY,
  billing_id INT,
  invoice_date DATE,
  FOREIGN KEY (billing_id) REFERENCES Billing(billing_id)
);

-- Feedback
CREATE TABLE Feedback (
  feedback_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  feedback_text TEXT,
  feedback_date DATE,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Sample Data Insertion

INSERT INTO Customers (first_name, last_name, address, contact_number)
VALUES
  ('Aarav', 'Sharma', '1234 ABC Street, Mumbai', '9876543210'),
  ('Diya', 'Patel', '567 XYZ Road, Delhi', '8765432109'),
  ('Aryan', 'Singh', '789 PQR Avenue, Bangalore', '7654321098'),
  ('Isha', 'Verma', '456 DEF Lane, Chennai', '6543210987'),
  ('Rohan', 'Gupta', '890 GHI Nagar, Kolkata', '5432109876');

INSERT INTO Watersupply_board (board_name, location)
VALUES
  ('Mumbai Water Board', 'Mumbai'),
  ('Delhi Water Authority', 'Delhi'),
  ('Bangalore Water Corporation', 'Bangalore'),
  ('Chennai Water Supply', 'Chennai'),
  ('Kolkata Water Works', 'Kolkata');

INSERT INTO Tariffs (tariff_name, rate_per_unit)
VALUES
  ('Residential', 5.50),
  ('Commercial', 8.75),
  ('Industrial', 12.20);

INSERT INTO Account (customer_id, account_number, connection_type, board_id, tariff_id)
VALUES
  (1, 'CUST001', 'Residential', 1, 1),
  (2, 'CUST002', 'Commercial', 2, 2),
  (3, 'CUST003', 'Residential', 3, 1),
  (4, 'CUST004', 'Industrial', 1, 3),
  (5, 'CUST005', 'Residential', 4, 1);

INSERT INTO Billing (account_id, billing_date, total_amount)
VALUES
  (1, '2023-07-15', 1200),
  (2, '2023-07-20', 2500),
  (3, '2023-07-25', 800),
  (4, '2023-08-01', 5000),
  (5, '2023-08-10', 1500);

INSERT INTO Meters (account_id, meter_number, installation_date)
VALUES
  (1, 'MTR001', '2022-05-15'),
  (2, 'MTR002', '2021-11-20'),
  (3, 'MTR003', '2023-01-10'),
  (4, 'MTR004', '2020-07-05'),
  (5, 'MTR005', '2023-03-18');

INSERT INTO Meter_Reading (meter_id, reading_date, units_consumed)
VALUES
  (1, '2023-08-01', 100),
  (2, '2023-08-01', 250),
  (3, '2023-08-01', 50),
  (4, '2023-08-01', 800),
  (5, '2023-08-01', 150);

INSERT INTO Payments (customer_id, payment_date, amount, payment_mode)
VALUES
  (1, '2023-08-05', 1200, 'Online'),
  (2, '2023-08-10', 2500, 'Cash'),
  (3, '2023-08-15', 800, 'Cheque'),
  (4, '2023-08-20', 5000, 'Online'),
  (5, '2023-08-25', 1500, 'Credit Card');

INSERT INTO Invoice (billing_id, invoice_date)
VALUES
  (1, '2023-08-05'),
  (2, '2023-08-10'),
  (3, '2023-08-15'),
  (4, '2023-08-20'),
  (5, '2023-08-25');

INSERT INTO Feedback (customer_id, feedback_text, feedback_date)
VALUES
  (1, 'Excellent service!', '2023-08-07'),
  (2, 'Improvement needed in response time.', '2023-08-12'),
  (3, 'Satisfied with water quality.', '2023-08-17'),
  (4, 'Prompt customer support.', '2023-08-22'),
  (5, 'Billing accuracy appreciated.', '2023-08-27');

-- Queries

-- 1. Average energy consumption
SELECT AVG(units_consumed) AS average_energy_consumption
FROM Meter_Reading;

-- 2. Number of customers by connection type
SELECT connection_type, COUNT(*) AS num_customers
FROM Account
GROUP BY connection_type;

-- 3. Total revenue for August 2023
SELECT SUM(total_amount) AS total_revenue
FROM Billing
WHERE MONTH(billing_date) = 8 AND YEAR(billing_date) = 2023;

-- 4. Total revenue by water supply board
SELECT w.board_name, SUM(b.total_amount) AS total_revenue
FROM Watersupply_board w
INNER JOIN Account a ON w.board_id = a.board_id
INNER JOIN Billing b ON a.account_id = b.account_id
GROUP BY w.board_name;

-- 5. Average satisfaction by water supply board
ALTER TABLE Feedback ADD COLUMN satisfaction_rating INT; -- Assuming satisfaction rating is added

SELECT w.board_name, AVG(f.satisfaction_rating) AS avg_satisfaction
FROM Watersupply_board w
INNER JOIN Account a ON w.board_id = a.board_id
INNER JOIN Feedback f ON a.customer_id = f.customer_id
GROUP BY w.board_name;

-- 6. Average consumption by tariff type
SELECT t.tariff_name, AVG(mr.units_consumed) AS avg_consumption
FROM Tariffs t
INNER JOIN Account a ON t.tariff_id = a.tariff_id
INNER JOIN Meters m ON a.account_id = m.account_id
INNER JOIN Meter_Reading mr ON m.meter_id = mr.meter_id
GROUP BY t.tariff_name;

-- 7. Total due and total paid by account
SELECT a.account_id, SUM(b.total_amount) AS total_due, SUM(p.amount) AS total_paid
FROM Account a
LEFT JOIN Billing b ON a.account_id = b.account_id
LEFT JOIN Payments p ON a.customer_id = p.customer_id
GROUP BY a.account_id;

-- 8. Number of customers by tariff type
SELECT t.tariff_name, COUNT(*) AS num_customers
FROM Tariffs t
INNER JOIN Account a ON t.tariff_id = a.tariff_id
GROUP BY t.tariff_name;

-- 9. Number of customers by water supply board
SELECT w.board_name, COUNT(*) AS num_customers
FROM Watersupply_board w
INNER JOIN Account a ON w.board_id = a.board_id
GROUP BY w.board_name;

-- 10. Total payments by payment mode
SELECT payment_mode, SUM(amount) AS total_payments
FROM Payments
GROUP BY payment_mode;

-- 11. Average consumption per meter for August 2023
SELECT m.meter_number, AVG(mr.units_consumed) AS avg_consumption
FROM Meters m
INNER JOIN Meter_Reading mr ON m.meter_id = mr.meter_id
WHERE MONTH(mr.reading_date) = 8 AND YEAR(mr.reading_date) = 2023
GROUP BY m.meter_number;

-- 12. Top 5 customers by total amount paid
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_amount_paid
FROM Customers c
INNER JOIN Payments p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_amount_paid DESC
LIMIT 5;
