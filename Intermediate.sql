-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category, SUM(order_details.quantity) AS Total_Quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 1
ORDER BY 2 DESC;

-- Determine the distribution of orders by hour of the day.
-- I just sorted the high number of orders based on the hours so we get an insight on what approximate time we get most order
-- For instance here highest number of order here are around 12'oclock

SELECT 
    HOUR(order_time) AS `Hour`, COUNT(order_id) AS No_of_orders
FROM
    orders
GROUP BY 1
ORDER BY 2 DESC;

-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(pizza_type_id)
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

WITH cte_average AS
(SELECT 
    order_date, SUM(quantity) AS sum_quantity
FROM
    order_details
        JOIN
    orders ON order_details.order_id = orders.order_id
GROUP BY order_date)
SELECT 
    ROUND(AVG(sum_quantity), 0) AS avg_order_per_day
FROM
    cte_average;
    
-- Determine the top 3 most ordered pizza types based on revenue.
WITH cte_revenue_table AS
	(SELECT 
    pizza_types.name AS Pizza_name,
    order_details.quantity * pizzas.price AS Total_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id)
SELECT 
    Pizza_name, SUM(Total_revenue)
FROM
    cte_revenue_table
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

