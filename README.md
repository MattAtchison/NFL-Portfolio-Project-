# 🏈 NFL Data Engineering & Analysis Project
A comprehensive pipeline for scraping NFL data from the ESPN website using Selenium and backend JSON APIs, cleaning and modeling the data in a MySQL database, and generating advanced insights and visualizations through SQL, Python, and Tableau.

## 📚 Table of Contents
- [Project Overview](#-project-overview)
- [Objectives](#-objectives)
- [Tools Utilized](#-tools-utilized)
- [Python Data Extraction (Screenshots)](#-python-data-extraction-screenshots)
- [SQL Data Cleaning & Normalization (Screenshots)](#-sql-data-cleaning--normalization-screenshots)
- [Data Modeling - ERD (Screenshots)](#-data-modeling---erd-screenshots)
- [SQL Analytical Insights (Screenshots)](#-sql-analytical-insights-screenshots)
- [Tableau Dashboards (Screenshots)](#-tableau-dashboards-screenshots)
- [Next Steps](#-next-steps)

## 🚀 Project Overview
This project demonstrates a full end-to-end data engineering and analytics workflow centered around NFL data.

- Data is extracted from ESPN using a combination of backend APIs, JSON data, and Selenium for dynamic web pages.
- Loaded into a MySQL database, cleaned and transformed via SQL.
- Modeled with a many-to-many Entity Relationship Diagram (ERD).
- Analyzed and created insights using MySQL.
- Visualized with interactive dashboards in Tableau.

## 🎯 Objectives

### Data Extraction from ESPN
- Scraped comprehensive NFL player and game data across all 18 regular-season weeks.
- Utilized Python with Selenium for dynamic webpage elements.
- Accessed ESPN’s backend API to pull JSON data for detailed game and player stats.
- Transformed and prepared extracted data for database ingestion.

### Data Cleaning and Normalization
- Loaded raw data into MySQL.
- Cleaned the data by removing duplicates, handling nulls, fixing data types, and splitting composite fields.
- Built normalized, relational tables with proper use of primary and foreign keys.
- Created many-to-many relationship tables where needed (e.g., players, games, referees).

### Data Modeling
- Developed an Entity Relationship Diagram (ERD) to map out the database schema.
- Structured data for optimized query performance and scalability.

### Advanced SQL Analytics
- Wrote advanced SQL queries to generate insights.
- Used techniques like:
  - Window Functions (e.g., `LAG`, `ROW_NUMBER`)
  - Joins and Subqueries
  - Common Table Expressions (CTEs)
  - Unions and Data Aggregations

### Interactive Visualization
- Created professional, interactive dashboards in Tableau to showcase key findings.
- Included player performance trends, team comparisons, QB rating analysis, and more.

## 🛠️ Tools Utilized
- **Data Extraction**: Python (Selenium, ESPN API)
- **Database**: MySQL
- **Data Modeling**: LucidCharts
- **Visualization**: Tableau
- **Version Control**: GitHub

## 📸 Python Data Extraction (Screenshots)
For more details, check out the [Python_scrape.py](https://github.com/MattAtchison/NFL-Portfolio-Project-/blob/main/Python_scrape) file.
![image](https://github.com/user-attachments/assets/252ea083-1f5d-4072-a3e4-e84b117f3299)
![image](https://github.com/user-attachments/assets/f3d6abf7-d834-40a5-87b9-5c30844229fe)
![image](https://github.com/user-attachments/assets/dc9dd879-ea7f-433b-924a-cdd50c84567d)


## 📸 SQL Data Cleaning & Normalization (Screenshots)
For more details, check out the [SQL Cleaning Script](https://github.com/MattAtchison/NFL-Portfolio-Project-/blob/main/SQL%20Cleaning%20Script) file.
![image](https://github.com/user-attachments/assets/99bf078c-5304-4c61-ae30-69a209840cad)




## 📸 Data Modeling - ERD (Screenshots)
For more details, check out the [ERD](https://github.com/MattAtchison/NFL-Portfolio-Project-/blob/main/ERD) file.
![image](https://github.com/user-attachments/assets/b9393f53-b47c-4e98-b9cd-4fc36e8badab)
![image](https://github.com/user-attachments/assets/a08c0da6-0e18-4c8f-9e06-7934fe26904d)



## 📸 SQL Analytical Insights (Screenshots)
For more details, check out the [SQL Insights](https://github.com/MattAtchison/NFL-Portfolio-Project-/blob/main/SQL%20Insights) file.
![image](https://github.com/user-attachments/assets/b653663b-87c8-4015-bcec-eeeceff3d2e8)

## 📸 Tableau Dashboards (Screenshots)
For more details, check out the [Dashboard](https://github.com/MattAtchison/NFL-Portfolio-Project-/blob/main/Dashboard) file.
![image](https://github.com/user-attachments/assets/740f5226-4087-4e35-af34-8a2fa6328536)


## 📈 Next Steps
- Expand analysis to postseason and player injuries.
- Build predictive models (e.g., win probability, player performance forecasts).
- Deploy dashboard to Tableau Public or integrate into a web app.




