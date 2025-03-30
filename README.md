# Retail Order Data Analysis
### Project Overview
Project on retail sales analysis, extracting was done via API, preliminary cleaning in Jupyter Notebook and further uploading and analysis on Microsoft SQL Server.
![image](https://github.com/user-attachments/assets/45095129-5093-4777-8967-fb57b662cb1c)


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

### Data Analysis
```
--which category had the best sales - monthly
WITH cte AS(
SELECT category
	, FORMAT(order_date,'yyyy-MM') AS order_year_month
	, SUM(final_price) as sales
FROM df_orders
GROUP BY category, FORMAT(order_date,'yyyy-MM')
)
SELECT * FROM (
SELECT *
	,ROW_NUMBER() OVER (PARTITION BY category ORDER BY sales DESC) AS rn
FROM cte
) A
WHERE rn =1
```

```
--which sub category had the highest growth of profit YoY 2022 vs 2023 

WITH cte AS(
SELECT 
	sub_category
	,	year(order_date) AS date_year
	,sum(final_price) AS sales
FROM df_orders
GROUP BY sub_category, year(order_date)
	)
,cte2 AS(
SELECT sub_category
	,SUM(CASE WHEN date_year=2022 THEN sales ELSE 0 END) AS sales_2022
	,SUM(CASE WHEN date_year=2023 THEN sales ELSE 0 END) AS sales_2023
FROM cte
GROUP BY sub_category
)
SELECT *
,(sales_2023 - sales_2022)/sales_2022*100
FROM cte2
ORDER BY (sales_2023 - sales_2022)/sales_2022*100 DESC
```
### Results
- We received top - 10 SKU's which were TOP10 regarding the sales data we have
- We discovered which are top 5 SKU's by region regarding the sales data we have
- Received the information of YoY profit movements divided monthly
- Discovered what month was the best for each category
- Determined which category had the largest month-to-month growth between years
