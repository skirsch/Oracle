
-- this is the master mortality table with rows for 5 year age ranges
-- and columns for 24 months from time of jab
-- age is at time of jab
-- month and dose of jab are rows
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


-- this has to be right. for 65 to 69 year olds, num vaxxed and num died in a year
CREATE TABLE b4 AS 
SELECT count(*) as num_vaxxed,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 0 AND 365 THEN 1 ELSE 0 END) AS death_count
    FROM joined_table 
WHERE dose_number=1 and 
    TRUNC(MONTHS_BETWEEN(vax_date, dob) / 12) BETWEEN 65 AND 69 AND
    trunc(vax_date)<'5-oct-2022';  -- so has 365 days to die