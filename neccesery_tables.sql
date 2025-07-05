-- Creating tables containing variables
CREATE TEMPORARY TABLE temp_variables AS
SELECT DISTINCT Variable
FROM euyearltwo;

CREATE TABLE Variables AS
SELECT 
    ROW_NUMBER() OVER() AS variable_id,
    Variable
FROM temp_variables;

ALTER TABLE Variables
MODIFY COLUMN variable_id INT;

ALTER TABLE Variables
ADD CONSTRAINT PK_Variables PRIMARY KEY (variable_id);

-- Creating table containing countries with needed data


CREATE TEMPORARY TABLE temp_countries AS
SELECT DISTINCT 
    Area,
    `Country code`,
    EU,
    OECD,
    G20,
    G7
FROM euyearltwo
WHERE Area != 'EU';

CREATE TABLE Countries AS
SELECT 
    ROW_NUMBER() OVER() AS country_id,
    Area,
    `Country code`,
    EU,
    OECD,
    G20,
    G7
FROM temp_countries;

ALTER TABLE Countries
MODIFY COLUMN country_id INT;

ALTER TABLE Countries
ADD CONSTRAINT PK_Countries PRIMARY KEY (country_id);

-- TABLE WITH THE ELECTRICITY GENERATION

CREATE TABLE Energy_Generated AS
SELECT 
    Area, 
    Year,
    Variable,
    Category,
    Subcategory,
    Value AS Generated_TWh,
    `YoY % change`,
    `YoY absolute change`
FROM euyearltwo
WHERE Category = 'Electricity generation'
  AND Variable != 'Total generation'
  AND Unit = 'TWh'
  AND Area != 'EU';

-- Add FK fields
ALTER TABLE Energy_Generated
ADD COLUMN area_id INT,
ADD COLUMN variable_id INT;

-- Populate FK columns
UPDATE Energy_Generated eg
JOIN Variables v ON v.Variable = eg.Variable
SET eg.variable_id = v.variable_id;

UPDATE Energy_Generated eg
JOIN Countries c ON c.Area = eg.Area
SET eg.area_id = c.country_id;

-- Add constraints
ALTER TABLE Energy_Generated
ADD CONSTRAINT FK_Generated_Area FOREIGN KEY (area_id) REFERENCES Countries(country_id),
ADD CONSTRAINT FK_Generated_Variable FOREIGN KEY (variable_id) REFERENCES Variables(variable_id);

 -- Table with electricity demand

CREATE TABLE Energy_Demand AS
SELECT 
    Area, 
    Year,
    Unit,
    Category,
    Subcategory,
    Value AS Demand,
    `YoY % change`,
    `YoY absolute change`
FROM euyearltwo
WHERE Category = 'Electricity Demand'
  AND Variable = 'Demand'
  AND Unit = 'TWh'
  AND Area != 'EU';

ALTER TABLE Energy_Demand
ADD COLUMN area_id INT;

UPDATE Energy_Demand ed
JOIN Countries c ON c.Area = ed.Area
SET ed.area_id = c.country_id;

ALTER TABLE Energy_Demand
ADD CONSTRAINT FK_Demand_Area FOREIGN KEY (area_id) REFERENCES Countries(country_id);

 
UPDATE Energy_demand
SET area_id = (SELECT country_id
 FROM countries
 WHERE countries.Area = Energy_demand.Area);
 

 ALTER TABLE Energy_demand
 ADD CONSTRAINT Fk_areaDemandID
 FOREIGN KEY (area_id)
 REFERENCES countries(country_id);
 
 -- CO2 Emissions tables
 
CREATE TABLE CO2_Emissions AS
SELECT 
    Area,
    Year,
    Category,
    Variable,
    Value AS gCO2e_per_kWh,
    `YoY absolute change`,
    `YoY % change`
FROM euyearltwo
WHERE Category = 'Power sector emissions'
  AND Subcategory = 'CO2 intensity'
  AND Area != 'EU';

ALTER TABLE CO2_Emissions
ADD COLUMN area_id INT,
ADD COLUMN variable_id INT;

UPDATE CO2_Emissions ce
JOIN Variables v ON v.Variable = ce.Variable
SET ce.variable_id = v.variable_id;

UPDATE CO2_Emissions ce
JOIN Countries c ON c.Area = ce.Area
SET ce.area_id = c.country_id;

ALTER TABLE CO2_Emissions
ADD CONSTRAINT FK_Emissions_Area FOREIGN KEY (area_id) REFERENCES Countries(country_id),
ADD CONSTRAINT FK_Emissions_Variable FOREIGN KEY (variable_id) REFERENCES Variables(variable_id);

 
-- CO2 Emissions Table (MtCO2e)
CREATE TABLE MtCO2e AS
SELECT 
    Area,
    Year,
    Category,
    Variable,
    Value AS MtCO2e,
    `YoY absolute change`,
    `YoY % change`,
    Unit
FROM euyearltwo
WHERE Category = 'Power sector emissions'
  AND Unit = 'MtCO2e'
  AND Area != 'EU';

ALTER TABLE MtCO2e
ADD COLUMN area_id INT,
ADD COLUMN variable_id INT;

UPDATE MtCO2e m
JOIN Variables v ON v.Variable = m.Variable
SET m.variable_id = v.variable_id;

UPDATE MtCO2e m
JOIN Countries c ON c.Area = m.Area
SET m.area_id = c.country_id;

ALTER TABLE MtCO2e
ADD CONSTRAINT FK_MtCO2e_Area FOREIGN KEY (area_id) REFERENCES Countries(country_id),
ADD CONSTRAINT FK_MtCO2e_Variable FOREIGN KEY (variable_id) REFERENCES Variables(variable_id);
 
 
 
 