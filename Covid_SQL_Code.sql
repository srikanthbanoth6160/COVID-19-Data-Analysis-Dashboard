-- Exploring Initial Data
SELECT *
FROM CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 3, 4;

-- Selecting Key Data Fields
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1, 2;

-- Total Cases vs Total Deaths (Likelihood of Death if Infected)
SELECT Location, date, total_cases, total_deaths, 
       (total_deaths / total_cases) * 100 AS DeathPercentage
FROM CovidDeaths
WHERE location LIKE '%states%'
AND continent IS NOT NULL 
ORDER BY 1, 2;

-- Total Cases vs Population (Percentage of Population Infected)
SELECT Location, date, Population, total_cases, 
       (total_cases / population) * 100 AS PercentPopulationInfected
FROM CovidDeaths
ORDER BY 1, 2;

-- Countries with Highest Infection Rate Compared to Population
SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount,  
       MAX((total_cases / population)) * 100 AS PercentPopulationInfected
FROM CovidDeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC;

-- Countries with Highest Death Count per Population
SELECT Location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY Location
ORDER BY TotalDeathCount DESC;

-- Continents with Highest Death Count
SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- Global COVID-19 Numbers
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, 
       (SUM(CAST(new_deaths AS INT)) / SUM(new_cases)) * 100 AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1, 2;

-- Total Population vs Vaccinations (Percentage of Population Vaccinated)
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
ORDER BY 2, 3;

-- Using CTE for Vaccination Analysis
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) AS (
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
           SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
    FROM CovidDeaths dea
    JOIN CovidVaccinations vac
    ON dea.location = vac.location AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL 
)
SELECT *, (RollingPeopleVaccinated / Population) * 100 AS PercentVaccinated
FROM PopvsVac;

-- Using Temp Table for Vaccination Analysis
DROP TABLE IF EXISTS #PercentPopulationVaccinated;
CREATE TABLE #PercentPopulationVaccinated (
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population NUMERIC,
    New_vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location AND dea.date = vac.date;

SELECT *, (RollingPeopleVaccinated / Population) * 100 AS PercentVaccinated
FROM #PercentPopulationVaccinated;

-- Creating View for Future Analysis
CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
