--top 10 by sales
select top 10 product_id, sum(final_price) as sales 
from df_orders
group by product_id 
order by sales desc


--top 5 products in each region
with cte as(
select region, product_id, sum(final_price) as sales 
from df_orders
group by region, product_id)
select * from(
select *
, row_number() over(partition by region order by sales desc) as rn
from cte) A
where rn<=5

--MoM growth for 2022 vs 2023
with cte as(
select 
	year(order_date) as date_year
	,sum(final_price) as sales
	, month(order_date) as date_month
from df_orders
group by year(order_date),month(order_date)
	)
select date_month
	,sum(case when date_year=2022 then sales else 0 end) as sales_2022
	,sum(case when date_year=2023 then sales else 0 end) as sales_2023
	,sum(case when date_year=2023 then sales else 0 end) - sum(case when date_year=2022 then sales else 0 end) as mom_growth
from cte
group by date_month
order by date_month



--which category had the best sales - monthly
with cte as(
select category
	, format(order_date,'yyyy-MM') as order_year_month
	, sum(final_price) as sales
from df_orders
group by category, format(order_date,'yyyy-MM')
)
select * from (
select *
	,ROW_NUMBER() over (partition by category order by sales desc) as rn
from cte
) A
where rn =1


--which sub category had the highest growth of profit YoY 2022 vs 2023 

with cte as(
select 
	sub_category
	,	year(order_date) as date_year
	,sum(final_price) as sales
from df_orders
group by sub_category, year(order_date)
	)
,cte2 as(
select sub_category
	,sum(case when date_year=2022 then sales else 0 end) as sales_2022
	,sum(case when date_year=2023 then sales else 0 end) as sales_2023
from cte
group by sub_category
)
select *
,(sales_2023 - sales_2022)/sales_2022*100
from cte2
order by (sales_2023 - sales_2022)/sales_2022*100 desc