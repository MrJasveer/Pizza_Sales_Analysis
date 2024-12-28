create database pizzahut;

CREATE TABLE orders (
order_id INT NOT NULL,
order_date DATE NOT NULL,
order_time TIME NOT NULL,
primary key (order_id));

DROP TABLE IF EXISTS order_details;

-- I wrote the above query because by mistake I made pizza_id as a INT instead of TEXT

CREATE TABLE order_details (
order_details_id INT NOT NULL,
order_id INT NOT NULL,
pizza_id TEXT NOT NULL,
quantity INT NOT NULL,
primary key (order_details_id));