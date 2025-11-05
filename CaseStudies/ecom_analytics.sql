select * from users;
select * from sessions;
select * from transactions;

--Average time spent per session
select 
AVG(DATEDIFF(SECOND, session_start, session_end)) AS session_duration_seconds
from sessions
group by session_id;


--users who have transactions but no sessions recorded
SELECT 
    t.user_id
FROM transactions AS t
LEFT JOIN sessions AS s
    ON t.user_id = s.user_id
WHERE s.user_id IS NULL;


--total revenue per user, and rank them
select
name, 
SUM(amount) as [Total Revenue per user],
RANK() OVER (ORDER BY sum(amount) desc)
from users 
join transactions 
	on users.user_id = transactions.user_id
GROUP BY name

-- month with highest number of new users
WITH MonthlyUsers AS (
    SELECT
        MONTH(signup_date) AS [Month],
        COUNT(*) AS [Number of users],
        RANK() OVER (ORDER BY COUNT(*) DESC) AS [Rank]
    FROM users
    GROUP BY MONTH(signup_date)
)
SELECT 
    [Month]
FROM MonthlyUsers
WHERE [Rank] = 1;


--inactive users
WITH InactiveUsers AS(
    SELECT 
        u.user_id,
        MAX(s.session_end) AS last_login,
        MAX(date) AS last_transaction
    from users u
    LEFT JOIN sessions s on u.user_id = s.user_id
    LEFT JOIN transactions t on u.user_id = t.user_id
    GROUP BY u.user_id
)
SELECT 
user_id
from InactiveUsers
WHERE(
    (last_login is NULL OR DATEDIFF(DAY, last_login, GETDATE()) > 60)
    AND
    (last_transaction is NULL OR DATEDIFF(DAY, last_transaction, GETDATE()) > 60)
)