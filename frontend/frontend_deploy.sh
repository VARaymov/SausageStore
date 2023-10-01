#!/bin/bash
set +e
docker network create -d bridge sausage_network || true
echo "$CI_REGISTRY_PASSWORD" | docker login --username "$CI_REGISTRY_USER" --password-stdin "$CI_REGISTRY"
docker pull gitlab.praktikum-services.ru:5050/std-019-002/sausage-store/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker run -d --name frontend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    gitlab.praktikum-services.ru:5050/std-019-002/sausage-store/sausage-frontend:latest
