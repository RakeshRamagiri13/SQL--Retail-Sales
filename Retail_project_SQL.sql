--SQl Retail Sales Project 
create database sql_project_1


--Create table 
drop table if exists retail_sales
create table retail_sales (
transactions_id	 int,
sale_date date,
sale_time time,
customer_id int,
gender	varchar(15),
age int,
category varchar,
quantiy int,
price_per_unit float,
cogs FLOAT,
total_sale FLOAT
);

select * from retail_sales

--sample Data view

select * from retail_sales
limit 10;

--Check Null Values (Data Cleaning)
select * from retail_sales
where
transactions_id is null
OR 
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
OR
age is  null
OR
category is null
OR
quantiy is null
OR
price_per_unit is null
OR
cogs is null 
OR
total_sale is null;

--Delete Null Values
delete from retail_sales
where
transactions_id is null
OR 
sale_date is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
OR
age is  null
OR
category is null
OR
quantiy is null
OR
price_per_unit is null
OR
cogs is null 
OR
total_sale is null;

--Data Exploration 

--1.How Many sales we Have?

select count(*) as Total_saless
from  retail_sales;

--2. How Many  Unique Customers We Have?

select count(distinct customer_id) as Total_customers
from retail_sales;

--3. How Many Number of Categories?

select distinct category as Total_categories
from retail_sales;

--Data Analysis And Key Business Problems

--1.Write a SQL Query to retrive all columns for Sales Made on '2022-11-05'

select *
from retail_sales
where sale_date ='2022-11-05'

--2..Write a SQL Query to retrive all transactions where the categoery is 'clothing' and the quantity  sold is  more than 10 in the month of Nov-2022
 
 select
 * 
 from retail_sales 
 where category='Clothing'
 and quantiy >= 4
 AND EXTRACT(YEAR FROM sale_date) = 2022
 AND EXTRACT(MONTH FROM sale_date) = 11;
 
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
category,
sum(total_sale) as net_sale,
count (*) as total_orders
from retail_sales
group by 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
round(avg(age),2)
from retail_sales
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *  from retail_sales
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category,gender,
count(*) as total_tans
from retail_sales 
group by
category,
gender
order by 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

select 
year,month,
avg_sale
from
(
select 
EXTRACT(YEAR FROM sale_date) as year,
EXTRACT(MONTH FROM sale_date) as month,
AVG(total_sale) as avg_sale,
RANK () OVER(PARTITION BY EXTRACT(YEAR FROM  sale_date)ORDER BY AVG(total_sale) DESC ) as rank from 
retail_sales
group by 1,2
) as t1
where rank = 1


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

select customer_id,
sum(total_sale) as total_sales
from retail_sales 
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category,
count(distinct customer_id) as unique_customers
from retail_sales
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
AS
(
select *,
    case
	WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Moning'
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	End As Shift
from retail_sales
)
select shift,
count (*) as total_orders
from hourly_sale
group by shift

--END OF PROJECT...
		


