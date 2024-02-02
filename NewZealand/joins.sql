-- inner join of covid and NHI. Order doesn't matter.
CREATE TABLE joined_table AS SELECT t1.NHI, t1.vaccinator_name, t1.sending_site,  t1.family_name, t1.opt_given_name,  t1.batch_id, t1.dose_number, 
 t1.END_DATE_TIME_OF_SERVICE AS vax_date, t2.dod, t1.vaccine_name, t2.dob 
 FROM "CVID_PROD"."PERMANENT_CVID"  t1 INNER JOIN "NHI_PROD"."NHI_EXTRACT" t2 ON t1.NHI = t2.NHI;