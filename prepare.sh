#!/bin/bash 

containername=liquibase_postgres 
dbname=liquibase_test
pgpass=123456
pgport=15433

echo "Clean up previous containers"

docker ps | grep ${containername} && docker kill ${containername} 
docker ps -a | grep ${containername} && docker rm ${containername}

set -e

echo "Run docker container with name ${containername}"
docker run -d --name ${containername} -e POSTGRES_PASSWORD=${pgpass} -p ${pgport}:5432 postgres

echo "Wait maximum 30 seconds for Postgres..."

i=0

until PGPASSWORD=${pgpass} psql -h 127.0.0.1 -p ${pgport} -U postgres -c "SELECT 1;" &> /dev/null ; do
        sleep 1
        echo -n "."
        i=$[$i+1]
        if [ "$i" -ge "30" ];then
                echo -e "\e[1;31mFailed\e[0m"
                echo "Postgresql not started in 10 seconds...Check logs..."
                exit 1
        fi
done

echo -e "\nCreate database\n"
PGPASSWORD=${pgpass} psql -h 127.0.0.1 -p ${pgport} -U postgres -c "CREATE DATABASE ${dbname}";

echo -e "\nDone\n"
