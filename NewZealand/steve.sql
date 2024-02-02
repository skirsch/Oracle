CREATE TABLE B9 AS
SELECT
    TO_CHAR(vax_date, 'YYYY-MM') AS vax_month,
    dose_number,
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 10 AND 14 THEN '10-14'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 15 AND 19 THEN '15-19'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 20 AND 24 THEN '20-24'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 25 AND 29 THEN '25-29'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 30 AND 34 THEN '30-34'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 35 AND 39 THEN '35-39'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 40 AND 44 THEN '40-44'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 45 AND 49 THEN '45-49'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 50 AND 54 THEN '50-54'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 55 AND 59 THEN '55-59'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 60 AND 64 THEN '60-64'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 65 AND 69 THEN '65-69'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 70 AND 74 THEN '70-74'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 75 AND 79 THEN '75-79'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 80 AND 84 THEN '80-84'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 85 AND 89 THEN '85-89'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 90 AND 94 THEN '90-94'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 95 AND 99 THEN '95-99'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) >= 100 THEN '100+'
        ELSE '0-9'
    END AS age_range,
    COUNT(*) AS num_vaxxed,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 0 AND 29 THEN 1 ELSE 0 END) AS month_1,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 30 AND 59 THEN 1 ELSE 0 END) AS month_2,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 60 AND 89 THEN 1 ELSE 0 END) AS month_3,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 90 AND 119 THEN 1 ELSE 0 END) AS month_4,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 120 AND 149 THEN 1 ELSE 0 END) AS month_5,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 150 AND 179 THEN 1 ELSE 0 END) AS month_6,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 180 AND 209 THEN 1 ELSE 0 END) AS month_7,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 210 AND 239 THEN 1 ELSE 0 END) AS month_8,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 240 AND 269 THEN 1 ELSE 0 END) AS month_9,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 270 AND 299 THEN 1 ELSE 0 END) AS month_10,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 300 AND 329 THEN 1 ELSE 0 END) AS month_11,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 330 AND 360 THEN 1 ELSE 0 END) AS month_12,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 0 AND 365 THEN 1 ELSE 0 END) AS full_year,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 361 AND 389 THEN 1 ELSE 0 END) AS month_13,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 390 AND 419 THEN 1 ELSE 0 END) AS month_14,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 420 AND 449 THEN 1 ELSE 0 END) AS month_15,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 450 AND 479 THEN 1 ELSE 0 END) AS month_16,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 480 AND 509 THEN 1 ELSE 0 END) AS month_17,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 510 AND 539 THEN 1 ELSE 0 END) AS month_18,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 540 AND 569 THEN 1 ELSE 0 END) AS month_19,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 570 AND 599 THEN 1 ELSE 0 END) AS month_20,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 600 AND 629 THEN 1 ELSE 0 END) AS month_21,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 630 AND 659 THEN 1 ELSE 0 END) AS month_22,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 660 AND 689 THEN 1 ELSE 0 END) AS month_23,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 690 AND 720 THEN 1 ELSE 0 END) AS month_24,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 366 AND 730 THEN 1 ELSE 0 END) AS full_year_2
FROM 
    joined_table
WHERE
    dose_number BETWEEN 1 AND 5
GROUP BY 
    TO_CHAR(vax_date, 'YYYY-MM'), dose_number,
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 10 AND 14 THEN '10-14'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 15 AND 19 THEN '15-19'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 20 AND 24 THEN '20-24'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 25 AND 29 THEN '25-29'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 30 AND 34 THEN '30-34'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 35 AND 39 THEN '35-39'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 40 AND 44 THEN '40-44'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 45 AND 49 THEN '45-49'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 50 AND 54 THEN '50-54'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 55 AND 59 THEN '55-59'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 60 AND 64 THEN '60-64'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 65 AND 69 THEN '65-69'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 70 AND 74 THEN '70-74'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 75 AND 79 THEN '75-79'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 80 AND 84 THEN '80-84'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 85 AND 89 THEN '85-89'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 90 AND 94 THEN '90-94'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 95 AND 99 THEN '95-99'
        WHEN TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) >= 100 THEN '100+'
        ELSE '0-9'
    END
ORDER BY 
    vax_month, dose_number, age_range;



-- b5 matches refernce for column 1
-- but this doesn't due to the age calculation
-- for 65 to 69 year olds. Almost same as my earlier query, analysis_65_69_365_day but shoould be smaller numbers since 360
CREATE TABLE B6 AS
SELECT
    TO_CHAR(vax_date, 'YYYY-MM') AS vax_month,
    dose_number,
    COUNT(*) AS num_vaxxed,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 0 AND 365 THEN 1 ELSE 0 END) AS month_1,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 30 AND 59 THEN 1 ELSE 0 END) AS month_2,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 60 AND 89 THEN 1 ELSE 0 END) AS month_3,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 90 AND 119 THEN 1 ELSE 0 END) AS month_4,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 120 AND 149 THEN 1 ELSE 0 END) AS month_5,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 150 AND 179 THEN 1 ELSE 0 END) AS month_6,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 180 AND 209 THEN 1 ELSE 0 END) AS month_7,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 210 AND 239 THEN 1 ELSE 0 END) AS month_8,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 240 AND 269 THEN 1 ELSE 0 END) AS month_9,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 270 AND 299 THEN 1 ELSE 0 END) AS month_10,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 300 AND 329 THEN 1 ELSE 0 END) AS month_11,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 330 AND 360 THEN 1 ELSE 0 END) AS month_12
FROM 
    joined_table
WHERE 
    dose_number BETWEEN 1 AND 4
    AND (vax_date-dob)/365.25 BETWEEN 65 AND 69
GROUP BY 
    TO_CHAR(vax_date, 'YYYY-MM'), dose_number
ORDER BY 
    vax_month, dose_number;


-- b5 matches refernce for column 1
-- for 65 to 69 year olds. Almost same as my earlier query, analysis_65_69_365_day but shoould be smaller numbers since 360
CREATE TABLE B5 AS
SELECT
    TO_CHAR(vax_date, 'YYYY-MM') AS vax_month,
    dose_number,
    COUNT(*) AS num_vaxxed,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 0 AND 365 THEN 1 ELSE 0 END) AS month_1,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 30 AND 59 THEN 1 ELSE 0 END) AS month_2,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 60 AND 89 THEN 1 ELSE 0 END) AS month_3,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 90 AND 119 THEN 1 ELSE 0 END) AS month_4,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 120 AND 149 THEN 1 ELSE 0 END) AS month_5,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 150 AND 179 THEN 1 ELSE 0 END) AS month_6,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 180 AND 209 THEN 1 ELSE 0 END) AS month_7,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 210 AND 239 THEN 1 ELSE 0 END) AS month_8,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 240 AND 269 THEN 1 ELSE 0 END) AS month_9,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 270 AND 299 THEN 1 ELSE 0 END) AS month_10,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 300 AND 329 THEN 1 ELSE 0 END) AS month_11,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 330 AND 360 THEN 1 ELSE 0 END) AS month_12
FROM 
    joined_table
WHERE 
    dose_number BETWEEN 1 AND 4
    AND TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 65 AND 69
GROUP BY 
    TO_CHAR(vax_date, 'YYYY-MM'), dose_number
ORDER BY 
    vax_month, dose_number;



-- this has to be right. for 65 to 69 year olds, num vaxxed and num died in a year
CREATE TABLE b4 AS 
SELECT count(*) as num_vaxxed,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 0 AND 365 THEN 1 ELSE 0 END) AS death_count
    FROM joined_table 
WHERE dose_number=1 and 
    TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 65 AND 69 AND
    trunc(vax_date)<'5-oct-2022';  -- so has 365 days to die



-- for 65 to 69 year olds. Almost same as my earlier query, analysis_65_69_365_day but shoould be smaller numbers since 360
CREATE TABLE B3 AS
SELECT
    TO_CHAR(vax_date, 'YYYY-MM') AS vax_month,
    dose_number,
    COUNT(*) AS num_vaxxed,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 0 AND 29 THEN 1 ELSE 0 END) AS month_1,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 30 AND 59 THEN 1 ELSE 0 END) AS month_2,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 60 AND 89 THEN 1 ELSE 0 END) AS month_3,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 90 AND 119 THEN 1 ELSE 0 END) AS month_4,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 120 AND 149 THEN 1 ELSE 0 END) AS month_5,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 150 AND 179 THEN 1 ELSE 0 END) AS month_6,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 180 AND 209 THEN 1 ELSE 0 END) AS month_7,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 210 AND 239 THEN 1 ELSE 0 END) AS month_8,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 240 AND 269 THEN 1 ELSE 0 END) AS month_9,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 270 AND 299 THEN 1 ELSE 0 END) AS month_10,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 300 AND 329 THEN 1 ELSE 0 END) AS month_11,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 330 AND 360 THEN 1 ELSE 0 END) AS month_12
FROM 
    joined_table
WHERE 
    dose_number BETWEEN 1 AND 4
    AND (vax_date - dob)/365 BETWEEN 65 AND 69
GROUP BY 
    TO_CHAR(vax_date, 'YYYY-MM'), dose_number
ORDER BY 
    vax_month, dose_number;


-- simpler query for 65 to 69 for first two months
CREATE TABLE B1 AS
SELECT
    TO_CHAR(vax_date, 'YYYY-MM') AS vax_month,
    dose_number,
    COUNT(*) AS num_vaxxed,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 0 AND 29 THEN 1 ELSE 0 END) AS month_1,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 30 AND 59 THEN 1 ELSE 0 END) AS month_2
FROM 
    joined_table
WHERE 
    dose_number BETWEEN 1 AND 4
    AND EXTRACT(YEAR FROM vax_date) - EXTRACT(YEAR FROM DOB) BETWEEN 65 AND 69
GROUP BY 
    TO_CHAR(vax_date, 'YYYY-MM'), dose_number
ORDER BY 
    vax_month, dose_number;




-- this is the master query creating for each date and dose, track deaths for 24 months
DECLARE
  sql_query CLOB;
BEGIN
  -- Initialize the SQL query
  sql_query := 'CREATE TABLE a3 AS
                SELECT
                  TO_CHAR(vax_date, ''YYYY-MM'') AS vax_month,
                  dose_number,
                  TRUNC((EXTRACT(YEAR FROM vax_date) - EXTRACT(YEAR FROM dob) + 
                    CASE WHEN EXTRACT(MONTH FROM vax_date) < EXTRACT(MONTH FROM dob) OR 
                              (EXTRACT(MONTH FROM vax_date) = EXTRACT(MONTH FROM dob) AND EXTRACT(DAY FROM vax_date) < EXTRACT(DAY FROM dob))
                    THEN -1 ELSE 0 END) / 5) * 5 + 10 AS age_range,
                  COUNT(*) AS num_vaxxed, ';

  -- Generate the dynamic column expressions for deaths per month
  FOR i IN 1..24 LOOP
    sql_query := sql_query || 'SUM(CASE WHEN DOD BETWEEN ADD_MONTHS(vax_date, ' || (i - 1) || ') AND ADD_MONTHS(vax_date, ' || i || ')-1 THEN 1 ELSE 0 END) AS month_' || i || ', ';
  END LOOP;

  -- Remove the trailing comma and space
  sql_query := RTRIM(sql_query, ', ');

  -- Complete the SQL query
  sql_query := sql_query || ' FROM joined_table
                             WHERE dose_number BETWEEN 1 AND 5
                             GROUP BY TO_CHAR(vax_date, ''YYYY-MM''), dose_number, 
                                      TRUNC((EXTRACT(YEAR FROM vax_date) - EXTRACT(YEAR FROM dob) + 
                                        CASE WHEN EXTRACT(MONTH FROM vax_date) < EXTRACT(MONTH FROM dob) OR 
                                                  (EXTRACT(MONTH FROM vax_date) = EXTRACT(MONTH FROM dob) AND EXTRACT(DAY FROM vax_date) < EXTRACT(DAY FROM dob))
                                        THEN -1 ELSE 0 END) / 5) * 5 + 10
                             ORDER BY vax_month, dose_number';

  -- Execute the dynamic SQL
  EXECUTE IMMEDIATE sql_query;
END;
/

-- the last cutoff day for the NHI database is October 7 2023
-- filter DOD>'6-OCT-2023' will give a few deaths


-- Count number of people who died in 2022 and 2023
select count(*) as num_dead
    from NHI_PROD.NHI_EXTRACT
    where dod- to_date('01-JAN-2023') between 0 and 365;
    
-- more sophisticated version with two columns:
SELECT
    SUM(CASE WHEN dod- to_date('01-JAN-2022') between 0 and 365 THEN 1 ELSE 0 END) AS num_dead_2022,
    SUM(CASE WHEN dod- to_date('01-JAN-2023') between 0 and 365 THEN 1 ELSE 0 END) AS num_dead_2023
FROM NHI_PROD.NHI_EXTRACT;

-- this is for ALL ages so subject to age mix differences between the doses.
-- need to break out by age
DECLARE
  sql_query CLOB;
BEGIN
  -- Initialize the SQL query
  sql_query := 'CREATE TABLE a2 AS
                SELECT
                  TO_CHAR(vax_date, ''YYYY-MM'') AS vax_month,
                  dose_number,
                  COUNT(*) AS num_vaxxed, ';

  -- Generate the dynamic column expressions for deaths per month
  FOR i IN 1..24 LOOP
    sql_query := sql_query || 'SUM(CASE WHEN DOD BETWEEN ADD_MONTHS(vax_date, ' || (i - 1) || ') AND ADD_MONTHS(vax_date, ' || i || ')-1 THEN 1 ELSE 0 END) AS month_' || i || ', ';
  END LOOP;

  -- Remove the trailing comma and space
  sql_query := RTRIM(sql_query, ', ');

  -- Complete the SQL query
  sql_query := sql_query || ' FROM joined_table
                              WHERE dose_number BETWEEN 1 AND 5 -- to limit dose range
                             GROUP BY TO_CHAR(vax_date, ''YYYY-MM''), dose_number
                             ORDER BY vax_month, dose_number';

  -- Execute the dynamic SQL
  EXECUTE IMMEDIATE sql_query;
END;
/


CREATE INDEX idx_joined_table_vax_date ON joined_table(vax_date);
CREATE INDEX idx_joined_table_dob ON joined_table(dob);
CREATE INDEX idx_joined_table_dod ON joined_table(dod);


-- add a new column
ALTER TABLE joined_table
ADD vax_month VARCHAR2(2);  -- Adjust data type if needed
UPDATE joined_table
SET vax_month = TO_CHAR(vax_date, 'MM');

--- this one is close
CREATE TABLE analysis_deaths_per_mo_shot AS
SELECT dose_number,
       vax_month,
       COUNT(*) AS num_vaxxed,
       LEVEL AS month_id,
       SUM(CASE WHEN dod - vax_date BETWEEN (LEVEL - 1) * 30 + 1 AND LEVEL * 30 THEN 1 END) AS deaths_month_id
FROM (
    SELECT dose_number,
           TO_CHAR(vax_date, 'MM') AS vax_month,
           vax_date,
           dod,
           dob
    FROM joined_table
)
WHERE TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 0 AND 100
    AND vax_date >= '2021-05-01'
    AND vax_date < '2022-06-01'
CONNECT BY LEVEL <= 24
GROUP BY dose_number, vax_month, LEVEL;





sELECT table_name FROM USER_TABLES; 

SELECT TRUNC(TO_DATE('27-OCT-2092','DD-MON-YYYY'), 'YEAR') -- works
  "New Year" FROM DUAL;
  
SELECT '3-aug-2023'-'1-aug-2024'  -- this will NOT work (invalid number because it's a string)
  "New Year" FROM DUAL;
  
select to_date('4-aug-2023')-to_date('3-aug-2023')  -- works
    "mycol" from dual;
  
  select to_date('4-aug-2023')-'3-aug-2023'  -- won't work
    "mycol" from dual;
    
select trunc(to_date('4-aug-2023'))-'3-aug-2023'  -- won't
    "mycol" from dual;
  
  
SELECT TRUNC(TO_DATE('27-OCT-2092','DD-MON-YYYY'), 'YEAR')-TRUNC(TO_DATE('27-OCT-2093','DD-MON-YYYY'), 'YEAR')
  "New Year" FROM DUAL;

-- now just look at num deaths each month w/o looking at vax_status to get feel
-- for the slope. Have to look at got shot before Aug 1, 2021 but looking at deaths since aug
CREATE TABLE analysis_deaths_per_mo_shot_b4_aug1 AS
SELECT dose_number,
       num_vaccinated,
       num_dead_1, num_dead_2, num_dead_3, num_dead_4, num_dead_5, num_dead_6, num_dead_7, num_dead_8
       -- ROUND((SELECT num_dead / num_vaccinated * 100 FROM dual), 2) AS percent_died
FROM (
    SELECT dose_number,
           COUNT(*) AS num_vaccinated,
           COUNT(CASE WHEN trunc(dod)-to_date('1-AUG-2021') between 0 and 29 THEN 1 END) AS num_dead_1,
           COUNT(CASE WHEN trunc(dod)-to_date('1-AUG-2021') between 30 and 59 THEN 1 END) AS num_dead_2,
           COUNT(CASE WHEN trunc(dod)-to_date('1-AUG-2021') between 60 and 89 THEN 1 END) AS num_dead_3,
           COUNT(CASE WHEN trunc(dod)-to_date('1-AUG-2021') between 90 and 119 THEN 1 END) AS num_dead_4,
           COUNT(CASE WHEN trunc(dod)-to_date('1-AUG-2021') between 120 and 149 THEN 1 END) AS num_dead_5,
           COUNT(CASE WHEN dod-to_date('1-AUG-2021') between 150 and 179 THEN 1 END) AS num_dead_6,
           COUNT(CASE WHEN dod-to_date('1-AUG-2021') between 180 and 209 THEN 1 END) AS num_dead_7,
           COUNT(CASE WHEN dod-to_date('1-AUG-2021') between 210 and 239 THEN 1 END) AS num_dead_8
    FROM joined_table
    WHERE TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 0 AND 100
        and trunc(vax_date,'MONTH') < to_date('1-AUG-2021')  -- got shot before aug 1
    GROUP BY dose_number
    HAVING dose_number BETWEEN 1 AND 4  -- Limit doses to 1 through 4
    );

-- look at deaths each month after dose 1 vaccine given in JUL 2021
-- this is stable which is a red flag
CREATE TABLE analysis_all_ages_JUL_by_30_day_intervals AS
SELECT dose_number,
       num_vaccinated,
       num_dead_1, num_dead_2, num_dead_3, num_dead_4, num_dead_5, num_dead_6, num_dead_7, num_dead_8
       -- ROUND((SELECT num_dead / num_vaccinated * 100 FROM dual), 2) AS percent_died
FROM (
    SELECT dose_number,
           COUNT(*) AS num_vaccinated,
           COUNT(CASE WHEN dod-vax_date between 0 and 29 THEN 1 END) AS num_dead_1,
           COUNT(CASE WHEN dod-vax_date between 30 and 59 THEN 1 END) AS num_dead_2,
           COUNT(CASE WHEN dod-vax_date between 60 and 89 THEN 1 END) AS num_dead_3,
           COUNT(CASE WHEN dod-vax_date between 90 and 119 THEN 1 END) AS num_dead_4,
           COUNT(CASE WHEN dod-vax_date between 120 and 149 THEN 1 END) AS num_dead_5,
           COUNT(CASE WHEN dod-vax_date between 150 and 179 THEN 1 END) AS num_dead_6,
           COUNT(CASE WHEN dod-vax_date between 180 and 209 THEN 1 END) AS num_dead_7,
           COUNT(CASE WHEN dod-vax_date between 210 and 239 THEN 1 END) AS num_dead_8
    FROM joined_table
    WHERE TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 0 AND 100
        and trunc(vax_date,'MONTH') BETWEEN to_date('1-JUL-2021') and to_date('1-JUL-2021')  -- got shot in this month
    GROUP BY dose_number
    HAVING dose_number BETWEEN 1 AND 4  -- Limit doses to 1 through 4
    );

-- look at deaths each month after dose 1 vaccine given in Aug to SEP 2021
-- this is stable which is a red flag
CREATE TABLE analysis_all_ages_aug_sep_by_30_day_intervals AS
SELECT dose_number,
       num_vaccinated,
       num_dead_1, num_dead_2, num_dead_3, num_dead_4, num_dead_5
       -- ROUND((SELECT num_dead / num_vaccinated * 100 FROM dual), 2) AS percent_died
FROM (
    SELECT dose_number,
           COUNT(*) AS num_vaccinated,
           COUNT(CASE WHEN dod-vax_date between 0 and 29 THEN 1 END) AS num_dead_1,
           COUNT(CASE WHEN dod-vax_date between 30 and 59 THEN 1 END) AS num_dead_2,
           COUNT(CASE WHEN dod-vax_date between 60 and 89 THEN 1 END) AS num_dead_3,
           COUNT(CASE WHEN dod-vax_date between 90 and 119 THEN 1 END) AS num_dead_4,
    FROM joined_table
    WHERE TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 0 AND 100
        and trunc(vax_date,'MONTH') BETWEEN to_date('1-AUG-2021') and to_date('1-SEP-2021')  -- got shot in this month
    GROUP BY dose_number
    HAVING dose_number BETWEEN 1 AND 4  -- Limit doses to 1 through 4
    );

-- all_65_69 table has 34256 rows so these people vaxxed before 5-oct so have
-- 365 days to die.
CREATE TABLE all_65_69 AS 
SELECT * FROM joined_table 
WHERE dose_number=1 and 
    TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 65 AND 69 AND
    trunc(vax_date)<'5-oct-2022';  -- so has 365 days to die

-- 458 pepole died within 1 year of their vaccine (34256 got the shots)
-- note using <= will add 2 more counts
CREATE TABLE all_65_69_dead AS 
SELECT * FROM all_65_69 
WHERE 
    dod is not null and trunc(dod-vax_date)<365;  


-- copy a table from one connection to another
CREATE TABLE NHI_PROD.foo
AS
SELECT * FROM steve.all_65_69;

-- FINAL VERSION
-- my version with more exact dates and limits to trunc(vax_date)<'4-oct-2022'
-- copilot code works to create % died over different ages and doses PERCENT DIED
-- this version modified to use MONTHS BETWEEN  (MB)
-- this matches the REFERENCE which uses months between
CREATE TABLE percent_died_stk_MB AS
SELECT dose_number,
       TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) AS age,
       COUNT(*) AS num_vaccinated,
       SUM(CASE WHEN DOD IS NOT NULL AND DOD <= vax_date + NUMTODSINTERVAL(365, 'DAY') THEN 1 ELSE 0 END) AS num_died_within_365_days_of_vax_date,
       ROUND((SUM(CASE WHEN DOD IS NOT NULL AND DOD <= vax_date + NUMTODSINTERVAL(365, 'DAY') THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS percent_died_within_365_days_of_vax_date
FROM joined_table
WHERE dose_number BETWEEN 1 AND 4
  AND TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 20 AND 100
  AND trunc(vax_date)<'5-oct-2022' -- so that person has time to die before database runs out on oct 7, 2023
GROUP BY dose_number, TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12);

-- died within 730 days but compute as annualized rate
CREATE TABLE analysis_65_69_730_day AS
SELECT dose_number,
       num_vaccinated,
       num_dead,
       ROUND((SELECT num_dead / num_vaccinated /2 * 100 FROM dual), 2) AS percent_died
FROM (
    SELECT dose_number,
           COUNT(*) AS num_vaccinated,
           COUNT(CASE WHEN dod <= vax_date + 730 THEN 1 END) AS num_dead
    FROM joined_table
    WHERE TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 65 AND 69
        AND trunc(vax_date)<'5-oct-2021' -- so that person has 2 yrs to die before database runs out on oct 7, 2023
    GROUP BY dose_number
    HAVING dose_number BETWEEN 1 AND 4  -- Limit doses to 1 through 4
    );


-- died within 365 days, dose 1 to 5, two digits percentage
-- THIS CODE WORKS and I think it is accurate. REFERENCE.
--- this just does it for a range of ages and creates a small table
CREATE TABLE analysis_65_69_365_day AS
SELECT dose_number,
       num_vaccinated,
       num_dead,
       ROUND((SELECT num_dead / num_vaccinated * 100 FROM dual), 2) AS percent_died
FROM (
    SELECT dose_number,
           COUNT(*) AS num_vaccinated,
           COUNT(CASE WHEN dod <= vax_date + 365 THEN 1 END) AS num_dead
    FROM joined_table
    WHERE TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 65 AND 69
        AND trunc(vax_date)<'5-oct-2022' -- so that person has time to die before database runs out on oct 7, 2023
    GROUP BY dose_number
    HAVING dose_number BETWEEN 1 AND 4  -- Limit doses to 1 through 4
    );

--- do the analysis for % who died sometime in 2023. modify so everyone in 2023 is the same age.
--- so the only difference here is how many doses they got
CREATE TABLE analysis_65_85_died_in_2023 AS
SELECT dose_number,
       num_vaccinated,
       num_dead,
       ROUND((SELECT num_dead / num_vaccinated * 100 FROM dual), 2) AS percent_died
FROM (
    SELECT dose_number,
           COUNT(*) AS num_vaccinated,
           COUNT(CASE WHEN trunc(dod)>'1-jan-2023'  THEN 1 END) AS num_dead
    FROM joined_table
    WHERE TRUNC(MONTHS_BETWEEN(sysdate, dob) / 12) BETWEEN 65 AND 85 -- everyone born at same time so same age range
        AND trunc(vax_date)<'1-jan-2023' -- so that person has time to die before database runs out on oct 7, 2023
    GROUP BY dose_number
    HAVING dose_number BETWEEN 1 AND 4  -- Limit doses to 1 through 4
    );




-- do the analysis on obfuscated table to make sure we get same answer
CREATE TABLE analysis_65_69_365_day_obfuscated AS
SELECT dose_number,
       num_vaccinated,
       num_dead,
       ROUND((SELECT num_dead / num_vaccinated * 100 FROM dual), 2) AS percent_died
FROM (
    SELECT dose_number,
           COUNT(*) AS num_vaccinated,
           COUNT(CASE WHEN dod <= vax_date + 365 THEN 1 END) AS num_dead
    FROM obfuscated
    WHERE TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 65 AND 69
        AND trunc(vax_date)<'5-oct-2022' -- so that person has time to die before database runs out on oct 7, 2023
    GROUP BY dose_number
    HAVING dose_number BETWEEN 1 AND 4  -- Limit doses to 1 through 4
    );


create table test1 (mycol number); -- creates a table with one column which has a number
insert into test1 values(1234);
select * from test1;

SELECT 'DROP TABLE "' || TABLE_NAME || '" cascade constraints PURGE;'
FROM USER_TABLES
WHERE TABLE_NAME LIKE 'EXP_%';

SELECT * FROM DBA_TS_QUOTAS WHERE TABLESPACE_NAME = 'NHI_PRD_DATA' AND USERNAME = 'steve';
DROP TABLESPACE NHI_PRD_INDEX INCLUDING CONTENTS AND DATAFILES;

DROP TABLESPACE NHI_PRD_DATA INCLUDING CONTENTS AND DATAFILES;

create tablespace NHI_PRD_INDEX datafile 'c:\tmp\ORACLE_DIR\PRD_INDEX' size 100M autoextend on;
create tablespace NHI_PRD_DATA datafile 'c:\tmp\ORACLE_DIR\PRD_DATA' size 100M autoextend on;

CREATE TABLE joined_table AS SELECT t1.NHI, t1.vaccinator_name, t1.sending_site,  t1.family_name, t1.opt_given_name,  t1.batch_id, t1.dose_number, 
 t1.END_DATE_TIME_OF_SERVICE AS vax_date, t2.dod, t1.vaccine_name, t2.dob 
 FROM "CVID_PROD"."PERMANENT_CVID"  t1 INNER JOIN "NHI_PROD"."NHI_EXTRACT" t2 ON t1.NHI = t2.NHI;
 
 CREATE TABLE vaccinator AS SELECT VACCINATOR_NAME, COUNT(*) AS total_rows, COUNT(CASE WHEN DOD IS NOT NULL THEN 1 END) AS count_dod_not_null FROM JOINED_TABLE GROUP BY VACCINATOR_NAME;
CREATE TABLE vaccinator1 AS SELECT VACCINATOR_NAME, COUNT(*) AS total_rows, COUNT(CASE WHEN DOD IS NOT NULL THEN 1 END) AS dead, ROUND(AVG(MONTHS_BETWEEN(SYSDATE, TRUNC(DOB)) / 12), 2) AS avg_age FROM JOINED_TABLE GROUP BY VACCINATOR_NAME;
CREATE TABLE vaccinator2 AS SELECT VACCINATOR_NAME, COUNT(*) AS total_rows, COUNT(CASE WHEN DOD IS NOT NULL THEN 1 END) AS dead, ROUND(AVG(MONTHS_BETWEEN(SYSDATE, TRUNC(DOB)) / 12), 2) AS avg_age, ROUND(AVG(DOD - VAX_DATE), 1) AS avg_time_till_death FROM JOINED_TABLE GROUP BY VACCINATOR_NAME;
CREATE TABLE sending_site AS SELECT SENDING_SITE, COUNT(*) AS total_rows, COUNT(CASE WHEN DOD IS NOT NULL THEN 1 END) AS dead, ROUND(AVG(MONTHS_BETWEEN(SYSDATE, TRUNC(DOB)) / 12), 2) AS avg_age, ROUND(AVG(DOD - VAX_DATE), 1) AS avg_time_till_death FROM JOINED_TABLE GROUP BY SENDING_SITE;

-- number dead within x days of vax date
CREATE table analysis_70_to_100_180_days AS
SELECT dose_number,
       COUNT(*) AS num_vaccinated,
       COUNT(CASE WHEN dod <= vax_date + 180 THEN 1 END) AS num_dead -- within x days
       -- num_dead/num_vaccinated*100 as percent_died       
FROM joined_table
WHERE TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 70 AND 100  -- age
GROUP BY dose_number;


    


-- copilot code works to create % died over different ages and doses PERCENT DIED
-- but the date range is a bit crude of a calculation since it is year minus year
CREATE TABLE percent_died AS
SELECT dose_number,
       EXTRACT(YEAR FROM vax_date) - EXTRACT(YEAR FROM DOB) AS age,
       COUNT(*) AS num_vaccinated,
       SUM(CASE WHEN DOD IS NOT NULL AND DOD <= vax_date + NUMTODSINTERVAL(365, 'DAY') THEN 1 ELSE 0 END) AS num_died_within_365_days_of_vax_date,
       ROUND((SUM(CASE WHEN DOD IS NOT NULL AND DOD <= vax_date + NUMTODSINTERVAL(365, 'DAY') THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS percent_died_within_365_days_of_vax_date
FROM joined_table
WHERE dose_number BETWEEN 1 AND 5
  AND EXTRACT(YEAR FROM vax_date) - EXTRACT(YEAR FROM DOB) BETWEEN 20 AND 100
GROUP BY dose_number, EXTRACT(YEAR FROM vax_date) - EXTRACT(YEAR FROM DOB);

-- my version with more exact dates
-- copilot code works to create % died over different ages and doses PERCENT DIED
-- this version modified to use MONTHS BETWEEN  (MB)
-- this matches the REFERENCE which uses months between
CREATE TABLE percent_died_stk_MB AS
SELECT dose_number,
       TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) AS age,
       COUNT(*) AS num_vaccinated,
       SUM(CASE WHEN DOD IS NOT NULL AND DOD <= vax_date + NUMTODSINTERVAL(365, 'DAY') THEN 1 ELSE 0 END) AS num_died_within_365_days_of_vax_date,
       ROUND((SUM(CASE WHEN DOD IS NOT NULL AND DOD <= vax_date + NUMTODSINTERVAL(365, 'DAY') THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS percent_died_within_365_days_of_vax_date
FROM joined_table
WHERE dose_number BETWEEN 1 AND 5
  AND TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 20 AND 100
GROUP BY dose_number, TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12);

-- this is an alternate method I coded myself and it gives difference results than the MONTH method because it ROUNDS to the NEAREST age, etc. rather than TRUNC!!
CREATE TABLE percent_died_stk2 AS
SELECT dose_number,
       ROUND((vax_date - DOB)/365.25) AS age,
       COUNT(*) AS num_vaccinated,
       SUM(CASE WHEN DOD IS NOT NULL AND DOD <= vax_date + NUMTODSINTERVAL(365, 'DAY') THEN 1 ELSE 0 END) AS num_died_within_365_days_of_vax_date,
       ROUND((SUM(CASE WHEN DOD IS NOT NULL AND DOD <= vax_date + NUMTODSINTERVAL(365, 'DAY') THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS percent_died_within_365_days_of_vax_date
FROM joined_table
WHERE dose_number BETWEEN 1 AND 5
  AND ROUND((vax_date - DOB)/365.25) BETWEEN 20 AND 100
GROUP BY dose_number, ROUND((vax_date - DOB)/365.25);

-- this uses trunc and should match the reference closely. It does!!
CREATE TABLE percent_died_stk_trunc AS
SELECT dose_number,
       TRUNC((vax_date - DOB)/365.25) AS age,
       COUNT(*) AS num_vaccinated,
       SUM(CASE WHEN DOD IS NOT NULL AND DOD <= vax_date + NUMTODSINTERVAL(365, 'DAY') THEN 1 ELSE 0 END) AS num_died_within_365_days_of_vax_date,
       ROUND((SUM(CASE WHEN DOD IS NOT NULL AND DOD <= vax_date + NUMTODSINTERVAL(365, 'DAY') THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS percent_died_within_365_days_of_vax_date
FROM joined_table
WHERE dose_number BETWEEN 1 AND 5
  AND TRUNC((vax_date - DOB)/365.25) BETWEEN 20 AND 100
GROUP BY dose_number, TRUNC((vax_date - DOB)/365.25);


-- new chatgpt code gives error
CREATE TABLE percent_died_by_age AS
SELECT
  dose_number,
  age,
  COUNT(*) AS num_vaccinated,
  SUM(CASE WHEN num_died_within_365_days > 0 THEN 1 ELSE 0 END) AS num_died_within_365_days,
  ROUND((SUM(CASE WHEN num_died_within_365_days > 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS percent_died_within_365_days
FROM (
  SELECT
    jt.dose_number,
    jt.DOB,
    jt.DOD,
    EXTRACT(YEAR FROM jt.vax_date) - EXTRACT(YEAR FROM jt.DOB) AS age,
    COUNT(CASE WHEN jt.DOD BETWEEN jt.vax_date AND jt.vax_date + 365 THEN 1 END) AS num_died_within_365_days
  FROM
    joined_table jt
  WHERE
    jt.dose_number BETWEEN 1 AND 5
    AND EXTRACT(YEAR FROM jt.DOB) BETWEEN 60 AND 100
  GROUP BY
    jt.dose_number,
    jt.DOB,
    jt.DOD,
    EXTRACT(YEAR FROM jt.vax_date)
)
GROUP BY
  dose_number,
  age
ORDER BY
  dose_number, age;




CREATE VIEW dob_view AS SELECT DOB FROM joined_table;

CREATE VIEW NHI AS
SELECT ne.*, jt.max_dose_number AS dose_number
FROM NHI_PROD.NHI_EXTRACT ne
LEFT OUTER JOIN (
  SELECT NHI, MAX(DOSE_NUMBER) AS max_dose_number
  FROM JOINED_TABLE
  GROUP BY NHI
) jt ON ne.NHI = jt.NHI
WHERE EXTRACT(YEAR FROM ne.DOB) >= 1914;

CREATE TABLE yearly_counts AS
SELECT year,
       SUM(CASE WHEN DOSE_NUMBER IS NULL AND EXTRACT(YEAR FROM SYSDATE) >= EXTRACT(YEAR FROM DOB) THEN 1 END) AS num_alive_unvaxxed,
       SUM(CASE WHEN DOSE_NUMBER IS NULL AND EXTRACT(YEAR FROM DOD) = year THEN 1 END) AS num_died_unvaxxed,
       SUM(CASE WHEN DOSE_NUMBER IS NOT NULL AND EXTRACT(YEAR FROM SYSDATE) >= EXTRACT(YEAR FROM DOB) THEN 1 END) AS num_alive_vaxxed,
       SUM(CASE WHEN DOSE_NUMBER IS NOT NULL AND EXTRACT(YEAR FROM DOD) = year THEN 1 END) AS num_died_vaxxed
FROM (
  SELECT NHI, DOB, DOD, DOSE_NUMBER,
         TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) AS year
  FROM NHI
) AS data
GROUP BY year;


CREATE TABLE yearly_counts AS
SELECT year    
FROM (
  SELECT NHI, DOB, DOD, DOSE_NUMBER,
         TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) AS year
  FROM NHI
) AS data
GROUP BY year;


CREATE TABLE yearly_counts AS
SELECT year    
FROM (
  SELECT NHI, DOB, DOD, DOSE_NUMBER,
         TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) AS year
  FROM NHI
) AS data
GROUP BY year;

SELECT count(*)
FROM NHI_PROD.NHI_EXTRACT
where
extract (year from DOB) >= 1914
and dod is null;

CREATE TABLE death_counts_by_age AS
SELECT year,
       SUM(CASE WHEN EXTRACT(YEAR FROM DOD) = year AND 
                  TRUNC(MONTHS_BETWEEN(DOD, DOB) / 12) >= 60 AND 
                  TRUNC(MONTHS_BETWEEN(DOD, DOB) / 12) <= 100 THEN 1 END) AS count_deaths
FROM (
  SELECT NHI, DOB, DOD,
         TO_NUMBER(TO_CHAR(DOD, 'YYYY')) AS year
  FROM NHI
) AS data
GROUP BY year, TRUNC(MONTHS_BETWEEN(DOD, DOB) / 12) - 59;


CREATE TABLE deaths_yr AS
SELECT * FROM (
  SELECT 
    EXTRACT(YEAR FROM DOD) as Year, 
    EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) as Age_At_Death
  FROM NHI
  WHERE 
    EXTRACT(YEAR FROM DOD) BETWEEN 2010 AND 2023 AND 
    EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) BETWEEN 15 AND 130
)
PIVOT (
  COUNT(Age_At_Death)
  FOR Age_At_Death IN (15, 16, 17, 20, 21, 22, 30, 31, 32, 40, 41, 42, 50, 51, 52, 60, 61, 62, 80, 81,82, 90,91, 92, 100)
);

SELECT count(*)
FROM NHI
where
extract (year from DOB) between 1964 and 2024
and dod is not null;



CREATE TABLE deaths_yr AS
SELECT * FROM (
  SELECT 
    EXTRACT(YEAR FROM DOD) as Year, 
    EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) as Age_At_Death
  FROM NHI_PROD.NHI_EXTRACT
  WHERE 
    EXTRACT(YEAR FROM DOD) BETWEEN 2010 AND 2023 AND 
    EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) BETWEEN 15 AND 130
)
PIVOT (
  COUNT(Age_At_Death)
  FOR Age_At_Death IN (60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100)
);


-- deaths per year (ages are columns)
CREATE TABLE deaths_all_ages AS
SELECT * FROM (
  SELECT 
    EXTRACT(YEAR FROM DOD) as Year, 
    EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) as Age_At_Death
  FROM NHI_PROD.NHI_EXTRACT
  WHERE 
    EXTRACT(YEAR FROM DOD) BETWEEN 2010 AND 2023 AND 
    EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) BETWEEN 0 AND 130
)
PIVOT (
  COUNT(Age_At_Death)
  FOR Age_At_Death IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130)
);



-- see if there are deaths in young kids
SELECT count(*)
FROM NHI
where
extract (year from DOB) between 2020 and 2024
and dod is not null;

SELECT MAX(DOD) AS LargestDateOfDeath FROM NHI;

SELECT
  EXTRACT(MONTH FROM DOD) AS Month,
  COUNT(*) AS NumberOfDeaths
FROM
  NHI
WHERE
  EXTRACT(YEAR FROM DOD) = 2023
  AND EXTRACT(MONTH FROM DOD) IN (9, 10, 11)
GROUP BY
  EXTRACT(MONTH FROM DOD)
ORDER BY
  Month;
  
  # deaths run till Oct 6, 2023 (last full day of deaths)
  SELECT
  EXTRACT(DAY FROM DOD) AS Day,
  COUNT(*) AS NumberOfDeaths
FROM
  NHI
WHERE
  EXTRACT(YEAR FROM DOD) = 2023
  AND EXTRACT(MONTH FROM DOD) = 10
GROUP BY
  EXTRACT(DAY FROM DOD)
ORDER BY
  Day;
  
CREATE TABLE vax_stats AS
SELECT
  date_trunc('day', v.vax_date) AS date,
  SUM(CASE WHEN d.Dose_number IS NULL AND v.vax_date = MIN(v.vax_date OVER (PARTITION BY v.NHI)) THEN 1 END) AS first_vaxxed,
  SUM(CASE WHEN d.Dose_number IS NOT NULL THEN 1 END) AS doses_given,
  SUM(CASE WHEN d.Dose_number = 1 THEN 1 END) AS dose_1,
  SUM(CASE WHEN d.Dose_number = 2 THEN 1 END) AS dose_2,
  COUNT(DISTINCT v.NHI) AS unique_deaths
FROM (
  SELECT NHI, vax_date AS date, Dose_number
  FROM joined_table
  WHERE vax_date >= DATE '2021-05-01' AND vax_date < DATE '2021-05-31'
) AS d
INNER JOIN (
  SELECT NHI, MIN(vax_date) AS vax_date
  FROM joined_table
  WHERE vax_date >= DATE '2021-05-01' AND vax_date < DATE '2021-05-31'
  GROUP BY NHI
) AS v
ON d.NHI = v.NHI AND d.date = v.vax_date
LEFT JOIN joined_table
ON d.NHI = joined_table.NHI AND d.date = joined_table.DOD
GROUP BY date_trunc('day', v.vax_date)
ORDER BY date;


-- wow. this worked after date_trunc changed to trunc in two places
CREATE TABLE vax_stats AS
SELECT
    DATE'2021-05-01' + LEVEL - 1 AS ReportingDate,
    COUNT(DISTINCT CASE WHEN vax_date = DATE'2021-05-01' + LEVEL - 1 AND Dose_number = 1 THEN NHI END) AS FirstVaccineToday,
    COUNT(CASE WHEN vax_date = DATE'2021-05-01' + LEVEL - 1 THEN NHI END) AS TotalDosesGivenToday,
    COUNT(CASE WHEN vax_date = DATE'2021-05-01' + LEVEL - 1 AND Dose_number = 1 THEN NHI END) AS Dose1GivenToday,
    COUNT(CASE WHEN vax_date = DATE'2021-05-01' + LEVEL - 1 AND Dose_number = 2 THEN NHI END) AS Dose2GivenToday,
    COUNT(DISTINCT CASE WHEN DOD = DATE'2021-05-01' + LEVEL - 1 THEN NHI END) AS UniquePeopleDiedToday
FROM
    joined_table
CONNECT BY
    DATE'2021-05-01' + LEVEL - 1 <= DATE'2021-05-30'
GROUP BY
    DATE'2021-05-01' + LEVEL - 1
ORDER BY
    ReportingDate;

CREATE TABLE vax_stats AS
SELECT
  trunc(v.vax_date) AS date,
  SUM(CASE WHEN d.Dose_number IS NULL AND v.vax_date = MIN(v.vax_date OVER (PARTITION BY v.NHI)) THEN 1 END) AS first_vaxxed,
  SUM(CASE WHEN d.Dose_number IS NOT NULL THEN 1 END) AS doses_given,
  SUM(CASE WHEN d.Dose_number = 1 THEN 1 END) AS dose_1,
  SUM(CASE WHEN d.Dose_number = 2 THEN 1 END) AS dose_2,
  COUNT(DISTINCT v.NHI) AS unique_deaths
FROM (
  SELECT NHI, vax_date AS date, Dose_number
  FROM joined_table 
  WHERE vax_date >= DATE '2021-05-01' AND vax_date < DATE '2021-05-31'
) AS d
INNER JOIN (
  SELECT NHI, MIN(vax_date) AS vax_date
  FROM joined_table
  WHERE vax_date >= DATE '2021-05-01' AND vax_date < DATE '2021-05-31'
  GROUP BY NHI
) AS v
ON d.NHI = v.NHI AND d.date = v.vax_date
LEFT JOIN joined_table
ON d.NHI = joined_table.NHI AND d.date = joined_table.DOD
GROUP BY trunc(v.vax_date)
ORDER BY date;

CREATE TABLE vax_stats AS
SELECT
  date_trunc('day', v.vax_date) AS date,
  SUM(CASE WHEN d.Dose_number IS NULL AND v.vax_date = MIN(v.vax_date) OVER (PARTITION BY v.NHI) THEN 1 END) AS first_vaxxed,
  SUM(CASE WHEN d.Dose_number IS NOT NULL THEN 1 END) AS doses_given,
  SUM(CASE WHEN d.Dose_number = 1 THEN 1 END) AS dose_1,
  SUM(CASE WHEN d.Dose_number = 2 THEN 1 END) AS dose_2,
  COUNT(DISTINCT v.NHI) AS unique_deaths
FROM (
  SELECT NHI, vax_date AS date, Dose_number
  FROM joined_table
  WHERE vax_date >= DATE '2021-05-01' AND vax_date < DATE '2021-05-31'
) AS d
INNER JOIN (
  SELECT NHI, MIN(vax_date) AS vax_date
  FROM joined_table
  WHERE vax_date >= DATE '2021-05-01' AND vax_date < DATE '2021-05-31'
  GROUP BY NHI
) AS v
ON d.NHI = v.NHI AND d.date = v.vax_date
LEFT JOIN joined_table
ON d.NHI = joined_table.NHI AND d.date = joined_table.DOD
GROUP BY date_trunc('day', v.vax_date)
ORDER BY date;

The error in your Oracle SQL query is likely due to the use of the `LEFT JOIN` clause without specifying an alias for the `joined_table`. In your query, you've used `joined_table` in two subqueries and again in the `LEFT JOIN` clause without an alias, 
which could be causing confusion for the SQL parser about which instance of `joined_table` to refer to.

Here's a corrected version of your query where I've added an alias `jt` for the `joined_table` in the `LEFT JOIN` clause:


CREATE TABLE vax_stats AS
SELECT
  TRUNC(v.vax_date) AS date,
  SUM(CASE WHEN d.Dose_number IS NULL AND v.vax_date = MIN(v.vax_date) OVER (PARTITION BY v.NHI) THEN 1 END) AS first_vaxxed,
  SUM(CASE WHEN d.Dose_number IS NOT NULL THEN 1 END) AS doses_given,
  SUM(CASE WHEN d.Dose_number = 1 THEN 1 END) AS dose_1,
  SUM(CASE WHEN d.Dose_number = 2 THEN 1 END) AS dose_2,
  COUNT(DISTINCT v.NHI) AS unique_deaths
FROM (
  SELECT NHI, vax_date AS date, Dose_number
  FROM joined_table
  WHERE vax_date >= DATE '2021-05-01' AND vax_date < DATE '2021-05-31'
) d
INNER JOIN (
  SELECT NHI, MIN(vax_date) AS vax_date
  FROM joined_table
  WHERE vax_date >= DATE '2021-05-01' AND vax_date < DATE '2021-05-31'
  GROUP BY NHI
) v
ON d.NHI = v.NHI AND d.date = v.vax_date
LEFT JOIN joined_table jt
ON d.NHI = jt.NHI AND d.date = jt.DOD
GROUP BY TRUNC(v.vax_date)
ORDER BY date;

SELECT TRUNC(TO_DATE('17-OCT-2093','DD-MON-YYYY'),'day')
  "mydate" FROM DUAL;
  
select * from DUAL;
 
 -- not properly terminated
 CREATE TABLE deaths_all_ages_monthly AS
SELECT
  TO_CHAR(
    ADD_MONTHS(TRUNC('YEAR', MIN(DOD)), n - 1),
    'YYYY-MM'
  ) AS month,
  SUM(CASE WHEN Age_At_Death = n THEN 1 ELSE 0 END) AS deaths_age_n
FROM (
  SELECT
    DOD,
    EXTRACT(YEAR FROM DOD) AS Year,
    EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) AS Age_At_Death
  FROM NHI_PROD.NHI_EXTRACT
  WHERE
    EXTRACT(YEAR FROM DOD) BETWEEN 2010 AND 2023 AND
    EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) BETWEEN 0 AND 130
) AS deaths_data
UNPIVOT (
  deaths_age_n
  FOR n IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130)
) AS deaths_by_month
ORDER BY month;

-- new try for deaths per month
CREATE TABLE deaths_all_ages AS
SELECT
  TO_CHAR(
    ADD_MONTHS(TRUNC('YEAR', MIN(DOD)), n - 1),
    'YYYY-MM'
  ) AS month,
  COALESCE(SUM(CASE WHEN Age_At_Death = n THEN 1 ELSE 0 END), 0) AS deaths_age_n
FROM (
  SELECT
    DOD,
    EXTRACT(YEAR FROM DOD) AS YEAR,
    EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) AS Age_At_Death
  FROM NHI_PROD.NHI_EXTRACT
  WHERE
    EXTRACT(YEAR FROM DOD) BETWEEN 2010 AND 2023 AND
    EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) BETWEEN 0 AND 130
) AS deaths_data
UNPIVOT (
  COALESCE(deaths_age_n, 0) AS deaths_age_n
  FOR n IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130)
) AS deaths_by_month
ORDER BY month;

-- from chatgpt; this worked!
CREATE TABLE deaths_all_ages_by_month AS
SELECT
  EXTRACT(YEAR FROM DOD) AS Year,
  EXTRACT(MONTH FROM DOD) AS Month,
  COUNT(CASE WHEN EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) = 0 THEN 1 END) AS Age_0,
  COUNT(CASE WHEN EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) = 1 THEN 1 END) AS Age_1,
  COUNT(CASE WHEN EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) = 2 THEN 1 END) AS Age_2
  -- Add similar lines for other age groups up to 130
FROM
  NHI_PROD.NHI_EXTRACT
WHERE 
  EXTRACT(YEAR FROM DOD) BETWEEN 2010 AND 2023 AND 
  EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) BETWEEN 0 AND 130
GROUP BY
  EXTRACT(YEAR FROM DOD), EXTRACT(MONTH FROM DOD)
ORDER BY
  Year, Month;

-- now do it an auto generate the field names!
DECLARE
  sql_query CLOB;
  column_names CLOB := '';
  age_limit NUMBER := 120;
BEGIN
  -- Generate column names
  FOR i IN 0..age_limit LOOP
    column_names := column_names || 'COUNT(CASE WHEN EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) = ' || i || ' THEN 1 END) AS Age_' || i || ', ';
  END LOOP;

  -- Remove the trailing comma and space
  column_names := RTRIM(column_names, ', ');

  -- Construct the dynamic SQL
  sql_query := 'CREATE TABLE deaths_all_ages_monthly AS SELECT
                  EXTRACT(YEAR FROM DOD) AS Year,
                  EXTRACT(MONTH FROM DOD) AS Month, ' || column_names || '
                FROM NHI_PROD.NHI_EXTRACT
                WHERE 
                  EXTRACT(YEAR FROM DOD) BETWEEN 2010 AND 2023 AND 
                  EXTRACT(YEAR FROM DOD) - EXTRACT(YEAR FROM DOB) BETWEEN 0 AND ' || age_limit || '
                GROUP BY
                  EXTRACT(YEAR FROM DOD), EXTRACT(MONTH FROM DOD)
                ORDER BY
                  Year, Month';

  -- Execute the dynamic SQL
  EXECUTE IMMEDIATE sql_query;
END;
/


CREATE OR REPLACE DIRECTORY ORACLE_DIR AS 'c:\tmp\ORACLE_DIR';

create view aug_2021
as Select * from joined_table 
where trunc(vax_date,'MONTH') = '01-AUG-2021';

SELECT * FROM joined_table
WHERE trunc(vax_date,'MONTH') = '01-MAY-2021';

create view sep_2021
as Select * from joined_table 
where trunc(vax_date,'MONTH') = '01-SEP-2021' and dod is not null;

create view oct_2021
as Select * from joined_table 
where trunc(vax_date,'MONTH') = '01-OCT-2021' and dod is not null;

create view jul_2021
as Select * from joined_table 
where trunc(vax_date,'MONTH') = '01-JUL-2021' and dod is not null;


-- basic create table
create table test1(mycol number);
insert into test1 values(1234);
select * from test1;
CREATE INDEX idx_test1 ON test1(mycol);

