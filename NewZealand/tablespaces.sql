-- create a table and put in a tablespace
CREATE TABLE my_table (mycol number)
TABLESPACE my_tablespace;

-- can do the same for an index

-- move my table into a new tablespace
ALTER TABLE my_table
  MOVE TABLESPACE my_new_tablespace;

-- if change location
ALTER TABLESPACE my_tablespace OFFLINE;
ALTER DATABASE RENAME FILE '<old_datafile_path>' TO '<new_datafile_path>';
ALTER TABLESPACE my_tablespace ONLINE;  -- after move

-- find individual table space names 
SELECT * FROM DBA_TS_QUOTAS WHERE TABLESPACE_NAME = 'NHI_PRD_DATA' AND USERNAME = 'steve';

-- create a tablespace
create tablespace NHI_PRD_INDEX datafile 'c:\tmp\ORACLE_DIR\PRD_INDEX' size 100M autoextend on;
create tablespace NHI_PRD_DATA datafile 'c:\tmp\ORACLE_DIR\PRD_DATA' size 100M autoextend on;

-- delete a tablespace which removes all tables in it
DROP TABLESPACE NHI_PRD_INDEX INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE NHI_PRD_DATA INCLUDING CONTENTS AND DATAFILES;