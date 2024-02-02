-- see mortality tables file for the analysis of deaths since dose given

    
-- Look at how many people died from the NHI database
SELECT
    SUM(CASE WHEN dod- to_date('01-JAN-2022') between 0 and 365 THEN 1 ELSE 0 END) AS num_dead_2022,
    SUM(CASE WHEN dod- to_date('01-JAN-2023') between 0 and 365 THEN 1 ELSE 0 END) AS num_dead_2023
FROM NHI_PROD.NHI_EXTRACT;




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


-- chatgpt code gives error
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




 