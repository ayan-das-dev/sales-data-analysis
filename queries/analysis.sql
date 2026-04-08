/*Total sales per city*/
SELECT 
    city,
    SUM(final_amount) AS total_sales
FROM orders
GROUP BY city;

/*Total sales per category*/
SELECT 
    category,
    SUM(final_amount) AS total_sales
FROM orders
GROUP BY category;

/*Average order value per city*/
SELECT 
    city,
    AVG(final_amount) AS avg_order_value
FROM orders
GROUP BY city;

/*Total orders per customer*/
SELECT 
    customer_name,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_name;

/*Top 3 customers by total spending */
SELECT 
    customer_name,
    SUM(final_amount) AS total_spent
FROM orders
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 3;

/*City with highest sales*/
select city,SUM(final_amount) AS highest_sale_amount
FROM orders
GROUP BY city
ORDER BY highest_sale_amount DESC
LIMIT 1;

/*Product generating highest revenue*/
SELECT 
    product,
    SUM(final_amount) AS total_revenue
FROM orders
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 1;

/*Total discount given per category*/
SELECT 
    category,
    SUM(discount) AS total_discount
FROM orders
GROUP BY category;

/*Rank customers by spending*/
SELECT 
    customer_name,
    SUM(final_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(final_amount) DESC) AS ranks
FROM orders
GROUP BY customer_name;


/*Running total of sales by date*/
SELECT 
    order_date,
    SUM(final_amount) AS daily_sales,
    SUM(SUM(final_amount)) OVER (ORDER BY order_date) AS running_total
FROM orders
GROUP BY order_date;

/*Top order per city*/
SELECT *
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY final_amount DESC) AS rn
    FROM orders
) t
WHERE rn = 1;

/*Percentage contribution of each category*/
SELECT 
    category,
    SUM(final_amount) AS category_sales,
    ROUND(
        SUM(final_amount) * 100.0 / SUM(SUM(final_amount)) OVER (),
        2
    ) AS percentage_contribution
FROM orders
GROUP BY category;


/*Find repeat customers*/
select customer_name,customer_id from
(select *, row_number() over (partition by customer_name) as count
from orders) a
where count>1;


/*Difference between current and previous order*/
SELECT 
    customer_name,
    order_date,
    final_amount,
    LAG(final_amount) OVER (
        PARTITION BY customer_name 
        ORDER BY order_date
    ) AS previous_order,
    final_amount - LAG(final_amount) OVER (
        PARTITION BY customer_name 
        ORDER BY order_date
    ) AS difference
FROM orders
ORDER BY customer_name, order_date;
