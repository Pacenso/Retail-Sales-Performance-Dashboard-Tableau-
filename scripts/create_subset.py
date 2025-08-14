import pandas as pd

# 1. Load the full Superstore CSV file
df = pd.read_csv("Superstore/Superstore.csv", encoding='cp1252')

# 2. Select only the columns that I want/need
subset = df[['Order Date', 'Region', 'Category', 'Sales', 'Profit']]

# 3. Rename columns to remove spaces and make them PostgreSQL formatted
subset = subset.rename(columns={
    'Order Date': 'Order_Date',
    'Category': 'Product_Category'
})

# 4. Convert 'Order Date' to YYYY-MM-DD format (PostgreSQL formatted)
subset['Order_Date'] = pd.to_datetime(subset['Order_Date']).dt.strftime('%Y-%m-%d')

# 5. Save as a new CSV to import into PostgreSQL
subset.to_csv("Superstore/Superstore_subset.csv", index=False)
print("Subset Created Successfully!")
