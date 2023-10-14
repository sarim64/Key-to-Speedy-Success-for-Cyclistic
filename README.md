# Key to Speedy Success for Cyclistic
## Statement of Business Task: 
How annual members and casual riders differ?
## Data Source: 
A publicly available data set, “divvy-tripdata”. I used one year, year 2021, of trip data in my analysis. One year data is sufficient to get actionable insights from the data.
## Documentation: 
This detailed report, an SQL file with actual queries and a Tableau “Data Story” is available will be ready by the end of this project.
# Detailed Analysis Process:
After reading the requirements, I determined three questions.
1. Design marketing strategies aimed at converting casual riders into annual members.
2. To better understand how annual members and casual riders differ.
3. Why casual riders would buy a membership, and how digital media could affect their marketing tactics.
Out of these 3 questions, second one is relevant to data analytics team. “To better understand how annual members and casual riders differ.”

For this task, I needed at least 1 year of data, so that I can analyze it with different angles. So, I downloaded data related to year 2021. Before moving forward, it was important to check the completeness and accuracy of the data. I used BigQuery as well as PostgreSQL as tools for preparing, cleaning and analyzing data. I used Tableau to visualize my analysis.
## Data Combining
- So, as a first step, I uploaded all 12 CSV files in BigQuery.
- Now this was the time to use my SQL knowledge to prepare, clean and analyze data using SQL queries. 
- I checked the data types for all the columns in all 12 tables in BigQuery just to make sure that data types are aligned, because I had to combine these tables into one.
- After making sure data types are identical for all the columns in all tables, I created one separate table by combining all the tables with a final row count of 6,733,219. 
- I created a copy of the combined table and performed data cleaning steps.
- I faced a roadblock here, Sandbox account didn't allow me to delete rows with NULL values, so I had to figure out the way to upload all data to PostgreSQL. 
- I successfully created a table with the correct data types in Pg Admin and used the copy command to copy all 12 CSV files to the table.
- Here again, I created a copy of that table and performed cleaning tasks on that copied table. The original table is still in its original form.
```sql
--Combining Data:
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
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202101-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Feb2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202102-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Mar2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202103-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Apr2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202104-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--May2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202105-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Jun2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202106-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Jul2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202107-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Aug2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202108-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Sep2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202109-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Oct2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202110-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Nov2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202111-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
--Dec2021
COPY bike_share(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
FROM '<File Location>\202112-divvy-tripdata.csv'
DELIMITER ','
CSV HEADER;
```
## Data Cleaning
- After creating a backup table, I started cleaning data. 
- First, I deleted all rows containing NULL values in all columns. It was important to delete these Nulls for the sake of correct analysis and to avoid bias.
- After deleting NULL values, I got 4,588,302 rows of clean data.
- After exploring data, another round of cleaning was conducted. I found some discrepancy where station_name and station_id was same. Total 10 rows with this inconsistent data were removed. 
- After further exploration, I found that there were some rows in the data where the difference between end_time and start_time was in negative. It was important to eradicate these rows. So I wrote some queries to further clean the data.
- Note: I further explored this data, and found there were thousands of rows of data where the difference between end time and start time was a couple of seconds and start station name and end station name were the same, I was convinced to delete these rows, but I kept them anyway.
## Verification
As duplicate rows could impact the result of analysis, so I verified data for the duplicated rows in the table. Fortunately, there were no duplicate records.
## Getting to know the Data
Before analysis, it was important to know the actual data. So I wrote some queries to get the knowledge of data. 
```sql
--Getting to know the data
SELECT DISTINCT(rideable_type)
FROM bike_share;

SELECT DISTINCT(start_station_name)
FROM bike_share; 


SELECT DISTINCT(end_station_name)
FROM bike_share; 


SELECT DISTINCT(member_casual)
FROM bike_share;
```
1. Total Unique Rows: 4,588,094
2. Rideable types of bikes: "classic_bike", "docked_bike", "electric_bike"
3. Start Station Name Count: 839
4. End Station Name Count: 837
5. Types of Riders: "casual", "member"
## Preparing Data for Analysis
As the primary question to answer from this data is “To better understand how annual members and casual riders differ.” so I decided to break this question in to smaller pieces. 
To do this detailed analysis, to show the difference between type of riders, I needed to manipulate this data table. So, I decided to add some columns in the table instead of writing queries again and again, I decided to permanently add frequently used columns.
## Data Analysis
To better answer the business question, I broke down the question in smaller steps to show how different users use different types of bikes and when they frequently use it.
1. Number of rides booked (%) per user category during 2021.
2. Number of rides booked per month per user category during 2021.
3. Which day of the week is most popular among different category riders?
4. Which month of the year is the most busy by different category riders?
5. What is the average ride time for different category riders, by year?
6. What is the average ride time for different category riders by month?
7. Top 1,000 longest rides belong to which type of riders?
8. Top 5 stations as a starting point for “member” category riders?
9. Top 5 stations as a starting point for “casual” category riders?
10. What time of the day, member and casual riders start their ride at?
11. Which bike type is most popular among different riders?
12. Bike use by different category riders during working week & Weekend?
```sql
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
```
## Visualizations
- Number of rides booked (%) per user category during 2021.
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/4b1380fe-11fa-43ea-918c-b3a0f1cc71c4)

- Number of rides booked per month per user category during 2021.
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/c5a82ad1-253f-4702-96ce-a1d4bf56d4f0)

- Which day of the week is most popular among different category riders?
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/cdfbee10-29fa-45db-ac98-270ae2a7d2ae)

- Which month of the year is the most busy by different category riders?
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/eced0006-2ee9-4792-aafb-7842c5b88ff8)

- What is the average ride time for different category riders, by year?
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/289dd3d9-20ae-4a2f-a357-61852d10c09e)

- What is the average ride time for different category riders by month?
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/13378969-9d8d-4e2f-99cc-bfc3833eb8c3)

- Top 5 stations as a starting point for “member” category riders?                                           
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/cda1833b-ebd1-4267-8351-6734e82b32af)

- Top 5 stations as a starting point for “casual” category riders?                                            
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/d2e6e59c-3799-442e-a675-8d17d99fad7d)

- What time of the day, member and casual riders start their ride at?
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/bcb2c0c2-3a2a-4375-8c59-47f63a153713)

- Which bike type is most popular among different riders?
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/9d5f92d4-b218-45ea-bbf5-73e1d56a6936)

- Bike use by different category riders during working week & Weekend?
![image](https://github.com/sarim64/Key-to-Speedy-Success-for-Cyclistic/assets/147341497/4784bea3-7a70-49ff-b5bc-d14e15657250)

## Conclusion
- After a detailed analysis, keeping in mind the core business task, I have come to the conclusion that:
- We can safely say that the members book more rides as compared to casual riders.
- Percentage of booking rides by members, is more than casual riders, except for July and August. In July and August, booking of casual rides exceed member rides.
- Casual riders book more rides on Saturday and Sunday as compared to members. Members book more rides from Monday to Friday compared to casual riders.
- The month of July is the most popular month for casual riders, whereas July, August & September are most popular among member riders.
R- ide average time of casual riders is more than double of average ride time of members.
- The monthly average ride time of casual riders is always way more than the average monthly ride time of members throughout the year.
- Top 1,000+ longest bike rides belong to casual riders.
- Top 5 start stations of members are very different from the top 5 start stations of “casual” riders.
- Majority of the members start their rides at 6PM. But there is also a spike from 7AM to 9AM. Peak hour for casual riders is also 6PM.
- Classic bike type is most popular among both type of riders. Casual riders use other two types of bikes as well. Members do not use “Docked” bikes.
- Members book more rides than casual riders during the working week, i.e. Monday - Friday, and casual riders book more rides over the weekend as compared to members.
## Recommendations
1. From the data, we know the most popular days of the week for casual riders are Saturday and Sunday, we should run a marketing campaign one or two days before the weekend highlighting member benefits. 
2. June-Sep are most popular among casual riders. We should focus these months of the year targeting casual riders.
3. We know top starting points by casual riders, we can place billboards type marketing near these stations.
4. Longest rides are booked by casual riders, we can run a campaign by highlighting cost and benefits of member subscription.
## Data Limitations
Financial data is not available. I don't know how much revenue comes from members and casual riders.
Availability of financial data would help me better answer this business task, and it also would help write even better recommendations.
