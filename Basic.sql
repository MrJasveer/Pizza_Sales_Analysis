-- Retrieve the total number of orders placed.

SELECT COUNT(order_id) AS Total_Orders
FROM orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    SUM(order_details.quantity * pizzas.price) AS Total_Revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;
    
-- The below Query rounds off the revenue to 2 digits

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),2) AS Total_Revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;    
    
-- Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price AS Highest_Pizza_Price
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY 2 DESC
LIMIT 1;

-- Identify the most common pizza size ordered.

SELECT 
    size, COUNT(size)
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size
ORDER BY COUNT(size) DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_details.quantity)
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
