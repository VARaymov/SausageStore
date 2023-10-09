#!/bin/bash
set +e
cat > backend.env <<EOF
SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
SPRING_DATA_MONGODB_URI=${SPRING_DATA_MONGODB_URI}
EOF
echo $SPRING_DATASOURCE_URL
echo $SPRING_DATASOURCE_USERNAME
echo $SPRING_DATASOURCE_PASSWORD
echo $SPRING_DATA_MONGODB_URI
echo "$CI_REGISTRY_PASSWORD" | docker login --username "$CI_REGISTRY_USER" --password-stdin "$CI_REGISTRY"
docker pull gitlab.praktikum-services.ru:5050/std-019-002/sausage-store/sausage-backend:latest
docker-compose stop backend || true
docker-compose rm backend || true
set -e
docker-compose --env-file backend.env up --pull always --wait -d backend
