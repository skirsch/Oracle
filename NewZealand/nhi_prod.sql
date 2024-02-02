-- the last cutoff day for the NHI database is October 7 2023 
-- that is the date of the last entries.
-- filter DOD>'6-OCT-2023' will give a few deaths

-- total record count
select count(1) from "NHI_PROD"."NHI_EXTRACT";

-- see how many died in a given year
select 
    count(*)
    from nhi_extract 
    where trunc(dod, 'YEAR')='01-JAN-2022';
    
-- more sophisticated
 select
    COUNT(CASE WHEN trunc(dod, 'YEAR')='01-JAN-2020' THEN 1 END) AS Yr_2020,
    COUNT(CASE WHEN trunc(dod, 'YEAR')='01-JAN-2021' THEN 1 END) AS Yr_2021,
    COUNT(CASE WHEN trunc(dod, 'YEAR')='01-JAN-2022' THEN 1 END) AS Yr_2022
  from nhi_extract;