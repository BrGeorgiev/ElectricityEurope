-- създаване на необходимата таблица
CREATE TABLE europe_year_long(
	`Area` VARCHAR(100),
    `Country code` VARCHAR(100),
    `Year` varchar(50),
    `Area type` VARCHAR(50),
    `Continent` VARCHAR(50),
    `Ember region` VARCHAR(100),
    `EU` VARCHAR(15),
    `OECD` VARCHAR(15),
    `G20` VARCHAR(15),
    `G7` VARCHAR(15),
    `ASEAN` VARCHAR(15),
    `Category` VARCHAR(100),
    `Subcategory` VARCHAR(100),
    `Variable` VARCHAR(150),
    `Unit` VARCHAR(50),
    `Value` varchar(20),
    `YoY absolute change` VARCHAR(50),
    `YoY % change` VARCHAR(50)
);
SHOW VARIABLES LIKE "secure_file_priv";
DROP TABLE europe_year_long;
-- вкарване на данните

LOAD DATA INFILE 'europe_yearly_full_release_long_format.csv'
INTO TABLE europe_year_long
FIELDS terminated BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM europe_year_long;

-- Създаване на резервна работна таблица
CREATE TABLE euyearl LIKE europe_year_long;
INSERT INTO euyearl SELECT * FROM europe_year_long;

-- Изчистване и модифициране на таблицата за удобство
-- 1. Работа по колони Value, YoY % change, YoY absolute change
-- Първа колона - Value

select length(Value),Value from euyearl
ORDER BY length(Value) DESC;

ALTER TABLE euyearl
MODIFY COLUMN Value decimal(8,3);

select sum(Value) FROM euyearl;
-- Проверка на типовете на колоната

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'bgelectricity'
AND TABLE_NAME = 'euyearl';


-- Работа върху колона `YoY % change`
SELECT `YoY % change`, length(`YoY % change`) FROM euyearl
ORDER BY length(`YoY % change`) DESC;

SELECT `YoY % change` from euyearl
WHERE `YoY % change` = "";

UPDATE euyearl
SET `YoY % change` = '0'
WHERE `YoY % change` = "";

ALTER TABLE euyearl
MODIFY COLUMN `YoY % change` decimal(8,3);

-- Работа върху колона `YoY absolute change`
SELECT `YoY absolute change`, length(`YoY absolute change`) FROM euyearl
ORDER BY length(`YoY absolute change`) DESC;

SELECT `YoY absolute change` from euyearl
WHERE `YoY absolute change` = "";

UPDATE euyearl
SET `YoY absolute change` = '0'
WHERE `YoY absolute change` = "";

ALTER TABLE euyearl
MODIFY COLUMN `YoY absolute change` decimal(7,3);

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'bgelectricity'
AND TABLE_NAME = 'euyearl';

-- Работа върху колоните ER, OECD, G20, G7, ASEAN
-- 
SELECT DISTINCT `EU`, `OECD`, `G20`, `G7`, `ASEAN` FROM euyearl;

UPDATE euyearl
SET `EU` = null WHERE `EU` = "";
UPDATE euyearl
SET `EU` = "Yes" WHERE `EU` = "1.0" ;
UPDATE euyearl
SET `EU` = "No" WHERE `EU` = '0.0';

UPDATE euyearl
SET `OECD` = null WHERE `OECD` = "";
UPDATE euyearl
SET `OECD` = "Yes" WHERE `OECD` = "1.0" ;
UPDATE euyearl
SET `OECD` = "No" WHERE `OECD` = '0.0';

UPDATE euyearl
SET `G20` = null WHERE `G20` = "";
UPDATE euyearl
SET `G20` = "Yes" WHERE `G20` = "1.0" ;
UPDATE euyearl
SET `G20` = "No" WHERE `G20` = '0.0';

UPDATE euyearl
SET `G7` = null WHERE `G7` = "";
UPDATE euyearl
SET `G7` = "Yes" WHERE `G7` = "1.0" ;
UPDATE euyearl
SET `G7` = "No" WHERE `G7` = '0.0';

UPDATE euyearl
SET `ASEAN` = null WHERE `ASEAN` = "";
UPDATE euyearl
SET `ASEAN` = "Yes" WHERE `ASEAN` = "1.0" ;
UPDATE euyearl
SET `ASEAN` = "No" WHERE `ASEAN` = '0.0';

-- Работа върху колона Year
SELECT DISTINCT Year FROM euyearl;

ALTER TABLE euyearl
MODIFY COLUMN `Year` YEAR;

-- Проверка за допуснати нулеви/празни стойности или правописни грешки в останалите varchar колониalter

SELECT DISTINCT Area, `Country code` FROM euyearl;
UPDATE euyearl
SET `Country code` = "EU"
WHERE `Area` = "EU";

select * FROM euyearl;
SELECT DISTINCT Continent FROM euyearl;

SELECT * FROM euyearl
WHERE Continent = ""; 

UPDATE euyearl SET `Continent` = "EU" WHERE `Area` = "EU";
UPDATE euyearl SET `Ember region` = "EU" WHERE `Area` = "EU";

SELECT DISTINCT Category FROM euyearl;
SELECT DISTINCT Subcategory FROM euyearl;
SELECT DISTINCT Variable FROM euyearl;
SELECT DISTINCT Unit FROM euyearl;
-- Създаване на трета таблица с въведените досега промени
CREATE TABLE euyearlTwo LIKE euyearl;
INSERT INTO euyearlTwo SELECT * FROM euyearl;

SELECT * FROM euyearlTwo