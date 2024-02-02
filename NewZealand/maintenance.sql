-- commands to change things around as a user

-- remove columns from a table
alter table "CVID_PROD"."PERMANENT_CVID" drop (HPI_ORG_ID, AGE)

-- for windows
CREATE OR REPLACE DIRECTORY ORACLE_DIR AS 'c:\tmp\ORACLE_DIR';
CREATE OR REPLACE DIRECTORY ORACLE_DIR AS 'c:\tmp\ORACLE_DIR';

-- need CREATE ANY DIRECTORY privilege
-- this is set up for docker since &ORACLE_BASE/oradata is mapped externally
--- and available at /root/apps/oracle/data 
-- should be able to use &ORACLE_BASE, but it isn't define, so can define it
-- This will FAIL if ORACLE_DIR is already defined
CREATE DIRECTORY ORACLE_DIR AS '/opt/oracle/oradata/ORACLE_DIR';
CREATE OR REPLACE DIRECTORY ORACLE_DIR AS '/opt/oracle/oradata/ORACLE_DIR';
GRANT READ,WRITE ON DIRECTORY ORACLE_DIR TO STEVE;

-- NOTE
-- when using data dump, BE SURE TO use ORACLE_DIR for the log file and the output file. If you use the DATA_DUMP directory, it isn't writeable
-- and you'll get an error if you try to use the datadump feature

-- confirm it worked by looking at all the defined directory names
SELECT * FROM dba_directories;