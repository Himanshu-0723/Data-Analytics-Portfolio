select * from customers;
select * from products;
select * from orders;
select * from order_items;
select * from returns;


--top 3 cities by total sales amount
SELECT
	c.city,
	SUM(p.price * oi.quantity) as [Total Sales]
FROM customers c
JOIN orders o
	on c.customer_id = o.customer_id
JOIN order_items oi
	on o.order_id = oi.order_id
JOIN products p
	on oi.product_id = p.product_id
GROUP BY c.city
ORDER BY [Total Sales] DESC


--Monthly revenue trend (with month-on-month %)