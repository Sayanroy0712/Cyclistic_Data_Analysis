# Cyclistic Data Analysis
#### Author: Sayan Roy
#### Date: 05/08/2023

*Note: Please refer to the files in this repository to find all of the data/code/graphs/tables found in this report and much more.*

*Tableau Visualizations: [Click here](https://public.tableau.com/views/CyclisticDataAnalysis_16912169488070/Dashboard1?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link)*
___

## Introduction
 
Cyclistic is a Bike-Sharing coompany based in Chicago that possess more than 5,800 bicycles and 600 docking stations. Cyclistic users are more likely to use their bikes for leisure, but about 30% use them to commute for work each day. Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. The company offers single day passes, full day passes for a price for casual users, and provie an annual subscription fee for its members. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members. 

Cyclistic has concluded that annual members are much more profitable than casual riders. Therefore, maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, they believe creating a marketing campaign solely focused on casual users would help convert casual users into members. The company has set a clear goal of designing marketing strategies aimed at converting casual users into members. In order to do so they need to better understand the difference between how casual users differ from subscribed members and interest in analyzing the historical bike data trip to help identify trends.

___
# PHASES OF ANALYSIS:

## ASK:


The first phase of Data Analysis is ASK. Here we fully understand stakeholder expectations and define our problem statement.

The Company's analysts have inferred that annual members are much more profitable for the company than casual users, so they believe that the key of the company's future is depended upon maximizing the number of annual memberships. 

The business-related problem statements that could be asked to improve the company's growth rate and success is shared below:
 1. How do casual users and annual subcribed members use Cyclistic Bikes differently?
 2. How can we design new marketing strategies to help convert casual members into annual members?

___


## PREPARE: 


This phase is where we collect and store data for usage in the upcoming analysis process.

I have used Microsoft SQL Server Management Studio to help process and analyze the datasets. For this project, I've used the 12 cyclist-data datasets dated from January 2022 to December 2022. To download the dataset click on this [link](https://divvy-tripdata.s3.amazonaws.com/index.html) to access the website  as .zip files.

#### Things that we prepare :

1. Import all of the dataset as a workbook file to the database server.
2. Go through the data and verify if the data types of each of the columns in each dataset is same.
3. Creating a table to merge 12 datasets into one table for better usability.


## PROCESS:

Here we find and eliminate any errors or inaccuracies that can get in the way of results.
(Refer to the SQL Codes in the repository to process the data)

#### To process the data we:

1. Check for unique columns.
2. Add new columns by calculating ride lengths.
3. Extract Month Name, Month Number and Year from datetime column.
4. Remove bad data like null values,incorrect data and duplicates.

___


## ANALYSE:

It involves using tools to transform and organize the information so that we can draw useful conclusion, make predictions and drive oinformed decision making.
(Refer to the SQL Codes in the repository to analyse the data)

#### To analyse the data we:

1. Calculate Total Number of Riders by User Type and Creating View to store date for Further Visualization 
2. Calculate Number of Riders Each Day by User Type and Creating View to store date for Further Visualization.
3. Calculate Average Ride Length for Each User Type and Creating View to store data for further Data Visualization.
4. Create temporary tables exclusively for Casual Users and Members.
5. Analyze the Ride Types for Casual and Member Users.
6. Calculate Most Popular Stations for Casual and Member Users. (limiting results to top 20 station)
7. Calculate User Traffic per Month.
8. Calculate Average Ride Length Every Month.
9. Calculate Daily Traffic.
10. Calculate Daily Average Ride Length.
11. Calculate Hourly Traffic.
12. Calculate  Hourly Average Ride Length.
    
___


## SHARE:

In this phase, we will be visualizing the data analyzed and tables created using Tableau Public.
(Refer to the Dashboard images in the repository to visualize the data)

#### Visualizing the data by showing:

1. Average Ride Duration.
2. Users Per Day Of the Week.
3. Hourly Traffic Analysis of Users.
4. Monthly User Traffic.
5. Most Popular Stations for Casual Users.

___


## ACT:

After performing the collection, transformation, cleaning, organisation and analysis of the given 12 datasets, we have enough factual evidence to suggest answers to the business-related questions that were asked.

We can infer that casual users are more likely to use their bikes for a longer duration of time. Casual users are also more inclined to ride during evening hours of **3:00PM - 7PM** and weekends is when most of the casual users prefer to ride. While user traffic for both groups are highest during the months of summer, the months of winter is when user traffic significantly drops for both types.

In order to design new marketing strategies to better focus on and suit the casual users to help convert them into buying annual memberships, we have to refer to the analysis provided above and keep those facts in mind. 

#### Top Recommendations to Marketing Strategists:

1. Implement advertising annual memberships prices more using billboards/posters near the top 20 most popular stations for casual users.
2. Provide a limited discount on annual memberships purchased during the months of lowest traffic to increase rider usage in these months.
3. Have frequent advertisements on social media and television during peak hours and peak months, since that is when most people have a thought about riding bikes.
4. Consider provide free ride minutes for every minute passed after 30 minutes of usage, where the free minutes can **ONLY** be redeemed on weekdays to help promote rider 
   usage during weekdays. 




