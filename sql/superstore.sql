/*
	Create the table with necessary columns and data-types
	If the table already exists, don't create it
*/
CREATE TABLE IF NOT EXISTS superstore (
	order_id SERIAL PRIMARY KEY,
	order_date DATE,
	region VARCHAR(50),
	product_category VARCHAR(50),
	sales NUMERIC,
	profit NUMERIC
);

-- Add in data from CSV to newly created table
COPY superstore(order_date, region, product_category, sales, profit)
FROM 'C:\Users\Admin\Desktop\BI Analyst Practice\Superstore\Superstore_subset.csv'
DELIMITER ',' -- Data separated by a ,
CSV HEADER;

-- Test that the data was imported successfully
SELECT * FROM superstore LIMIT 10;

-- Gets the total sales, profits, and average profit margin
SELECT
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profits,
	ROUND(AVG(profit / sales), 4) * 100 AS avg_profit_margin
FROM superstore;

/* 
Sales by region - Bar Chart or Heatmap
	Group by SELECTING the columns I want (region and product category) to analyze each combo 
	Aggregate the total sales and profits for each region/category combo
	Makes sure that the SUM of each combo (GROUP BY) is taken, not the sum of everything in the table
	ORDER BY highest to lowest value
*/
SELECT region, product_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY region, product_category
ORDER BY total_sales DESC;

/* 
Sales over time (montly) - Line Chart
	DATE_TRUNC convert each order date to the first day of its month; YYYY-MM-01 = the total sales for that month
	Add up the sales for each month
	GROUP BY each month
	ORDER BY chronologically
*/
SELECT DATE_TRUNC('month', order_date) AS month, SUM(sales) AS total_sales
FROM superstore
GROUP BY month
ORDER BY month;

/*
Profit margins by category - Bar chart for ranking profitability
	Calculate profit margin as a percentage
	GROUP BY product category
	ORDER BY highest to lowest
*/
SELECT product_category,
	SUM(profit)/SUM(sales)*100 AS profit_margin_percent
FROM superstore
GROUP BY product_category
ORDER BY profit_margin_percent DESC;

/* Year over year growth - Multi-series line chart for each product category
	EXTRACT the year from each order date
	Include product category column
	Calculate total sales for the year and product category
	Calculate year-over-year growth percentage
		LAG looks at previous row's value
		PARTITION BY product category makes sure the LAG is calculating by product category, not across all categories
	GROUP BY to aggregate bt sales per year and category
	ORDER BY year (old to new) and the product category
*/
SELECT EXTRACT(YEAR FROM order_date) AS year,
	product_category,
	SUM(sales) AS total_sales,
	LAG(SUM(sales)) OVER (PARTITION BY product_category ORDER BY EXTRACT(YEAR FROM order_date)) AS previous_year_sales,
	((SUM(sales) - LAG(SUM(sales)) OVER (PARTITION BY product_category ORDER BY EXTRACT(YEAR FROM order_date)))/
	LAG(SUM(sales)) OVER (PARTITION BY product_category ORDER BY EXTRACT(YEAR FROM order_date)))*100 AS	yoy_growth
FROM superstore
GROUP BY year, product_category
ORDER BY year, product_category;

