# SQL Query Breakdown

Query 1 - Setup:
1. Create a table named superstore
  - If one already exists, skip this
2. Copy all the data from the CSV-formatted dataset into the table
3. Test that the data was copied correctly by outputting the first 10 rows

Query 2 - Sales by Region:
1. Group data by region and the product category, and sum the sales as total sales and profits as total profits
2. Group and order results by region first, then product category, and sort them from largest to smallest

Query 3 - Sales Over Time (monthly):
1. Convert dates to a truncated version so that all dates only appear as the first of the month. This allows for easier grouping since specific dates are unnecessary for this analysis
  - i.e. Jan 23 = Jan 1
2. Group and order results by month to get a month-by-month visual

Query 4 - Profit Margins by Category:
1. Divide total sales by total profit and multiply by 100 to get a percentage
2. Group by product category in decreasing order of profit margin percentage to see which product category fetches the highest profit

Query 5 - Year Over Year Growth:
1. Extract the year from each order date, as more detail is unnecessary for this analysis
2. Calculate the total sales for the year in each product category
3. Calculate the year-over-year growth by taking into account the previous years' totals
  - LAG() function takes into account the previous year
  - PARTITION BY so that LAG() calculates using the product category rather than all categories as a whole
4. Group by year and then by product category
5. Order by year (old to new) and product category

