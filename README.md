# Retail Order Data Analysis
### Project Overview
Project on retail sales analysis, extracting was done via API, preliminary cleaning in Jupyter Notebook and further uploading and analysis on Microsoft SQL Server.

### Data Sources
The original data was extracted from [Kaggle](https://www.kaggle.com/datasets/ankitbansal06/retail-orders)

### Tools
- Jupyter Notebook - extract and transform data
- Microsoft SQL Server/Management Studio - to store and analyse the data

### Data Cleaning / Preparation
- Export the zip file directly from Kaggle using API
- Extract csv database using Python library zipfile
- Adjusting the formatting to the headers
- Correcting datetime format
- Calculating additional columns - discount, sale price and marginality
- Deletion of the columns which are not needed anymore
- Creating an empty table in MSSQL Studio to store the data with format and columns needed 
- Load the data to the MSSQL local server using sqlalchemy Python library with append method

### Exploratory Analysis 
- Top 10 by sales?
- Top 5 products in each region?
- MoM growth for 2022 vs 2023?
- Which category had the best sales - monthly?
- Which sub category had the highest growth of profit YoY 2022 vs 2023?
