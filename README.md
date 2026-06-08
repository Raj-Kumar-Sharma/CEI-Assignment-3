# Week 3 Assignment – SQL Sales Analysis Using Subqueries, CTEs, and Window Functions

## Overview

This project demonstrates advanced SQL analysis techniques using the Superstore Sales Dataset. The objective is to analyze customer sales behavior and generate business insights by applying:

* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* Joins
* Aggregations
* Ranking Functions

The dataset is first imported into MySQL using Python and then normalized into multiple relational tables for analysis.

---

# Project Objectives

The primary goals of this project are:

1. Import the Superstore dataset into MySQL.
2. Create normalized database tables.
3. Perform analytical SQL queries using:

   * Subqueries
   * CTEs
   * Window Functions
4. Generate customer sales insights.
5. Identify top-performing and low-performing customers.
6. Rank customers based on sales contribution.

---

# Technologies Used

| Technology       | Purpose                      |
| ---------------- | ---------------------------- |
| Python           | Data Import Automation       |
| Pandas           | CSV Processing               |
| MySQL Connector  | Database Connectivity        |
| MySQL 8+         | Data Storage and Analysis    |
| SQL              | Data Querying                |
| Jupyter Notebook | Python Execution Environment |
| GitHub           | Version Control              |

---

# Dataset

Dataset Used:

**Sample - Superstore.csv**

The dataset contains information related to:

* Orders
* Customers
* Products
* Sales
* Discounts
* Profit
* Categories
* Regions

---

# Project Structure

```text
├── main.ipynb
├── Assignment-3.sql
├── Sample - Superstore.csv
├── Assignment-3.pdf
└── README.md
```

---

# Step 1: Data Import Using Python

The file `main.ipynb` performs the following tasks:

### Database Connection

Connects Python to MySQL using:

```python
mysql.connector
```

### CSV Reading

Loads the Superstore dataset using:

```python
pandas.read_csv()
```

### Column Cleaning

Automatically formats column names by:

* Removing spaces
* Removing special characters
* Standardizing naming conventions

### Dynamic Table Creation

The script:

1. Detects column datatypes.
2. Creates the MySQL table automatically.
3. Inserts all CSV records into MySQL.

### Validation

Verifies successful import using row count checks.

---

# Database Schema

## 1. Customers Table

Stores customer information.

```sql
customers
```

Columns:

* customer_id
* customer_name
* segment

---

## 2. Products Table

Stores product information.

```sql
products
```

Columns:

* product_id
* product_name
* category
* sub_category

---

## 3. Orders Table

Stores transactional order data.

```sql
orders
```

Columns:

* row_id
* order_id
* order_date
* customer_id
* product_id
* sales
* quantity
* discount
* profit

---

# Data Normalization

Data is extracted from:

```sql
superstore_raw
```

and inserted into normalized tables using:

```sql
INSERT INTO ... SELECT DISTINCT
```

This reduces redundancy and improves query performance.

---

# SQL Analysis Performed

## 1. Orders Greater Than Average Sales

### Concept Used

Subquery

### Purpose

Identify orders whose sales exceed the overall average sales.

### Business Value

Helps identify high-value transactions.

---

## 2. Highest Sales Order Per Customer

### Concept Used

Correlated Subquery

### Purpose

Find the maximum order value placed by every customer.

### Business Value

Identifies premium purchases.

---

## 3. Total Sales Per Customer

### Concept Used

Common Table Expression (CTE)

### Purpose

Calculate cumulative sales for each customer.

### Business Value

Understand customer contribution.

---

## 4. Customers With Above Average Sales

### Concept Used

CTE + Subquery

### Purpose

Compare each customer's total sales against overall average customer sales.

### Business Value

Identify high-value customers.

---

## 5. Customer Ranking

### Concept Used

Window Function

```sql
RANK()
```

### Purpose

Rank customers according to total sales.

### Business Value

Supports customer segmentation.

---

## 6. Order Sequencing

### Concept Used

Window Function

```sql
ROW_NUMBER()
```

### Purpose

Assign sequential order numbers within each customer.

### Business Value

Analyze customer ordering patterns.

---

## 7. Top 3 Customers

### Concept Used

Window Function + Ranking

### Purpose

Identify the highest revenue-generating customers.

### Business Value

Supports loyalty and retention strategies.

---

# Final Combined Query

Combines:

* JOIN
* CTE
* Window Function

Output:

| Customer Name | Total Sales | Rank |
| ------------- | ----------- | ---- |

This provides a complete customer performance report.

---

# Mini Project: Customer Sales Insights

The following business questions were answered.

## Top 5 Customers

Identifies customers generating maximum revenue.

---

## Bottom 5 Customers

Identifies customers with the lowest sales contribution.

---

## Customers With Only One Order

Highlights customers who have purchased only once.

Useful for retention campaigns.

---

## Customers With Above Average Sales

Identifies customers who outperform the average customer.

---

## Highest Order Value Per Customer

Determines the maximum purchase amount made by each customer.

---

# Key SQL Concepts Demonstrated

## Subqueries

Used for:

* Average sales comparison
* Maximum order identification

---

## Common Table Expressions (CTEs)

Used for:

* Reusable intermediate datasets
* Customer sales aggregation

---

## Window Functions

Used for:

### RANK()

Customer ranking.

### ROW_NUMBER()

Order sequencing within customers.

---

# Business Insights

### Insight 1

A small percentage of customers contributes a significant portion of total revenue.

### Insight 2

Several customers place only one order, indicating opportunities for customer retention.

### Insight 3

Customers with above-average sales should be targeted through loyalty programs.

### Insight 4

Customer ranking helps identify VIP and strategic customers.

### Insight 5

Highest-order-value analysis helps understand premium purchasing behavior.

---

# Learning Outcomes

After completing this project, the following concepts were mastered:

* Data Import Automation with Python
* MySQL Database Design
* Data Normalization
* SQL Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* Customer Analytics
* Sales Analysis
* Business Intelligence Reporting

---

# Author

**Pranjal Upadhyay**

B.Tech – Computer Science (AI & Data Science)

Project: Week 3 Assignment – SQL Sales Analysis Using Subqueries, CTEs, and Window Functions
