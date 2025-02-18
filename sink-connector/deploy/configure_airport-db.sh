DATABASE=airportdb

./debezium-delete.sh $DATABASE &&  ./debezium-connector-setup-database.sh $DATABASE &&
docker exec -it clickhouse clickhouse-client -uroot --password root -mn --query "drop database if exists $DATABASE;create database $DATABASE;"
docker exec -it mysql-master mysql -uroot -proot -e ""
sleep 5
./sink-delete.sh $DATABASE && ./sink-connector-setup-database.sh $DATABASE