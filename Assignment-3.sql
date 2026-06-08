SELECT * FROM csi3.`sample - superstore`;
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);
INSERT INTO customers
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM superstore_raw;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    sub_category VARCHAR(100)
);

INSERT INTO products
SELECT
    product_id,
    MAX(product_name),
    MAX(category),
    MAX(sub_category)
FROM superstore_raw
GROUP BY product_id;
	

DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(50),
    order_date DATE,
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,2)
);
INSERT INTO orders
SELECT
    CAST(row_id AS UNSIGNED),
    order_id,
    STR_TO_DATE(order_date,'%m/%d/%Y'),
    customer_id,
    product_id,
    REPLACE(sales, ',', '') + 0,
    CAST(quantity AS UNSIGNED),
    REPLACE(discount, ',', '') + 0,
    REPLACE(profit, ',', '') + 0
FROM superstore_raw;
select * from orders;
select * from customers;
SELECT *
FROM orders
WHERE sales >
(
    SELECT AVG(sales)
    FROM orders
);
SELECT *
FROM orders o
WHERE sales =
(
    SELECT MAX(sales)
    FROM orders o2
    WHERE o.customer_id = o2.customer_id
);
WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_sales;
WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
);
WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM customer_sales;
SELECT
    customer_id,
    order_id,
    sales,
    ROW_NUMBER() OVER
    (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS order_number
FROM orders;
WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM
(
    SELECT
        customer_id,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM customer_sales
) x
WHERE sales_rank <= 3;

WITH customer_sales AS
(
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)

SELECT
    c.customer_name,
    cs.total_sales,
    RANK() OVER (ORDER BY cs.total_sales DESC) AS customer_rank
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id;
WITH customer_sales AS
(
    SELECT
        c.customer_name,
        SUM(o.sales) AS total_sales
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
)

SELECT *
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 5;
WITH customer_sales AS
(
    SELECT
        c.customer_name,
        SUM(o.sales) AS total_sales
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
)

SELECT *
FROM customer_sales
ORDER BY total_sales ASC
LIMIT 5;
SELECT
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT o.order_id) = 1;
WITH customer_sales AS
(
    SELECT
        c.customer_name,
        SUM(o.sales) AS total_sales
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
)

SELECT *
FROM customer_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
);
SELECT
    c.customer_name,
    MAX(o.sales) AS highest_order_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY highest_order_value DESC;