# 🧠 SQL Case Studies – Data Analyst Portfolio

This repository contains 6 SQL case studies and 1 mini project designed to strengthen my data analytics and SQL problem-solving skills.
Each case covers real-world business scenarios across domains like sales, HR, healthcare, e-commerce, and entertainment.

---

# 📂 Folder Structure
```
data-analyst-portfolio/
│
├── case_studies/
│   ├── case1_sales_insights.sql
│   ├── case2_hr_analytics.sql
│   ├── case3_ecommerce_analytics.sql
│   ├── case4_hospital_analytics.sql
│   ├── case5_movie_ratings.sql
│   └── final_sales_performance_project.sql
│
├── datasets/         # (optional) mock CSV data files
├── visuals/          # dashboard images / charts
└── README.md
```

---


# 🧩 Case Study 1 – Sales Insights

Tables: orders, customers, order_items, products
Key Focus: Joins, Aggregations, Ranking
Highlights:

- Found top 3 cities by revenue.

- Calculated month-over-month revenue growth using LAG().

- Identified customers inactive for 3 months.

- Ranked customers by total spending.

---

# 🧩 Case Study 2 – HR Analytics

Tables: employees, departments, attendance
Key Focus: Subqueries, Grouping, Views
Highlights:

- Average salary per department.

- Employees earning above department average.

- Departments with high absences.

- Created a view combining employee, manager, and department data.

---


# 🧩 Case Study 3 – E-commerce Analytics

Tables: users, sessions, transactions
Key Focus: CTEs, Window Functions, Date Functions
Highlights:

- Average time spent per session.

- Users with transactions but no sessions.

- Month with highest new user signups.

- Detected inactive users (no login/purchase in 60 days).

---


# 🧩 Case Study 4 – Hospital Analytics

Tables: patients, visits, doctors, bills
Key Focus: Joins, Grouping, Temporal Analysis
Highlights:

- Top 5 doctors by total billing.

- Revenue trend by specialization (monthly).

- Doctors with no visits in last 2 months.

---


# 🧩 Case Study 5 – Movie Ratings

Tables: movies, ratings, users
Key Focus: Window Functions, Ranking, Trends
Highlights:

- Top-rated movie per genre using RANK().

- Users who rated >50 movies.

- Genre trends using LAG() to detect improving ratings.

- Inactive users (no ratings in 90 days).

---


# 🧩 Final SQL Mini Project – Sales Performance Dashboard

Tables: customers, products, orders, order_items, returns
Key Focus: Business Metrics, Joins, Growth %
Highlights:

- Top 3 cities by total sales.

- Monthly revenue trend with MoM % change using LAG().

- Return rate per category.

- Top 5 loyal customers by spend & order count.

- Customers inactive for 3 months.

---


# 🛠️ Skills Demonstrated

- SQL Joins (INNER, LEFT, RIGHT)

- Aggregate Functions (SUM, AVG, COUNT)

- Window Functions (RANK, LAG, LEAD)

- CTEs and Subqueries

- Date and Time Functions (DATEDIFF, GETDATE, FORMAT)

- Data Cleaning & Business Logic Implementation
