#!/bin/bash
set +e
echo "$CI_REGISTRY_PASSWORD" | docker login --username "$CI_REGISTRY_USER" --password-stdin "$CI_REGISTRY"
docker pull gitlab.praktikum-services.ru:5050/std-019-002/sausage-store/sausage-frontend:latest
docker-compose stop frontend || true
docker-compose rm frontend || true
set -e
docker-compose up -d frontend
