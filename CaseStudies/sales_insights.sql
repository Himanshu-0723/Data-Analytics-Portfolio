--top 3 cities with the highest total revenue 
select TOP 3 city 
from customers 
join orders 
	on customers.customer_id = orders.customer_id 
order by total_amount desc


--month-over-month (MoM) revenue growth for the last 6 months
WITH monthly_revenue AS (
    SELECT
        FORMAT(order_date, 'yyyy-MM') AS month,
        SUM(total_amount) AS total_revenue
    FROM orders
    GROUP BY FORMAT(order_date, 'yyyy-MM')
)
SELECT
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND(
        ((total_revenue - LAG(total_revenue) OVER (ORDER BY month)) 
         / NULLIF(LAG(total_revenue) OVER (ORDER BY month), 0) * 100), 2
    ) AS MoM_growth_percent
FROM monthly_revenue
ORDER BY month;


--most sold product category by quantity 
select 
	sum(quantity) as [Number of products sold], 
	category 
from order_items 
join products 
	on order_items.product_id = products.product_id 
group by category 
order by sum(quantity) desc


--customers who haven’t ordered in the last 3 months 
select 
	customer_name, 
	order_date 
from customers 
left join orders 
	on customers.customer_id = orders.customer_id 
where 
	order_date not between '2025-07-01' and '2025-10-31'


--rank customers by total spending 
select 
	customer_name, 
	rank() over (order by total_amount desc) as [Rank], 
	total_amount 
from customers 
join orders 
	on customers.customer_id = orders.customer_id