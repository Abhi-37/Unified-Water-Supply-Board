# UnifiedWaterSupplyBoard
This SQL script creates the database schema for the Unified Water Supply Board, including tables for customers, accounts, billing, meters, meter readings, tariffs, water supply boards, payments, invoices, and feedback. It also inserts sample data and provides example queries to retrieve various statistics and reports from the database.

# Unified Water Supply Billing System for Karnataka

## Introduction
This project aims to create a unified water supply billing system for Karnataka. The database schema is designed to manage customer information, billing, meter readings, payments, feedback, and other relevant data related to water supply management.

## Database Schema
The database schema consists of the following tables:

- Customers: Stores customer information such as name, address, and contact number.
- Watersupply_board: Contains information about water supply boards, including board name and location.
- Tariffs: Defines different tariff types for water supply.
- Account: Links customers with water supply boards and tariffs, along with account details.
- Billing: Records billing information such as billing date and total amount.
- Meters: Manages meter details including installation date and meter number.
- Meter_Reading: Stores meter reading data including reading date and units consumed.
- Payments: Tracks payments made by customers including payment date, amount, and payment mode.
- Invoice: Records invoice details linked to billing information.
- Feedback: Stores customer feedback including feedback text and date.

## Queries
The database supports various queries to extract useful information for water supply management:

1. Average energy consumption: Calculates the average units consumed across all meter readings.
2. Number of customers by connection type: Counts the number of customers grouped by their connection type (e.g., residential, commercial, industrial).
3. Total revenue for August 2023: Calculates the total revenue generated from billing in August 2023.
4. Total revenue by water supply board: Calculates the total revenue generated from billing for each water supply board.
5. Average satisfaction by water supply board: Calculates the average satisfaction rating provided by customers for each water supply board.
6. Average consumption by tariff type: Calculates the average units consumed grouped by tariff type.
7. Total due and total paid by account: Calculates the total due and total paid for each customer account.
8. Number of customers by tariff type: Counts the number of customers grouped by tariff type.
9. Number of customers by water supply board: Counts the number of customers linked to each water supply board.
10. Total payments by payment mode: Calculates the total payments made grouped by payment mode.
11. Average consumption per meter for August 2023: Calculates the average units consumed per meter for August 2023.
12. Top 5 customers by total amount paid: Lists the top 5 customers based on the total amount they have paid.



