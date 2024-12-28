-- Calculate the percentage contribution of each pizza type category to total revenue.

WITH cte_revenue_table AS
	(SELECT 
    pizza_types.category AS Pizza_category,
    pizzas.price AS Pizza_Price,
    order_details.quantity * pizzas.price AS Total_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id)
SELECT 
    Pizza_category, ROUND(SUM(Total_revenue) / (SELECT ROUND(SUM(order_details.quantity * pizzas.price),0)
FROM order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100, 0)  as Percentage_Contribution
FROM
    cte_revenue_table
GROUP BY 1
ORDER BY Percentage_Contribution DESC;

-- Analyze the cumulative revenue generated over time.
SELECT order_date, revenue, sum(revenue) OVER(ORDER BY order_date) AS Cum_Rev
FROM
(SELECT 
    orders.order_date,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY 1) AS sales_table;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT *
FROM
(WITH cte_revenue_table AS
	(SELECT
    pizza_types.name AS Pizza_Name,
    pizza_types.category AS Pizza_Category,
    order_details.quantity * pizzas.price AS Total_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id)
SELECT 
    Pizza_Category, Pizza_Name, SUM(Total_revenue) AS Sum_Total_Revenue, RANK() OVER(PARTITION BY Pizza_Category ORDER BY SUM(Total_Revenue) DESC) AS Ranking
FROM
    cte_revenue_table
GROUP BY 1, 2) AS table_1
WHERE Ranking <=3;