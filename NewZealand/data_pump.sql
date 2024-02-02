
-- find out where the data pump directory is mapped to on a system
-- at IZT it is in /opt/oracle/admin/XE/dpdump/... which is INSIDE the container
-- on Windows, it maps to 'C:\app\skirs\product\21c\admin\xe\dpdump/4FA3667FF6F54CF5A2D0382D2EABF769'
SELECT * FROM dba_directories WHERE directory_name = 'DATA_PUMP_DIR';
