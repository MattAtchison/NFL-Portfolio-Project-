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

## 📸 SQL Data Cleaning & Normalization (Screenshots)
_Example sections to add:_
- SQL cleaning scripts
- Null checks
- Data transformations

## 📸 Data Modeling - ERD (Screenshots)
_Example sections to add:_
- Final Entity Relationship Diagram (ERD) visualization

## 📸 SQL Analytical Insights (Screenshots)
_Example sections to add:_
- SQL queries using window functions
- Insights from player and team stats

## 📸 Tableau Dashboards (Screenshots)
_Example sections to add:_
- Player performance dashboards
- QB rating and win analysis
- Team performance comparisons

## 📈 Next Steps
- Expand analysis to postseason and player injuries.
- Build predictive models (e.g., win probability, player performance forecasts).
- Deploy dashboard to Tableau Public or integrate into a web app.




