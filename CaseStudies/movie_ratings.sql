select * from movies;
select * from users;
select * from ratings;

--top-rated movie per genre
WITH CTE AS(
	SELECT
	m.title as [Movie Title],
	m.genre as [Movie Genre],
	r.rating as [Movie Rating],
	RANK() OVER (PARTITION BY m.genre ORDER BY r.rating DESC) AS [TOP]
	FROM movies AS m
	JOIN ratings AS r 
		on m.movie_id = r.movie_id
)
SELECT
	[Movie Title],
	[Movie Genre],
	[Movie Rating]
FROM CTE
	WHERE [TOP] = 1;


--users who rated more than 50 movies
SELECT 
	* 
from(
	SELECT 
		u.name as [User Name],
		COUNT(*) AS [Number of ratings]
	FROM ratings r
	join users u
		on r.user_id = u.user_id
	GROUP BY u.name
)AS new_table
WHERE [Number of ratings] > 50


--average rating per year of release
SELECT
	m.release_year as [Release Year],
	CAST(ROUND(AVG(r.rating), 2) AS DECIMAL(10,2)) as [Average Ratings per Year]
FROM movies m
join ratings r
	on m.movie_id = r.movie_id
GROUP BY m.release_year


--genres with improving average ratings over time
WITH GenreTrend AS(
	SELECT
		m.genre as [Movie Genre],
		m.release_year as [Release Year],
		CAST(ROUND(AVG(r.rating), 2) AS DECIMAL(10,2)) as [Average Ratings per Year],
		LAG(CAST(ROUND(AVG(r.rating), 2) AS DECIMAL(10,2))) OVER(PARTITION BY m.genre ORDER BY m.release_year) AS [Previos year Rating]
	FROM movies m
	JOIN ratings r
		on m.movie_id = r.movie_id
	GROUP BY m.genre, m.release_year
)
SELECT
	[Movie Genre],
	[Release Year],
	[Average Ratings per Year],
	[Previos year Rating],
	CASE
		WHEN [Previos year Rating] < [Average Ratings per Year] THEN 'Improving'
		WHEN [Previos year Rating] = [Average Ratings per Year]	THEN 'Same'
		ELSE 'Declining'
	END AS Trend
FROM GenreTrend

--inactive users (no ratings in past 90 days)
SELECT
	*
FROM(
	SELECT
		u.user_id as [User ID],
		u.name as [User Name],
		MAX(r.rating_date) as [Last Rating Date]
	FROM users as u
	LEFT JOIN ratings r
		on u.user_id = r.user_id
	GROUP BY u.user_id, u.name
)AS new
WHERE 
	[Last Rating Date] is NULL
	OR
	DATEDIFF(DAY, [Last Rating Date], GETDATE()) > 90