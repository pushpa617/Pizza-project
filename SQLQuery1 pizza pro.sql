select * from pizza_sales

--total revenue
select SUM(total_price) as total_revenue from pizza_sales

--total orders
select max(order_id)
from pizza_sales
 --orr
 select count(distinct order_id)
 from pizza_sales
--average order value (i.e money spent per order so, total revenue/no of orders

select sum(total_price)/MAX(order_id) as avg_order_value
from pizza_sales

--total pizzas sold
select sum(quantity) as total_pizzas
from pizza_sales

--avg pizzas per order
select cast(cast(sum(quantity) as decimal(10,2))/cast(max(order_id) as decimal(10,2)) as decimal(10,2)) as avg_pizza_per_order
from pizza_sales

--daily trend for orders(so we have to find order in days)

select DATENAME(DW,order_date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(DW,order_date)

--monthly trend for orders
select DATENAME(MONTH,order_date) as order_month, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(MONTH,order_date)

--%AGE OF PIZZA by catogiries
select pizza_category,sum( quantity),sum(total_price),cast(sum(total_price) * 100/(select sum(total_price) from pizza_sales) as decimal(10,2)) as percent_per_category
from pizza_sales
group by pizza_category

--if e ant for particular month then
select pizza_category,sum( quantity) as total_quantity_per_cate,sum(total_price) as tot_price_per_cat,cast(sum(total_price) * 100/(select sum(total_price) from pizza_sales where DAY(order_date) = 1) as decimal(10,2)) as percent_per_category
from pizza_sales
--where MONTH(order_date) = 1 AND
where DAY(order_date) = 1
group by pizza_category

--%AGE OF PIZZA by sizes
select pizza_size,sum( quantity),sum(total_price),cast(sum(total_price) * 100/(select sum(total_price) from pizza_sales) as decimal(10,2)) as percent_per_category
from pizza_sales
group by pizza_size

--for quater
select pizza_size,sum( quantity),cast(sum(total_price) as decimal(10,2)),cast(sum(total_price) * 100/(select sum(total_price) from pizza_sales where datepart(quarter,order_date)=1) as decimal(10,2) ) as percent_per_category
from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size

--total pizzas sold per category
select pizza_category,sum(quantity)
from pizza_sales
group by pizza_category

--top 5 best sellers by revenue
select top 5 pizza_name,sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc

--bottom 5 by revenue
select top 5 pizza_name,cast(sum(total_price) as decimal(10,2)) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue asc
----top 5 best sellers by quantity
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

--bottom 5 best sellers by quantity
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold asc
--top 5 best sellers by total orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--bottom 5 best sellers by total orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders asc

