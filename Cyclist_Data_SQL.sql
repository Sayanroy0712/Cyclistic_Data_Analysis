/*

CYCLISTIC CASE STUDY 

*/

-- VIEWING OF DATA BY MONTH

Select *
From CyclisticData..Jan

Select *
From CyclisticData..Feb

Select *
From CyclisticData..Mar

Select *
From CyclisticData..Apr

Select *
From CyclisticData..May
 
Select *
From CyclisticData..Jun

Select *
From CyclisticData..Jul
 
Select *
From CyclisticData..Aug

Select *
From CyclisticData..Sep

Select *
From CyclisticData..Oct

Select *
From CyclisticData..Nov
 
Select *
From CyclisticData..Dec



-- CHANGING DATA TYPES OF SIMILAR COLUMNS



ALTER TABLE CyclisticData..Apr
ALTER COLUMN start_station_id nvarchar(255);

ALTER TABLE CyclisticData..Jul
ALTER COLUMN start_station_id nvarchar(255);

ALTER TABLE CyclisticData..Nov
ALTER COLUMN start_station_id nvarchar(255);

ALTER TABLE CyclisticData..Oct
ALTER COLUMN start_station_id nvarchar(255);

ALTER TABLE CyclisticData..Dec
ALTER COLUMN end_station_id nvarchar(255);

ALTER TABLE CyclisticData..Nov
ALTER COLUMN end_station_id nvarchar(255);

ALTER TABLE CyclisticData..Sep
ALTER COLUMN end_station_id nvarchar(255);




-- JOINING ALL THE TABLES INTO ANOTHER TABLE



Create Table Data(
ride_id	nvarchar(255),
rideable_type	nvarchar(255),
started_at	datetime,
ended_at	datetime,
start_station_name	nvarchar(255),
start_station_id	nvarchar(255),
end_station_name	nvarchar(255),
end_station_id	nvarchar(255),
start_lat	float,
start_lng	float,
end_lat	float,
end_lng	float,
member_casual	nvarchar(255))

Insert into Data(ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
member_casual)
Select *
From CyclisticData..Jan
UNION 
Select *
From CyclisticData..Feb
UNION 
Select *
From CyclisticData..Mar
UNION
Select *
From CyclisticData..Apr
UNION 
Select *
From CyclisticData..May
UNION 
Select *
From CyclisticData..Jun
UNION
Select *
From CyclisticData..Jul
UNION 
Select *
From CyclisticData..Aug
UNION 
Select *
From CyclisticData..Sep
UNION
Select *
From CyclisticData..Oct
UNION 
Select *
From CyclisticData..Nov
UNION 
Select *
From CyclisticData..Dec

Select * from Data



--LOOKING FOR UNIQUE DATA ITEMS



Select DISTINCT rideable_type
From Data

Select DISTINCT start_station_name
From Data

Select DISTINCT start_station_id
From Data

Select DISTINCT end_station_name
From Data

Select DISTINCT end_station_id
From Data

Select DISTINCT member_casual
From Data



--PROCESSING DATA



-- Adding a new column to calculate the ride length from datetime2

Alter Table Data			
Add ride_length int

Update Data
Set ride_length = DATEDIFF(MINUTE, started_at, ended_at)

-- Extracting month and year from datetime2 format and adding them as new columns

Alter Table Data				
Add day_of_week nvarchar(50),
month_m nvarchar(50),
year_y nvarchar(50)

Update Data
Set day_of_week = DATENAME(WEEKDAY, started_at),
month_m = DATENAME(MONTH, started_at),
year_y = year(started_at)

-- Extracting month num from datetime2 format

Alter Table Data      
Add month_int int

Update Data						
Set month_int = DATEPART(MONTH, started_at)

-- Casting datetime2 format to date

Alter Table Data     
Add date_yyyy_mm_dd date

Update Data						
Set date_yyyy_mm_dd = CAST(started_at AS date)



-- CLEANING DATA



-- Deleted rows where (NULL values), (ride length = 0), (ride length < 0), (ride_length > 1440 mins) for accurate analysis

Delete From Data				
Where ride_id IS NULL OR
start_station_name IS NULL OR
ride_length IS NULL OR
ride_length = 0 OR
ride_length < 0 OR
ride_length > 1440

-- Checking for any duplicates by checking count

Select Count(DISTINCT(ride_id)) AS uniqe,
Count(ride_id) AS total
From Data

-- Calculating Total Number of Riders by User Type and Creating View to store date for Further Visualization 

Create View total_users AS
Select 
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_members,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(*) AS num_of_users
From Data

-- Calculating Number of Riders Each Day by User Type and Creating View to store date for Further Visualization 

Create View users_per_day AS
Select 
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_members,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(*) AS num_of_users,
day_of_week
From Data
Group By day_of_week

--Calculating Average Ride Length for Each User Type and Creating View to store data for further Data Visualization

Create View avg_ride_length AS
SELECT member_casual AS user_type, AVG(ride_length)AS avg_ride_length
From Data
Group BY member_casual

-- Creating temporary tables exclusively for Casual Users and Members

CREATE TABLE #member_table (
ride_id	nvarchar(255),
rideable_type	nvarchar(255),
started_at	datetime,
ended_at	datetime,
start_station_name	nvarchar(255),
start_station_id	nvarchar(255),
end_station_name	nvarchar(255),
end_station_id	nvarchar(255),
start_lat	float,
start_lng	float,
end_lat	float,
end_lng	float,
ride_length int,
day_of_week nvarchar(50),
month_m nvarchar(50),
year_y int )

INSERT INTO #member_table (ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
ride_length, 
day_of_week, 
month_m, 
year_y)
(Select ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
ride_length, 
day_of_week, 
month_m, 
year_y
From Data
Where member_casual = 'member')


Select *
From #member_table



CREATE TABLE #casual_table (
ride_id	nvarchar(255),
rideable_type	nvarchar(255),
started_at	datetime,
ended_at	datetime,
start_station_name	nvarchar(255),
start_station_id	nvarchar(255),
end_station_name	nvarchar(255),
end_station_id	nvarchar(255),
start_lat	float,
start_lng	float,
end_lat	float,
end_lng	float,
ride_length int,
day_of_week nvarchar(50),
month_m nvarchar(50),
year_y int )

INSERT INTO #casual_table (ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
ride_length, 
day_of_week, 
month_m, 
year_y)
(Select ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
ride_length, 
day_of_week, 
month_m, 
year_y
From Data
Where member_casual = 'casual')

Select *
From #casual_table





--Looking at the type of rides



Select rideable_type,COUNT(*) AS member_rides
From #casual_table
Group by rideable_type

Select rideable_type,COUNT(*) AS member_rides
From #member_table
Group by rideable_type



-- Looking at the most popular start stations

Select start_station_name,start_lat,start_lng,COUNT(*) AS number_of_member_rides
From Data
Where ride_length < 1440
            AND ride_length > 0
            AND member_casual = 'member'
            AND start_station_name != 'null'
Group By start_station_name,start_lat,start_lng
Order By COUNT(*) DESC

Select start_station_name,start_lat,start_lng,COUNT(*) AS number_of_member_rides
From Data
Where ride_length < 1440
            AND ride_length > 0
            AND member_casual = 'casual'
            AND start_station_name != 'null'
Group By start_station_name,start_lat,start_lng
Order By COUNT(*) DESC



-- Looking at the most popular end stations



Select end_station_name,end_lat,end_lng,COUNT(*) AS number_of_member_rides
From Data
Where ride_length < 1440
            AND ride_length > 0
            AND member_casual = 'member'
            AND start_station_name != 'null'
Group By end_station_name,end_lat,end_lng
Order By COUNT(*) DESC

Select end_station_name,end_lat,end_lng,COUNT(*) AS number_of_member_rides
From Data
Where ride_length < 1440
            AND ride_length > 0
            AND member_casual = 'casual'
            AND start_station_name != 'null'
Group By end_station_name,end_lat,end_lng
Order By COUNT(*) DESC



-- Calculating User Traffic Every Month 



Select month_int AS Month_Num,
month_m AS Month_Name, 
year_y AS Year_Y,
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_member,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(member_casual) AS total_num_of_users, AVG(ride_length)
From Data
Group BY year_y, month_int, month_m
ORDER BY year_y, month_int, month_m


-- Calculating Average Ride Length Every Month 



Select month_int AS Month_Num,
month_m AS Month_Name, 
year_y AS Year_Y, AVG(ride_length) as Member_Avg
From Data
Where member_casual = 'member'
Group BY year_y, month_int, month_m
ORDER BY year_y, month_int, month_m

Select month_int AS Month_Num,
month_m AS Month_Name, 
year_y AS Year_Y, AVG(ride_length) as Casual_Avg
From Data
Where member_casual = 'casual'
Group BY year_y, month_int, month_m
ORDER BY year_y, month_int, month_m



-- Calculating Daily Traffic  



Select 
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_members,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(*) AS num_of_users,
date_yyyy_mm_dd AS date_d, AVG(ride_length)
From Data
Group BY date_yyyy_mm_dd
ORDER BY date_yyyy_mm_dd



-- Calculating Daily Average Ride Length 

Select 
date_yyyy_mm_dd AS date_d, AVG(ride_length) as Member_Avg
From Data
Where member_casual = 'member'
Group BY date_yyyy_mm_dd
ORDER BY date_yyyy_mm_dd

Select 
date_yyyy_mm_dd AS date_d, AVG(ride_length) as Casual_Avg
From Data
Where member_casual = 'casual'
Group BY date_yyyy_mm_dd
ORDER BY date_yyyy_mm_dd


 -- Calculating User Traffic Hour Wise



Alter Table Data
ADD hour_of_day int

UPDATE Data
SET hour_of_day = DATEPART(hour, started_at)

Select
hour_of_day AS Hour_of_day,
Count(case when member_casual = 'member' then 1 else NULL END) AS num_of_members,
Count(case when member_casual = 'casual' then 1 else NULL END) AS num_of_casual,
Count(*) AS num_of_users, AVG(ride_length)
From Data
Group By Hour_Of_Day
Order By Hour_Of_Day



 -- Calculating  Hourly Average Ride Length



Select
hour_of_day AS Hour_of_day, AVG(ride_length) as Member_Avg
From Data
Where member_casual = 'member'
Group By Hour_Of_Day
Order By Hour_Of_Day

Select
hour_of_day AS Hour_of_day, AVG(ride_length) as Casual_Avg
From Data
Where member_casual = 'casual'
Group By Hour_Of_Day
Order By Hour_Of_Day
