#!/bin/bash

# Загрузка переменных окружения из файла
source /home/student/variables.env

# Запись переменных в файл (опционально)
echo "$PSQL_HOST $PSQL_PORT $PSQL_DBNAME $PSQL_USER $PSQL_PASSWORD" > ~/12345.txt

# Запуск Java-приложения
/usr/bin/java -jar /home/jarservice/sausage-store.jar \
  --spring.datasource.url=jdbc:postgresql://$PSQL_HOST:$PSQL_PORT/$PSQL_DBNAME \
  --spring.datasource.username=$PSQL_USER \
  --spring.datasource.password=$PSQL_PASSWORD \
  --spring.flyway.baselineOnMigrate='yes'
