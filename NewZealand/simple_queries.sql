-- simple select for deaths in 2022
 count(*)
    from JOINED_TABLE;
    -- where trunc(dod, 'YEAR')='01-JAN-2022';

-- Count number of people who died in 2022 and 2023
select count(*) as num_dead
    from NHI_PROD.NHI_EXTRACT
    where dod- to_date('01-JAN-2023') between 0 and 365;

-- count of deaths in multiple years
 select
    COUNT(CASE WHEN trunc(dod, 'YEAR')='01-JAN-2020' THEN 1 END) AS Yr_2020,
    COUNT(CASE WHEN trunc(dod, 'YEAR')='01-JAN-2021' THEN 1 END) AS Yr_2021,
    COUNT(CASE WHEN trunc(dod, 'YEAR')='01-JAN-2022' THEN 1 END) AS Yr_2022
  from nhi_extract;

-- simple select for for deaths since dose for specific case
CREATE TABLE B6 AS
SELECT
    TO_CHAR(vax_date, 'YYYY-MM') AS vax_month,
    dose_number,
    COUNT(*) AS num_vaxxed,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 0 AND 365 THEN 1 ELSE 0 END) AS month_1,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 30 AND 59 THEN 1 ELSE 0 END) AS month_2,
    SUM(CASE WHEN (DOD - vax_date) BETWEEN 60 AND 89 THEN 1 ELSE 0 END) AS month_3
FROM 
    joined_table
WHERE 
    dose_number BETWEEN 1 AND 4
    AND (vax_date-dob)/365.25 BETWEEN 65 AND 69
GROUP BY 
    TO_CHAR(vax_date, 'YYYY-MM'), dose_number
ORDER BY 
    vax_month, dose_number;

SELECT TRUNC(TO_DATE('17-OCT-2093','DD-MON-YYYY'),'day')
  "mydate" FROM DUAL;
  
select * from DUAL;

CREATE TABLE numbers (
  value INT
);
INSERT INTO numbers (value)  VALUES  (1);

CREATE TABLE people (
  name VARCHAR(255)
);
INSERT INTO people (name) VALUES ('steve');


CREATE TABLE product(
   product_id       number(7) NOT NULL,
   supplier_id      INT,
   product_name     VARCHAR(30),
   product_price    DOUBLE PRECISION,
   product_category VARCHAR(30),
   product_brand    VARCHAR(20),
   product_expire   DATE,
   PRIMARY KEY (product_id));
INSERT INTO product (product_id, supplier_id) VALUES (1, 2);
select * from product;
select product_id,supplier_id from product;
