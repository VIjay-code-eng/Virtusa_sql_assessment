CREATE TABLE Client(
    customer_id INT,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Product_list (
    product_id INT,
    name VARCHAR(50),
    category VARCHAR(50),
    price INT
);

CREATE TABLE Order_list (
    order_id INT,
    customer_id INT,
    date DATE
);

CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO Client VALUES
(1, 'Vijay', 'Hyderabad'),
(2, 'Ramu', 'Mumbai'),
(3, 'Anji', 'Delhi');

INSERT INTO Product_list VALUES
(101, 'Shoes', 'Fashion', 1000),
(102, 'Mobile', 'Electronics', 15000),
(103, 'Bag', 'Fashion', 800);

INSERT INTO Order_list VALUES
(201, 1, '2026-04-10'),
(202, 2, '2026-04-11'),
(203, 1, '2026-04-12');

INSERT INTO Order_Items VALUES
(201, 101, 2),
(202, 102, 1),
(203, 103, 3);

SELECT p.name, SUM(oi.quantity) AS total_sold
FROM Product_list p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_sold DESC;

SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM Product_list p
JOIN Order_Items oi ON p.product_id = oi.product_id;

SELECT p.category, SUM(p.price * oi.quantity) AS category_sales
FROM Product_list p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.category;

SELECT c.name, SUM(p.price * oi.quantity) AS total_spent
FROM Client c
JOIN Order_list o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Product_list p ON oi.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC;

SELECT strftime('%m', date) AS month,
SUM(p.price * oi.quantity) AS revenue
FROM Order_list o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Product_list p ON oi.product_id = p.product_id
GROUP BY month;
