set +e
cat > backend-report.env <<EOF
REPORTS_MONGODB_URI=${SPRING_MONGODB_URI}
SPRING_CLOUD_VAULT_ENABLED=TRUE
EOF
echo "$CI_REGISTRY_PASSWORD" | docker login --username "$CI_REGISTRY_USER" --password-stdin "$CI_REGISTRY"
docker pull gitlab.praktikum-services.ru:5050/std-019-002/sausage-store/sausage-backend-report:latest
docker-compose stop backend-report || true
docker-compose rm -f backend-report || true
set -e
docker-compose --env-file backend-report.env up -d backend-report
