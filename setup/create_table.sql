CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id VARCHAR(10),
    customer_name VARCHAR(50),
    city VARCHAR(50),
    order_date DATE,
    product VARCHAR(50),
    category VARCHAR(50),
    amount INT,
    discount INT,
    final_amount INT
);