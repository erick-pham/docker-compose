CREATE USER 'SuiteCRM'@'%' IDENTIFIED WITH mysql_native_password BY '@SuiteCRM';
GRANT ALL PRIVILEGES ON metabase.* TO 'SuiteCRM'@'%';
GRANT ALL PRIVILEGES ON crm.* TO 'SuiteCRM'@'%';

-- GRANT ALL PRIVILEGES ON *.* TO 'SuiteCRM'@'%';
-- host in connect string can be domain, ip or container name if db and api inside the same VM