Combining Data:
CREATE TABLE bike_share(
	ride_id VARCHAR(25),
	rideable_type VARCHAR(25),
	started_at TIMESTAMP,
	ended_at TIMESTAMP,
	start_station_name VARCHAR(45),
	start_station_id VARCHAR(25),
	end_station_name VARCHAR(25),
	end_station_id VARCHAR(25),
	start_lat DECIMAL(17,15),
	start_lng DECIMAL(17,15),
	end_lat DECIMAL(17,15),
	end_lng DECIMAL(17,15),
	member_casual VARCHAR(45)
);

--Jan2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202101-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Feb2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202102-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Mar2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202103-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Apr2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202104-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--May2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202105-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Jun2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202106-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Jul2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202107-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Aug2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202108-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Sep2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202109-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Oct2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202110-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Nov2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202111-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Dec2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202112-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;

--Backup Table created
CREATE TABLE original_bike_share AS(
SELECT * FROM bike_share);

--Data Cleaning:
-- To check the NULL values from all columns, it is important to remove NULLs for effective analsis.
SELECT COUNT(*)
FROM bike_share
WHERE ride_id IS NULL;

SELECT COUNT(*)
FROM bike_share
WHERE rideable_type IS NULL;

SELECT COUNT(*)
FROM bike_share
WHERE started_at IS NULL;

SELECT COUNT(*)
FROM bike_share
WHERE ended_at IS NULL;

SELECT COUNT(*)
FROM bike_share
WHERE start_station_name IS NULL; --690809

SELECT COUNT(*)
FROM bike_share
WHERE start_station_id IS NULL; --690806

SELECT COUNT(*)
FROM bike_share
WHERE end_station_name IS NULL; --739170

SELECT COUNT(*)
FROM bike_share
WHERE end_station_id IS NULL; -- 739170

SELECT COUNT(*)
FROM bike_share
WHERE start_lat IS NULL;

SELECT COUNT(*)
FROM bike_share
WHERE start_lng IS NULL;

SELECT COUNT(*)
FROM bike_share
WHERE end_lat IS NULL; --4771

SELECT COUNT(*)
FROM bike_share
WHERE end_lng IS NULL; --4771

SELECT COUNT(*)
FROM bike_share
WHERE member_casual IS NULL;

--To check the percentage of casual member from the rows I am going to remove. 
SELECT member_casual, COUNT(*)
FROM bike_share
WHERE start_station_name IS NULL
GROUP BY 1; --casual=317686, member=373123

DELETE FROM bike_share
WHERE start_station_name IS NULL; --690809 row

SELECT member_casual, COUNT(*)
FROM bike_share
WHERE start_station_id IS NULL
GROUP BY 1;

DELETE FROM bike_share
WHERE start_station_id IS NULL;

SELECT member_casual,COUNT(*)
FROM bike_share
WHERE end_station_name IS NULL
GROUP BY 1; --casual=162940, member=153012

DELETE FROM bike_share
WHERE end_station_name IS NULL; --315952

SELECT member_casual, COUNT(*)
FROM bike_share
WHERE end_station_id IS NULL
GROUP BY 1;

SELECT member_casual, COUNT(*)
FROM bike_share
WHERE end_lat IS NULL
GROUP BY 1;

SELECT member_casual, COUNT(*)
FROM bike_share
WHERE end_lng IS NULL
GROUP BY 1;

SELECT *
FROM bike_share
LIMIT 50;

--Verification
SELECT COUNT(*) - COUNT(DISTINCT ride_id)
FROM bike_share;

--Getting to know the data
SELECT DISTINCT(rideable_type)
FROM bike_share;

SELECT DISTINCT(start_station_name)
FROM bike_share; --839


SELECT DISTINCT(end_station_name)
FROM bike_share; --837


SELECT DISTINCT(member_casual)
FROM bike_share;

--Further Cleaning
SELECT start_station_name, start_station_id
FROM bike_share
WHERE start_station_name = start_station_id;

SELECT COUNT(*)
FROM bike_share
WHERE start_station_name = start_station_id; --6

DELETE FROM bike_share
WHERE start_station_name = start_station_id;

SELECT end_station_name, end_station_id
FROM bike_share
WHERE end_station_name = end_station_id;

SELECT COUNT(*)
FROM bike_share
WHERE end_station_name = end_station_id;

DELETE FROM bike_share
WHERE end_station_name = end_station_id; --4

SELECT *
FROM bike_share;
--Further exploration
SELECT  started_at, ended_at, start_station_name, end_station_name, (ended_at - started_at) AS duration
FROM bike_share
WHERE (ended_at - started_at) < '0'::INTERVAL
ORDER BY duration

--Further Cleaning.
DELETE FROM bike_share
WHERE (ended_at - started_at) < '0'::INTERVAL

DELETE FROM bike_share
WHERE (ended_at - started_at) = '0'::INTERVAL


SELECT  started_at, ended_at, start_station_name, end_station_name, (ended_at - started_at) AS duration
FROM bike_share
ORDER BY duration
LIMIT 100


SELECT  started_at, ended_at, start_station_name, end_station_name, (ended_at - started_at) AS duration
FROM bike_share
WHERE (ended_at - started_at) BETWEEN '0'::INTERVAL AND '10'::INTERVAL
ORDER BY duration DESC


--Preparing Data for Analysis
ALTER TABLE bike_share
ADD COLUMN ride_duration INTERVAL;

UPDATE bike_share
SET ride_duration = (ended_at - started_at)



--Data Analysis
--1. Total number of rides per user category
SELECT member_casual, COUNT(*)
FROM bike_share
GROUP BY 1;

--2. Number of rides per month per user category
SELECT member_casual,
CASE EXTRACT(MONTH from started_at)
WHEN 1 THEN 'Jan'
WHEN 2 THEN 'Feb'
WHEN 3 THEN 'Mar'
WHEN 4 THEN 'Apr'
WHEN 5 THEN 'May'
WHEN 6 THEN 'Jun'
WHEN 7 THEN 'Jul'
WHEN 8 THEN 'Aug'
WHEN 9 THEN 'Sep'
WHEN 10 THEN 'Oct'
WHEN 11 THEN 'Nov'
WHEN 12 THEN 'Dec'
END AS ride_month, COUNT(*) AS no_of_rides
FROM bike_share
GROUP BY 1,2
ORDER BY 3;

--3. Which day of the week is most popular among different user category riders?
SELECT member_casual, 
CASE EXTRACT(DOW from started_at)
WHEN 0 THEN 'Sun'
WHEN 1 THEN 'Mon'
WHEN 2 THEN 'Tue'
WHEN 3 THEN 'Wed'
WHEN 4 THEN 'Thu'
WHEN 5 THEN 'Fri'
WHEN 6 THEN 'Sat'
END AS ride_day, 
COUNT(*) AS no_of_rides 
FROM bike_share
GROUP BY 1,2
ORDER BY 2;

--4. Which month of the year is the most busy one for different users?
SELECT member_casual,
CASE EXTRACT(MONTH from started_at)
WHEN 1 THEN 'Jan'
WHEN 2 THEN 'Feb'
WHEN 3 THEN 'Mar'
WHEN 4 THEN 'Apr'
WHEN 5 THEN 'May'
WHEN 6 THEN 'Jun'
WHEN 7 THEN 'Jul'
WHEN 8 THEN 'Aug'
WHEN 9 THEN 'Sep'
WHEN 10 THEN 'Oct'
WHEN 11 THEN 'Nov'
WHEN 12 THEN 'Dec'
END AS ride_month,
COUNT(*) AS no_of_rides 
FROM bike_share
GROUP BY 1,2
ORDER BY 3 DESC;

--5. What is the average ride time for different category users by month?
SELECT member_casual,
CASE EXTRACT(MONTH from started_at)
WHEN 1 THEN 'Jan'
WHEN 2 THEN 'Feb'
WHEN 3 THEN 'Mar'
WHEN 4 THEN 'Apr'
WHEN 5 THEN 'May'
WHEN 6 THEN 'Jun'
WHEN 7 THEN 'Jul'
WHEN 8 THEN 'Aug'
WHEN 9 THEN 'Sep'
WHEN 10 THEN 'Oct'
WHEN 11 THEN 'Nov'
WHEN 12 THEN 'Dec'
END AS ride_month,
ROUND(EXTRACT(HOUR from AVG(ride_duration))*60
+EXTRACT(MINUTE from AVG(ride_duration))
+EXTRACT(SECOND from AVG(ride_duration))/60,2) AS m_avg_duration 
FROM bike_share
GROUP BY 1,2
ORDER BY 3 DESC;

--6 What is the average ride time for different category users, by year and by month?
SELECT member_casual,
ROUND(EXTRACT(HOUR from AVG(ride_duration))*60
+EXTRACT(MINUTE from AVG(ride_duration))
+EXTRACT(SECOND from AVG(ride_duration))/60,2) AS y_avg_duration 
FROM bike_share
GROUP BY 1;

--7. Top 1000 longest rides belong to which type of user?
SELECT member_casual, COUNT(*)
FROM (	SELECT member_casual, ride_duration
		FROM bike_share
		ORDER BY 2 DESC
		LIMIT 1000
) sub
GROUP BY 1;


--8. Top 5 stations as a starting point for member category?
SELECT start_station_name, member_casual, COUNT(*)
FROM bike_share
WHERE member_casual = 'member'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5;


--9. Top 5 stations as a starting point for casual category?
SELECT start_station_name, member_casual, COUNT(*)
FROM bike_share
WHERE member_casual = 'casual'
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5;


--10. What time of the day member and casual users start their ride at?
SELECT member_casual, DATE_PART('HOUR', started_at) AS hour_of_the_day, COUNT(*)
FROM bike_share
GROUP BY 1,2
ORDER BY 3 DESC;

--11. Which bike type is most popular among different users?
SELECT member_casual, rideable_type, COUNT(*)
FROM bike_share
GROUP BY 1,2
ORDER BY 3 DESC;

--12. Bike use by different category users during working week & Weekend?
SELECT member_casual,
CASE EXTRACT(DOW from started_at)
WHEN 0 THEN 'Sun'
WHEN 1 THEN 'Mon'
WHEN 2 THEN 'Tue'
WHEN 3 THEN 'Wed'
WHEN 4 THEN 'Thu'
WHEN 5 THEN 'Fri'
WHEN 6 THEN 'Sat'
END AS day_of_week,
COUNT(*)
FROM bike_share
GROUP BY 1,2
ORDER BY 3;




