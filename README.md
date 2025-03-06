# COVID-19 Data Analysis and Visualization

## 📌 Project Overview

This project analyzes COVID-19 data using SQL queries and presents insights through a Tableau dashboard. The dataset includes information on COVID-19 cases, deaths, and vaccinations globally. The analysis helps in understanding trends in infection rates, mortality, and vaccination coverage.

## 📂 Datasets Used

- **CovidDeaths.xlsx** - Contains data on COVID-19 cases, deaths, and population across different locations.
- **CovidVaccinations.xlsx** - Contains data on COVID-19 vaccination statistics.

## 📊 Data Analysis using SQL

The SQL queries in this project focus on the following analyses:

### 🔍 1. Exploring Initial Data
Retrieve all data from the CovidDeaths dataset while filtering out null continents.

### 📌 2. Key Data Fields
Select important fields such as location, date, total cases, new cases, total deaths, and population.

### ⚠️ 3. Case Fatality Rate
Compute the likelihood of death if infected by dividing total deaths by total cases.

### 🦠 4. Infection Rate
Calculate the percentage of the population infected.

### 🌎 5. Highest Infection Rate per Country
Identify countries with the highest infection rate relative to their population.

### 💀 6. Highest Death Count per Country
Determine the countries with the highest total death count.

### 🌍 7. Death Count by Continent
Aggregate total deaths per continent.

### 📈 8. Global COVID-19 Summary
Compute total cases, total deaths, and overall death percentage globally.

### 💉 9. Vaccination Analysis
Compare total population vs. vaccinations to determine the percentage of people vaccinated.

Use Common Table Expressions (CTE) and temporary tables for better analysis.

### 🔄 10. Creating Views for Future Analysis
Store vaccination percentage data in a SQL view for easy retrieval.

## 📊 Data Visualization in Tableau

A Tableau dashboard was created to visualize key findings, including:
- COVID-19 trends over time.
- Case fatality and infection rates.
- Vaccination progress globally.

## 🛠 Tools Used

- **SQL Server** for data analysis
- **Tableau** for visualization
- **Excel** for dataset storage

## 🤝 Contributing

Contributions are welcome! Feel free to fork this repository and submit pull requests.

## 📢 Conclusion

This project provides valuable insights into the impact of COVID-19, helping to understand trends in infections, deaths, and vaccinations worldwide. The combination of SQL analysis and Tableau visualizations makes it easier to interpret the data and extract meaningful conclusions.

