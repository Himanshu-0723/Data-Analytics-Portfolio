select * from patients;
select * from doctors;
select * from visits;
select * from bills;

-- top 5 doctors by total billed amount
select 
	top 5 d.doctor_id,
	d.name as [Name],
	sum(b.total_amount) as [Total Amount]
from doctors d 
join visits v
	on d.doctor_id = v.doctor_id
join bills b
	on v.visit_id = b.visit_id
group by d.doctor_id, [Name]
order by [Total Amount] desc


--average patient age per doctor.
SELECT 
AVG(p.age) as [Average Patient age],
d.name as [Doctor name]
from patients p
join visits v 
	on p.patient_id = v.patient_id
join doctors d
	on d.doctor_id = v.doctor_id
GROUP BY d.name
ORDER BY [Average Patient age] desc


--patients with more than 3 visits in the last 6 months
WITH CTE1 AS(
	SELECT
		p.name, 
		COUNT(*) as [Number of visits]
	FROM visits v
	join patients p
		on v.patient_id = p.patient_id
	WHERE DATEDIFF(MONTH, visit_date, GETDATE()) <= 6
	GROUP BY name
	
)
SELECT 
name
FROM CTE1
WHERE [Number of visits] >= 3


--revenue trend per specialization (monthly)
WITH monthly_revenue AS(
	SELECT
		d.specialization,
		SUM(b.total_amount) as total_revenue,
		FORMAT(v.visit_date, 'yyyy-MM') as month_year
	FROM bills b
	JOIN visits v ON b.visit_id = v.visit_id
	JOIN doctors d ON v.doctor_id = d.doctor_id
	GROUP BY d.specialization, FORMAT(v.visit_date, 'yyyy-MM')
),
CTE2 AS(
	SELECT
		specialization,
		month_year,
		total_revenue,
		LAG(total_revenue) OVER(
			PARTITION BY specialization 
			ORDER BY month_year
		)AS prev_month_revenue
	FROM monthly_revenue
)
SELECT 
	specialization,
	month_year,
	total_revenue,
	prev_month_revenue,
	(total_revenue - prev_month_revenue) as revenue_change
FROM CTE2


--doctors who have no visits in the last 2 months
SELECT
    d.doctor_id,
    d.name,
    MAX(v.visit_date) AS last_visit
FROM doctors d
LEFT JOIN visits v
    ON d.doctor_id = v.doctor_id
GROUP BY d.doctor_id, d.name
HAVING
	MAX(v.visit_date) is NULL
	OR
	DATEDIFF(MONTH, MAX(v.visit_date), GETDATE()) >= 2
