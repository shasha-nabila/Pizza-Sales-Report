-------------------------------
-- Pizza Sales Data Analysis --
-------------------------------

--View table
SELECT * from pizza_sales


-- *******************************
-- ANALYSIS FOR KPI's REQUIREMENTS
-- *******************************

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue from pizza_sales

-- Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value from pizza_sales

-- Total Pizza Sold
SELECT SUM(quantity) AS Total_Pizza_Sold from pizza_sales

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales

-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_Per_Order from pizza_sales


-- *********************************
-- ANALYSIS FOR CHART's REQUIREMENTS
-- *********************************

-- Hourly Trend for Total Pizzas Sold
SELECT DATEPART(HOUR, order_time) AS Order_Hour, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

-- Weekly Trend for Total Orders
SELECT DATEPART(ISO_WEEK, order_date) AS Week_Number, YEAR(order_date) AS Order_Year,
COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)

-- Percentage of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2))
AS Percentage_Sales FROM pizza_sales
GROUP BY pizza_category

-- Percentage of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2))
AS Percentage_Sales FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

-- Top 5 Best Sellers by Revenue, Total Quantity and Total Orders
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Order 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Order DESC

-- Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Order 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Order