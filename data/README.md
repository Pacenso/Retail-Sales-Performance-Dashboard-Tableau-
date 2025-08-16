# Data Dictionary

This dataset was downloaded from [Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final).
It contains data about a fictitious superstore.  I created a subset of 5 metrics to focus on analyzing sales trends by region over time.
To create the subset, I wrote a Python script using Pandas to specify which metrics I wanted to include and to re-format column names to increase usability for SQL.
This script can be found [here](scripts/create_subset.py)

The columns I decided to work with are described below:

- order date:
    - date an order was placed in the format of YYYY-MM-DD
- region:
    - region in which the store that fulfilled the sale was located
    - north, south, east, or west
- product category:
    - the category of item the product falls under
    - technology, Furniture, or office supplies
- sales:
    - how much money was made when in a sale
- profit:
    - how much of a profit was made from a sale


