/*
=====================================================================
 COVID-19 DATA EXPLORATION  |  SQL Portfolio Project #1
=====================================================================
 Skills demonstrated: Joins, CTEs, Windows Functions, Aggregate
 Functions, Views, Data Type Casting, Date Functions

 Database   : SQLite (self-contained, runs anywhere)
 Data source: Our World in Data - COVID-19 deaths & vaccinations
              (via AlexTheAnalyst/PortfolioProjects)
 Reproduce  : python build_covid_db.py  then  python run_queries.py
=====================================================================
*/

-----------------------------------------------------------------------
-- 1. Start with the raw table - verify what we are working with
-----------------------------------------------------------------------
SELECT *
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;

-----------------------------------------------------------------------
-- 2. Baseline: core columns for analysis
-----------------------------------------------------------------------
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;

-----------------------------------------------------------------------
-- 3. Total Cases vs Total Deaths (within a single country)
--    Shows likelihood of dying if you contract COVID in India
-----------------------------------------------------------------------
SELECT location, date, total_cases, total_deaths,
       CAST(total_deaths AS REAL) / total_cases * 100 AS death_percentage
FROM CovidDeaths
WHERE location LIKE '%India%'
  AND continent IS NOT NULL
ORDER BY date;

-----------------------------------------------------------------------
-- 4. Total Cases vs Population (India)
--    Shows what percentage of the Indian population got infected
-----------------------------------------------------------------------
SELECT location, date, population, total_cases,
       CAST(total_cases AS REAL) / population * 100 AS percent_population_infected
FROM CovidDeaths
WHERE location LIKE '%India%'
ORDER BY date;

-----------------------------------------------------------------------
-- 5. Countries with the Highest Infection Rate vs Population
-----------------------------------------------------------------------
SELECT location, population,
       MAX(total_cases) AS highest_infection_count,
       ROUND(MAX(CAST(total_cases AS REAL) / population) * 100, 2) AS percent_population_infected
FROM CovidDeaths
GROUP BY location, population
ORDER BY percent_population_infected DESC;

-----------------------------------------------------------------------
-- 6. Countries with the Highest Death Count per Population
-----------------------------------------------------------------------
SELECT location, MAX(CAST(total_deaths AS INTEGER)) AS total_death_count
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC;

-----------------------------------------------------------------------
-- 7. BREAKING THINGS DOWN BY CONTINENT
--    Continents with the highest death count per population
-----------------------------------------------------------------------
SELECT continent, MAX(CAST(total_deaths AS INTEGER)) AS total_death_count
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC;

-----------------------------------------------------------------------
-- 8. GLOBAL NUMBERS (totals worldwide)
-----------------------------------------------------------------------
SELECT SUM(new_cases) AS total_cases,
       SUM(CAST(new_deaths AS INTEGER)) AS total_deaths,
       SUM(CAST(new_deaths AS INTEGER)) / SUM(new_cases) * 100 AS death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL;

-----------------------------------------------------------------------
-- 9. Total Population vs Vaccinations (rolling count)
--    Shows the % of population that received at least one dose.
--    Uses a WINDOW FUNCTION with PARTITION BY location.
-----------------------------------------------------------------------
SELECT dea.continent, dea.location, dea.date, dea.population,
       vac.new_vaccinations,
       SUM(CAST(vac.new_vaccinations AS INTEGER))
           OVER (PARTITION BY dea.location ORDER BY dea.date) AS rolling_people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
  ON dea.location = vac.location
 AND dea.date      = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY dea.location, dea.date;

-----------------------------------------------------------------------
-- 10. Using a CTE to perform the Calculation on the PARTITION BY
--     from the previous query
-----------------------------------------------------------------------
WITH PopvsVac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated)
AS (
  SELECT dea.continent, dea.location, dea.date, dea.population,
         vac.new_vaccinations,
         SUM(CAST(vac.new_vaccinations AS INTEGER))
             OVER (PARTITION BY dea.location ORDER BY dea.date) AS rolling_people_vaccinated
  FROM CovidDeaths dea
  JOIN CovidVaccinations vac
    ON dea.location = vac.location
   AND dea.date     = vac.date
  WHERE dea.continent IS NOT NULL
)
SELECT *, ROUND(rolling_people_vaccinated / population * 100, 2) AS percent_population_vaccinated
FROM PopvsVac;

-----------------------------------------------------------------------
-- 11. Create a View for later visualization (Tableau/Power BI)
-----------------------------------------------------------------------
CREATE VIEW percent_population_vaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population,
       vac.new_vaccinations,
       SUM(CAST(vac.new_vaccinations AS INTEGER))
           OVER (PARTITION BY dea.location ORDER BY dea.date) AS rolling_people_vaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
  ON dea.location = vac.location
 AND dea.date     = vac.date
WHERE dea.continent IS NOT NULL;