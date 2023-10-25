#!/bin/bash

set -e

# Function to calculate seconds until 18:13 today or the next day
calculate_sleep_seconds() {
  current_time=$(date +%s)
  target_time=$(date -d "04:00" +%s)
  # If current time is past 18:13, calculate time until 18:13 the next day
  [ $current_time -ge $target_time ] && target_time=$(date -d "tomorrow 18:13" +%s)
  echo $(( target_time - current_time ))
}

# Sleep until the next 18:13
sleep_seconds=$(calculate_sleep_seconds)
sleep $sleep_seconds

# Run the backup every 24 hours
while true; do
  for DB in $(mysql -h${MYSQL_HOST} -uroot -p${MYSQL_ROOT_PASSWORD} -e 'SHOW DATABASES;' | egrep -v 'information_schema|performance_schema|mysql|sys' | tail -n +2); do
    TIMESTAMP=$(date +%F-%H-%M-%S)
    mysqldump -h${MYSQL_HOST} -uroot -p${MYSQL_ROOT_PASSWORD} --skip-lock-tables --databases ${DB} > /backups/${DB}_${TIMESTAMP}.sql
  done
  
  # Sleep for 24 hours
  sleep 86400 # 24 hours in seconds
done
