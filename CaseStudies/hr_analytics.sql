select * from departments;
select * from employees;
select * from attendance;

--total number of employees in each department
SELECT 
	COUNT(emp_id) as [Number of employees],
	dept_name
FROM employees JOIN departments on
employees.department_id = departments.department_id
GROUP BY dept_name


-- departments where the average salary is above the company’s overall average salary
SELECT 
AVG(salary) as [Average salary per department],
dept_name
from employees join departments on
employees.department_id = departments.department_id
GROUP BY dept_name
HAVING AVG(salary) > (
	SELECT
	AVG(salary)
	from employees
)

--Highest-paid employee in each department

SELECT 
	emp_name
from (
	SELECT
		e.emp_name,
        e.salary,
        d.dept_name,
		RANK() OVER (PARTITION BY d.dept_name ORDER BY e.salary DESC) AS [RANKING]
	from employees as e
	join departments as d
		on e.department_id = d.department_id
) AS ranked_employees
WHERE RANKING = 1


-- Create a view showing each employee’s salary and the average salary of their department
CREATE VIEW employees_salary_avg_dpt_salary AS 
SELECT
	e.salary,
	AVG(salary) OVER (PARTITION BY d.dept_name) as [Average salary of each department],
	d.dept_name
from departments as d
join employees as e
	on e.department_id = d.department_id; 
GO
SELECT * FROM employees_salary_avg_dpt_salary

--Rank employees by salary within each department
SELECT
	e.emp_name,
    e.salary,
    d.dept_name,
	RANK() OVER (PARTITION BY d.dept_name ORDER BY e.salary DESC) AS [RANKING]
from employees as e
join departments as d
	on e.department_id = d.department_id