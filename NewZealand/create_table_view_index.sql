
-- basic create table
create table test1(mycol number);
insert into test1 values(1234);
select * from test1;

CREATE INDEX idx_test1 ON test1(mycol);


create view sep_2021
as Select * from joined_table 
where trunc(vax_date,'MONTH') = '01-SEP-2021' and dod is not null;