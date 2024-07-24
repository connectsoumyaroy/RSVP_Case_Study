USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/

-- Segment 1:


-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:


-- Total number of rows in each table of the schema

-- Counting rows in the 'movie' table
SELECT 
    COUNT(*) AS No_of_rows_in_movie  -- Total rows in the 'movie' table
FROM 
    movie;  -- 7997 rows

-- Counting rows in the 'ratings' table
SELECT 
    COUNT(*) AS No_of_rows_in_ratings  -- Total rows in the 'ratings' table
FROM 
    ratings;  -- 7997 rows

-- Counting rows in the 'genre' table
SELECT 
    COUNT(*) AS No_of_rows_in_genre  -- Total rows in the 'genre' table
FROM 
    genre;  -- 14662 rows

-- Counting rows in the 'role_mapping' table
SELECT 
    COUNT(*) AS No_of_rows_in_role_mapping  -- Total rows in the 'role_mapping' table
FROM 
    role_mapping;  -- 15615 rows

-- Counting rows in the 'director_mapping' table
SELECT 
    COUNT(*) AS No_of_rows_in_director_mapping  -- Total rows in the 'director_mapping' table
FROM 
    director_mapping;  -- 3867 rows

-- Counting rows in the 'names' table
SELECT 
    COUNT(*) AS No_of_rows_in_names  -- Total rows in the 'names' table
FROM 
    names;  -- 25735 rows

-- Summary:
-- Provides the total number of rows in each table of the schema, including 'movie', 'ratings', 'genre', 'role_mapping', 'director_mapping', and 'names'.


-- Q2. Which columns in the movie table have null values?
-- Type your code below:

-- Delimiter change to handle function creation
DELIMITER //

-- Check if function exists and drop if it does
DROP FUNCTION IF EXISTS isNull;

-- Create function to check for NULL values
CREATE FUNCTION isNull(data VARCHAR(30))
    RETURNS INT DETERMINISTIC
BEGIN
    DECLARE result INT;
    IF data IS NULL THEN
        SET result = 1;  -- Return 1 if the data is NULL
    ELSE
        SET result = 0;  -- Return 0 if the data is not NULL
    END IF;
    RETURN result;
END;
//

-- Reset delimiter back to default
DELIMITER ;

-- Using CASE statements to count NULL values for each column in the 'movie' table
SELECT 
    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS ID_Null,
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS title_Null,
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS year_Null,
    SUM(CASE WHEN date_published IS NULL THEN 1 ELSE 0 END) AS date_published_Null,
    SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS duration_Null,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_Null,
    SUM(CASE WHEN worlwide_gross_income IS NULL THEN 1 ELSE 0 END) AS worlwide_gross_income_Null,
    SUM(CASE WHEN languages IS NULL THEN 1 ELSE 0 END) AS languages_Null,
    SUM(CASE WHEN production_company IS NULL THEN 1 ELSE 0 END) AS production_company_Null
FROM   
    movie; 

/* Summary:
   - The query uses a function to efficiently count NULL values across different columns in the 'movie' table.
   - Specific counts of NULL values are provided:
     - country has 20 nulls
     - worldwide_gross_income has 3724 nulls
     - languages has 194 nulls
     - production_company has 528 nulls
*/

-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Yearly movie count with maximum movies listed first

SELECT 
    YEAR(date_published) AS Year,
    COUNT(id) AS number_of_movies
FROM 
    movie
GROUP BY 
    YEAR(date_published)
ORDER BY 
    number_of_movies DESC;

-- Summary:
-- Lists the number of movies produced each year, with the year having the most movies listed first.

-- Analysis Summary:
-- - Highest number of movies were released in 2017.

-- Month-wise movie count
SELECT 
    MONTH(date_published) AS month_num,
    COUNT(id) AS number_of_movies
FROM 
    movie
GROUP BY 
    month_num
ORDER BY 
    month_num;

-- Summary:
-- Lists the number of movies released each month, ordered by month number.

-- Analysis Summary:
-- - Provides a breakdown of movie releases by month.
-- - March (Month 3) has the highest number of movie releases.


/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

-- Count the number of movies produced in the USA or India in the year 2019
SELECT 
    YEAR(date_published) AS Year_Produced,  -- Year of production
    COUNT(id) AS Movies_Produced  -- Number of movies produced
FROM 
    movie
WHERE 
    (country LIKE '%USA%' OR country LIKE '%India%')  -- Filtering countries to USA or India
    AND YEAR(date_published) = 2019  -- Filtering for the year 2019
GROUP BY 
    YEAR(date_published)
ORDER BY 
    Year_Produced ASC;  -- Ordering by year in ascending order

/*
Summary:
- This query counts the number of movies produced in the USA or India in the year 2019.
- In 2019, there were a total of 1059 movies produced in either the USA or India.
*/



/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:


-- Retrieve the unique list of genres present in the dataset
SELECT DISTINCT 
    genre AS Unique_Genres  -- Unique genres in the dataset
FROM 
    genre
ORDER BY 
    genre;  -- Ordering genres alphabetically

/*
Summary:
This query retrieves all unique genres from the 'genre' table.
There are 13 different genres present in the dataset.
*/




/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

-- Determine which genre had the highest number of movies produced overall

SELECT 
    genre,
    COUNT(m.id) AS num_movies
FROM   
    movie AS m
    INNER JOIN genre AS g ON m.id = g.movie_id
GROUP BY 
    genre
ORDER BY 
    num_movies DESC
LIMIT 3;

/*
Summary:
This query identifies the genre with the highest number of movies produced overall by joining the 'movie' and 'genre' tables. 
The result shows that the 'Drama' genre has the maximum number of movies produced, indicating it as a prominent genre in the dataset.
*/


/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:


-- Count how many movies belong to only one genre

WITH movie_with_1_genre AS
(
    SELECT movie_id
    FROM genre
    GROUP BY movie_id
    HAVING COUNT(genre) = 1
)
SELECT 
    COUNT(*) AS Movie_Count
FROM 
    movie_with_1_genre;

/*
Summary:
This query identifies the number of movies that belong to only one genre by counting the distinct movie IDs in the 'genre' table where each movie has exactly one genre associated with it. 
The result shows that there are 3289 movies in the dataset that belong to only one genre.
*/



/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:
+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Finding the average duration of movies by grouping genres (considering movies can belong to multiple genres)

SELECT genre,
       ROUND(AVG(duration), 0) AS avg_duration -- Calculating average duration rounded to nearest integer
FROM movie AS m
INNER JOIN genre AS g ON g.movie_id = m.id
GROUP BY genre
ORDER BY avg_duration DESC; -- Sorting genres by descending average duration


/*
Analysis Summary:
- Action genre has the highest average duration, indicating longer movies in this category.
- Romance,Drama and Crime genres also show relatively high average durations.
- Some genres may have shorter average durations, suggesting variability in movie lengths within those categories.
*/


/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

-- Calculate the rank of each genre based on the number of movies in each genre
-- Retrieve the rank and movie count for the Thriller genre

WITH genre_summary AS (
    SELECT 
        genre,
        COUNT(movie_id) AS movie_count,
        RANK() OVER (ORDER BY COUNT(movie_id) DESC) AS genre_rank
    FROM 
        genre
    GROUP BY 
        genre
)
SELECT 
    genre,
    movie_count,
    genre_rank
FROM 
    genre_summary
WHERE 
    genre = 'THRILLER';

/*
Analysis Summary:
- Thriller genre has 1484 movies.
- It is ranked 3rd among all genres in terms of the number of movies produced.
*/




/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

-- Retrieve the minimum and maximum values in each column of the ratings table except movie_id

SELECT 
    MIN(avg_rating) AS min_avg_rating,
    MAX(avg_rating) AS max_avg_rating,
    MIN(total_votes) AS min_total_votes,
    MAX(total_votes) AS max_total_votes,
    MIN(median_rating) AS min_median_rating,
    MAX(median_rating) AS max_median_rating
FROM 
    ratings;

/*
Summary:
This query calculates the minimum and maximum values for average rating, total votes, and median rating from the 'ratings' table. It provides insights into the range of values present in these columns.
*/


/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too
-- Finding the top 10 movies based on their average rating

WITH top_rank AS (
    SELECT 
        m.title,
        r.avg_rating,
        DENSE_RANK() OVER(ORDER BY r.avg_rating DESC) AS movie_rank
    FROM 
        movie m
    INNER JOIN 
        ratings r ON m.id = r.movie_id
)
SELECT 
    title,
    avg_rating,
    movie_rank
FROM 
    top_rank
WHERE 
    movie_rank <= 10
ORDER BY 
    avg_rating DESC -- Ensure the top 10 are ordered by highest average rating
LIMIT 10; -- Limit the display to the first 10 rows


/*
Analysis Summary:
- Displays the top 10 movies based on their average rating.
- Lists movies in descending order of average rating, ensuring the highest rated movies are shown first.
*/



/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

-- Summarize the ratings table based on movie counts by median ratings

SELECT 
    median_rating,
    COUNT(movie_id) AS movie_count
FROM 
    ratings
GROUP BY 
    median_rating
ORDER BY 
    movie_count DESC;

/*
Analysis Summary:
- Movies are grouped and counted based on their median ratings.
- The median rating with the highest number of movies is 7, with 2257 movies.
- Provides an overview of how many movies fall under each median rating category.
*/


/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:
WITH hit_movie_count AS 
(
    SELECT production_company,
           COUNT(id) AS movie_count 
    FROM movie
    WHERE id IN
    (
        SELECT movie_id
        FROM ratings
        WHERE avg_rating > 8
    )
    AND production_company IS NOT NULL
    GROUP BY production_company
),
Ranked_list AS
(	
    SELECT production_company, movie_count, 
           DENSE_RANK() OVER (ORDER BY movie_count DESC) AS prod_company_rank
    FROM hit_movie_count
)
SELECT * 
FROM Ranked_list
WHERE prod_company_rank = 1;

-- Summary:
-- Dream Warrior Pictures and National Theatre Live both have rank 1 with 3 hit movies each.

-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:
+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Count of movies released in each genre during March 2017 in the USA with more than 1,000 votes
SELECT g.genre,
       COUNT(m.id) AS movie_count
FROM genre g 
INNER JOIN movie m 
        ON m.id = g.movie_id
INNER JOIN ratings r
        ON m.id = r.movie_id
WHERE MONTH(m.date_published) = 3
      AND YEAR(m.date_published) = 2017
      AND m.country LIKE '%USA%'
      AND r.total_votes > 1000
GROUP BY g.genre
ORDER BY movie_count DESC;

-- Summary:
-- Top 3 genres are drama, comedy and action during March 2017 in the USA and had more than 1,000 votes.


-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- Finding movies that start with 'The' and have an average rating > 8, ordered by average rating in descending order

SELECT 
    m.title,
    r.avg_rating,
    g.genre
FROM 
    movie m
INNER JOIN 
    genre g ON m.id = g.movie_id
INNER JOIN 
    ratings r ON m.id = r.movie_id
WHERE 
    m.title LIKE 'The%'
    AND r.avg_rating > 8
ORDER BY 
    r.avg_rating DESC; -- Ordering by average rating in descending order

/*
Analysis Summary:
- There are 8 movies that begin with "The" in their title.
- The movie "The Brighton Miracle" has the highest average rating of 9.5.
- All of these movies belong to the top 3 genres based on their average ratings.
*/


-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

-- Counting movies released between 1 April 2018 and 1 April 2019 with a median rating of 8

SELECT 
    median_rating,
    COUNT(m.id) AS movie_count
FROM 
    movie m
INNER JOIN 
    ratings r ON m.id = r.movie_id
WHERE 
    r.median_rating = 8
    AND m.date_published BETWEEN '2018-04-01' AND '2019-04-01'
GROUP BY 
    median_rating;

/*
Analysis Summary:
- There are 361 movies released between 1 April 2018 and 1 April 2019 with a median rating of 8.
- This query counts movies based on their median rating within the specified date range, showing the distribution by median rating.
*/


-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

-- Comparing total votes for German movies versus Italian movies

SELECT 
    country,
    SUM(total_votes) AS total_votes
FROM 
    movie m
INNER JOIN 
    ratings r ON r.movie_id = m.id
WHERE 
    country IN ('Germany', 'Italy')
GROUP BY 
    country;

/*
Analysis Summary:
- The query compares the total number of votes received by German movies versus Italian movies.
- German movies received more total votes than Italian movies when considering votes based on country of origin.
- This analysis indicates that German movies tend to attract more votes compared to Italian movies.
*/
-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

-- Finding NULL counts for columns in the names table

SELECT 
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name_nulls,
    SUM(CASE WHEN height IS NULL THEN 1 ELSE 0 END) AS height_nulls,
    SUM(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth_nulls,
    SUM(CASE WHEN known_for_movies IS NULL THEN 1 ELSE 0 END) AS known_for_movies_nulls
FROM 
    names;

-- Height, date_of_birth, known_for_movies columns contain NULLS




/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Finding the top three directors in the top three genres with movies having an average rating > 8

WITH top_genres AS (
    SELECT 
        g.genre
    FROM 
        genre g 
    INNER JOIN 
        movie m ON m.id = g.movie_id
    INNER JOIN 
        ratings r ON m.id = r.movie_id
    WHERE 
        r.avg_rating > 8
    GROUP BY 
        g.genre
    ORDER BY 
        COUNT(m.id) DESC
    LIMIT 3
),
top_movies AS (
    SELECT 
        g.movie_id
    FROM 
        genre g
    INNER JOIN 
        top_genres t ON g.genre = t.genre
    INNER JOIN 
        ratings r ON g.movie_id = r.movie_id
    WHERE 
        r.avg_rating > 8
)
SELECT 
    n.name AS director_name,
    COUNT(dm.movie_id) AS movie_count
FROM 
    top_movies tm
INNER JOIN 
    director_mapping dm ON tm.movie_id = dm.movie_id
INNER JOIN 
    names n ON n.id = dm.name_id
GROUP BY 
    n.name
ORDER BY 
    movie_count DESC
LIMIT 3;

/*
Analysis Summary:
- The query identifies the top three directors whose movies in the top three genres (based on the most number of movies with average rating > 8) can be hired by RSVP Movies.
- The directors are listed in descending order based on the count of movies meeting the criteria.
- James Mangold emerges as the top director with the highest number of movies meeting the criteria.
*/


/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Finding the top two actors whose movies have a median rating >= 8

SELECT 
    n.name AS actor_name,
    COUNT(rm.movie_id) AS movie_count
FROM 
    names n 
INNER JOIN 
    role_mapping rm ON n.id = rm.name_id 
INNER JOIN 
    movie m ON rm.movie_id = m.id 
INNER JOIN 
    ratings r ON r.movie_id = m.id
WHERE 
    r.median_rating >= 8
    AND rm.category = 'ACTOR'
GROUP BY 
    n.name
ORDER BY 
    movie_count DESC
LIMIT 2;

/*
Summary:
This query identifies the top two actors based on the number of movies where their median rating is 8 or higher.
- Mammootty leads with the highest number of such movies.
- Mohanlal follows closely behind.
- Both actors have consistently starred in movies with high median ratings, showcasing their popularity and success in delivering critically acclaimed performances.
*/


/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

-- Finding the top three production houses based on the number of votes received by their movies

SELECT 
    production_company,
    SUM(total_votes) AS vote_count,
    RANK() OVER(ORDER BY SUM(total_votes) DESC) AS prod_comp_rank
FROM 
    movie m
INNER JOIN 
    ratings r ON m.id = r.movie_id
GROUP BY 
    production_company
ORDER BY 
    prod_comp_rank
LIMIT 3;

/*
Analysis:
This query identifies the top three production houses based on the total number of votes received by their movies:
- Marvel Studios is ranked first with the highest number of votes, reflecting its significant impact and popularity among audiences worldwide.
- Twentieth Century Fox follows closely behind in second place, indicating its strong viewer engagement and successful film productions.
- Warner Bros. secures the third position, showcasing its enduring presence and successful track record in the film industry.
*/

/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Ranking Indian actors based on their average ratings in movies released in India

WITH actor_summary AS (
    SELECT
        N.name AS actor_name,
        SUM(R.total_votes) AS total_votes,
        COUNT(RM.movie_id) AS movie_count,
        ROUND(SUM(R.avg_rating * R.total_votes) / SUM(R.total_votes), 2) AS actor_avg_rating
    FROM
        movie AS M
        INNER JOIN ratings AS R ON M.id = R.movie_id
        INNER JOIN role_mapping AS RM ON M.id = RM.movie_id
        INNER JOIN names AS N ON RM.name_id = N.id
    WHERE
        RM.category = 'ACTOR'
        AND M.country LIKE '%India%'
    GROUP BY
        N.name
    HAVING
        COUNT(RM.movie_id) >= 5
)
SELECT
    actor_name,
    total_votes,
    movie_count,
    actor_avg_rating,
    RANK() OVER (ORDER BY actor_avg_rating DESC) AS actor_rank
FROM
    actor_summary;

/*
Analysis:
This query identifies the top Indian actors based on their average ratings in movies released in India:
- Vijay Sethupathi emerges as the top actor with the highest average rating, indicating his strong performance and audience appeal.
- Fahadh Faasil follows closely behind, showcasing his consistent performance and popularity among viewers.
- Yogi Babu ranks third, highlighting his significant contributions and success in Indian cinema.
*/

-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Identifying the top five actresses in Hindi movies released in India based on average ratings

WITH actress_rank AS (
    SELECT
        N.name AS actress_name,
        SUM(R.total_votes) AS total_votes,
        COUNT(RM.movie_id) AS movie_count,
        ROUND(SUM(R.avg_rating * R.total_votes) / SUM(R.total_votes), 2) AS actress_avg_rating
    FROM
        movie AS M
        INNER JOIN ratings AS R ON M.id = R.movie_id
        INNER JOIN role_mapping AS RM ON RM.movie_id = M.id
        INNER JOIN names AS N ON N.id = RM.name_id
    WHERE
        M.country LIKE '%India%'
        AND RM.category = 'actress'
        AND M.languages LIKE '%Hindi%'
    GROUP BY
        actress_name
    HAVING
        movie_count >= 3
)
SELECT
    actress_name,
    total_votes,
    movie_count,
    actress_avg_rating,
    RANK() OVER (ORDER BY actress_avg_rating DESC) AS actress_rank
FROM
    actress_rank
LIMIT 5;

/*
Analysis:
- Taapsee Pannu emerges as the top actress with the highest average rating in Hindi movies released in India, reflecting strong audience appreciation.
- Kriti Sanon follows closely, indicating consistent acclaim and popularity within the Hindi film industry.
- Divya Dutta, Shraddha Kapoor, and Kriti Kharbanda secure positions in the top five, underscoring their significant contributions to Indian cinema.
*/

/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

-- Classifying thriller movies based on average ratings

WITH thriller_movies AS (
    SELECT 
        DISTINCT m.title,
        r.avg_rating
    FROM 
        movie AS m
    INNER JOIN 
        ratings AS r ON r.movie_id = m.id
    INNER JOIN 
        genre AS g ON g.movie_id = m.id
    WHERE 
        g.genre LIKE '%thriller%'
)
SELECT 
    title,
    avg_rating,
    CASE
        WHEN avg_rating > 8 THEN 'Superhit movies'
        WHEN avg_rating BETWEEN 7 AND 8 THEN 'Hit movies'
        WHEN avg_rating BETWEEN 5 and 7 THEN 'One-time-watch movies'
        ELSE 'Flop movies'
    END AS rating_category
FROM 
    thriller_movies;

/*
Analysis:
- Thriller movies with an average rating above 8 are categorized as 'Superhit movies.'
- Those with ratings between 7 and 8 fall under 'Hit movies.'
- Ratings between 5 and 7 are classified as 'One-time-watch movies.'
- Movies rated below 5 are deemed 'Flop movies.'
*/



/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

-- Calculating genre-wise running total and moving average of average movie duration

SELECT 
    g.genre,
    ROUND(AVG(m.duration), 0) AS avg_duration,
    SUM(ROUND(AVG(m.duration), 1)) OVER (ORDER BY g.genre ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_duration,
    AVG(ROUND(AVG(m.duration), 1)) OVER (ORDER BY g.genre ROWS BETWEEN 10 PRECEDING AND CURRENT ROW) AS moving_avg_duration
FROM 
    movie m
INNER JOIN 
    genre g ON m.id = g.movie_id
GROUP BY 
    g.genre
ORDER BY 
    g.genre;

/*
Analysis:
- The table shows genre-wise average movie durations.
- 'Running Total Duration' column displays the cumulative sum of average durations as each genre progresses.
- 'Moving Average Duration' column gives the average of average durations over a rolling window of 10 genres.
*/

-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies
-- Finding the top 5 movies of each year in the top three genres based on worldwide gross income
WITH top_genres AS (
    SELECT
        genre
    FROM
        genre
    GROUP BY
        genre
    ORDER BY
        COUNT(movie_id) DESC
    LIMIT 3
),
movie_summary AS (
    SELECT
        g.genre,
        m.year,
        m.title AS movie_name,
        m.worlwide_gross_income, -- Corrected column name here
        DENSE_RANK() OVER(PARTITION BY m.year ORDER BY 
            CASE
                WHEN m.worlwide_gross_income LIKE 'INR%' THEN ROUND(SUBSTRING(m.worlwide_gross_income, 5) * 0.013, 2)
                ELSE ROUND(SUBSTRING(m.worlwide_gross_income, 2))
            END DESC) AS movie_rank
    FROM
        movie m
        INNER JOIN genre g ON m.id = g.movie_id
        INNER JOIN ratings r ON r.movie_id = m.id
        INNER JOIN top_genres tg ON g.genre = tg.genre
)
SELECT
    genre,
    year,
    movie_name,
    worlwide_gross_income,
    movie_rank
FROM
    movie_summary
WHERE
    movie_rank <= 5
ORDER BY
    year, movie_rank;



-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

-- Finding the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies.

WITH prod_company AS (
    SELECT
        production_company,
        COUNT(*) AS movie_count
    FROM
        movie AS m
        INNER JOIN ratings AS r ON r.movie_id = m.id
    WHERE
        production_company IS NOT NULL
        AND median_rating >= 8
        AND POSITION(',' IN languages) > 0
    GROUP BY
        production_company
    ORDER BY
        movie_count DESC
    LIMIT 2
)

SELECT
    production_company,
    movie_count,
    RANK() OVER (ORDER BY movie_count DESC) AS prod_comp_rank
FROM
    prod_company;

/*
- Star Cinema and Twentieth Century Fox are the top two production houses that have produced the highest number of hits among multilingual movies.
*/



-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
-- Top 3 actresses based on number of Super Hit movies (average rating > 8) in drama genre

WITH actress_summary AS
(
    SELECT 
        n.name AS actress_name,
        SUM(r.total_votes) AS total_votes,
        COUNT(r.movie_id) AS movie_count,
        ROUND(SUM(r.avg_rating * r.total_votes) / SUM(r.total_votes), 2) AS actress_avg_rating
    FROM 
        movie m
        INNER JOIN ratings r ON m.id = r.movie_id
        INNER JOIN role_mapping rm ON m.id = rm.movie_id
        INNER JOIN names n ON rm.name_id = n.id
        INNER JOIN genre g ON g.movie_id = m.id
    WHERE 
        rm.category = 'actress'
        AND g.genre = 'Drama'
        AND r.avg_rating > 8
    GROUP BY 
        n.name
)
SELECT 
    actress_name, 
    total_votes, 
    movie_count, 
    actress_avg_rating,
    RANK() OVER (ORDER BY movie_count DESC) AS actress_rank
FROM 
    actress_summary
LIMIT 3;

/*
Analysis Summary:
- The result table lists the top 3 actresses based on number of Super Hit movies are Parvathy Thiruvothu, Susan Brown and Amanda Lawrence.
*/



/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:
-- Query to analyze top directors based on their movie metrics

WITH next_date_published_summary AS (
    -- Subquery to fetch movie details and calculate inter-movie durations
    SELECT
        d.name_id,
        n.name AS director_name,
        d.movie_id,
        m.duration,
        r.avg_rating,
        r.total_votes,
        m.date_published,
        LEAD(m.date_published, 1) OVER(PARTITION BY d.name_id ORDER BY m.date_published, m.id) AS next_date_published
    FROM
        director_mapping AS d
        INNER JOIN names AS n ON n.id = d.name_id
        INNER JOIN movie AS m ON m.id = d.movie_id
        INNER JOIN ratings AS r ON r.movie_id = m.id
), top_director_summary AS (
    -- Final subquery to compute aggregated metrics for each director
    SELECT
        name_id AS director_id,
        director_name,
        COUNT(movie_id) AS number_of_movies,
        ROUND(AVG(DATEDIFF(next_date_published, date_published)), 2) AS avg_inter_movie_days,
        ROUND(AVG(avg_rating), 2) AS avg_rating,
        SUM(total_votes) AS total_votes,
        MIN(avg_rating) AS min_rating,
        MAX(avg_rating) AS max_rating,
        SUM(duration) AS total_duration
    FROM
        next_date_published_summary
    GROUP BY
        director_id, director_name
    ORDER BY
        number_of_movies DESC
    LIMIT 9
)

-- Final query to present the summarized director metrics
SELECT
    director_id,
    director_name,
    number_of_movies,
    avg_inter_movie_days,
    avg_rating,
    total_votes,
    min_rating,
    max_rating,
    total_duration
FROM
    top_director_summary;

/*
Analysis Summary:
This query identifies the top 9 directors based on the number of movies they've directed. It calculates:
- Average inter-movie days: The average time gap between successive movie releases for each director.
- Average rating: The average rating received across all their movies.
- Total votes: The cumulative votes received for all their movies.
- Min and Max ratings: The lowest and highest ratings among their movies.
- Total duration: The combined duration of all their movies in minutes.

These metrics provide insights into the productivity, audience reception, and overall impact of each director's body of work.
*/


