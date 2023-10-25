CREATE DATABASE IF NOT EXISTS katzkin;
CREATE DATABASE IF NOT EXISTS compras;
-- Create the 'sewing' user with password 'Reliable1'
CREATE USER 'sewing'@'%' IDENTIFIED BY 'Reliable1';
-- Grant privileges to 'sewing' on a specific database
GRANT SELECT ON my_database.* TO 'sewing'@'%';

-- Create the 'master' user with password 'KTZtaco5green#'
CREATE USER 'master'@'%' IDENTIFIED BY 'KTZtaco5green#';
-- Grant all privileges to 'master' on all databases
GRANT ALL PRIVILEGES ON *.* TO 'master'@'%';
