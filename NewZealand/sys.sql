
-- look at security protocols like number of failed logins for
-- default profile and STEVE
SELECT resource_name, limit FROM dba_profiles WHERE profile = 'DEFAULT';
SELECT * FROM dba_users WHERE username = 'STEVE'; -- case sensitive!!! can see my profile
-- show all users and their profile
SELECT * FROM dba_users;


create user steve identified by Andy default tablespace users quota unlimited on users;
grant create user to steve;
grant create role to steve;
grant dba to steve;
grant create any directory to steve;
grant create tablespace, create table, create view, create session, drop tablespace to steve;
alter user steve identified by steve; -- change password

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'STEVE';
SELECT TABLE_NAME FROM USER_TABLES; -- show all my tables
grant create schema to steve;   --- fails with missing invalid priviledge

grant create user to steve;
grant create role to steve;
grant dba to steve;
grant create tablespace, create table, create view, create session, drop tablespace;
create user nhi_prod identified by steve default tablespace users quota unlimited on users;
create user cvid_prod identified by steve default tablespace users quota unlimited on users;
create user psmsk_prod identified by steve default tablespace users quota unlimited on users;
create user cbf_prod identified by steve default tablespace users quota unlimited on users;
create tablespace NHI_PRD_INDEX datafile 'c:\tmp\ORACLE_DIR\PRD' size 100M autoextend on;
create tablespace NHI_PRD_DATA datafile 'c:\tmp\ORACLE_DIR\PRD_DATA' size 100M autoextend on;

SELECT * FROM DBA_TS_QUOTAS WHERE TABLESPACE_NAME = 'NHI_PRD_DATA' AND USERNAME = 'steve';
SELECT * FROM DBA_TS_QUOTAS ;

-- do not do this! it will delete the data!!!!
DROP TABLESPACE NHI_PRD_DATA INCLUDING CONTENTS AND DATAFILES;

grant drop tablespace to steve;

ALTER USER NHI_PROD QUOTA UNLIMITED ON NHI_PRD_DATA;
ALTER USER NHI_PROD QUOTA UNLIMITED ON NHI_PRD_INDEX;
grant create session to nhi_prod;
grant create session to cvid_prod;
grant create tablespace, create table, create user, create role to cvid_prod;
GRANT SELECT ON "CVID_PROD"."PERMANENT_CVID" TO steve;
GRANT SELECT ON "NHI_PROD"."NHI_EXTRACT" TO steve;
grant create view to steve;

alter user nhi_prod identified by steve;
alter user sys identified by steve CONTAINER=ALL; -- must be logged in as sysdba to change the sysdba password

-- new user creation (when logged into XEPDB1, not the XE service.
create user steve identified by steve default tablespace users quota unlimited on users;
grant create user to steve;
grant create role to steve;
grant dba to steve;
grant create tablespace, create table, create view, create session, drop tablespace to steve;
-- alter user steve identified by steve;

-- find location of DATA_PUMP_DIR (I think you have to be connected as the right system adm)
SELECT DBMS_METADATA.GET_DB_UNIQUE_NAME() AS dir_path FROM DUAL;


GRANT READ,WRITE ON DIRECTORY ORACLE_DIR TO STEVE;
