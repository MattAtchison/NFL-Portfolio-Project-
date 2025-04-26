🏈 NFL Data Engineering & Analysis Project
A comprehensive pipeline for scraping NFL data from the ESPN website using Selenium and backend JSON APIs, cleaning and modeling the data in a MySQL database, and generating advanced insights and visualizations through SQL, Python, and Tableau.

📚 Table of Contents
Project Overview


Objectives


Python Data Extraction (Screenshots)


SQL Data Cleaning & Normalization (Screenshots)


Data Modeling - ERD (Screenshots)


SQL Analytical Insights (Screenshots)


Tableau Dashboards (Screenshots)




🚀 Project Overview
This project demonstrates a full end-to-end data engineering and analytics workflow centered around NFL data.
 Data is extracted from ESPN using a combination of backend APIs and Selenium for dynamic web pages, loaded into a MySQL database, cleaned and transformed via SQL, modeled with a many to many ERD, analyzed and created insights using MYSQL, and visualized with interactive dashboards in Tableau.

🎯 Objectives
Data Extraction from ESPN
 Scraped comprehensive NFL player and game data across all 18 regular-season weeks.


Utilized Python with Selenium for dynamic webpage elements.


Accessed ESPN’s backend API to pull JSON data for detailed game and player stats.


Transformed and prepared extracted data for database ingestion.


Data Cleaning and Normalization


Loaded raw data into MySQL staging tables.


Cleaned the data by removing duplicates, handling nulls, fixing data types, and splitting composite fields.


Built normalized, relational tables with proper use of primary and foreign keys.


Created many-to-many relationship tables where needed (e.g., players, games, referees).


Data Modeling


Developed an Entity Relationship Diagram (ERD) to map out the database schema.


Structured data for optimized query performance and scalability.


Advanced SQL Analytics


Wrote advanced SQL queries to generate insights.


Used techniques like:


Window Functions (e.g., LAG, ROW_NUMBER)


Joins and Subqueries


CTEs


Unions and Data Aggregations


Interactive Visualization


Created professional, interactive dashboards in Tableau to showcase key findings.


Included player performance trends, team comparisons, QB rating analysis, and more.



🛠️ Tools Utilized
Data Extraction: Python (Selenium, ESPN API)


Database: MySQL
LucidCharts - ERD Modeling 
Visualization: Tableau


Version Control: GitHub







📸 Python Data Extraction 
Example sections to add:




📸 SQL Data Cleaning & Normalization 




📸 Data Modeling - ERD (Screenshots)




📸 SQL Analytical Insights (Screenshots)




📸 Tableau Dashboards (Screenshots)




📈 Next Steps
Expand analysis to postseason and player injuries.


Build predictive models (e.g., win probability, player performance forecasts).


Deploy dashboard to Tableau Public or integrate into a web app.



