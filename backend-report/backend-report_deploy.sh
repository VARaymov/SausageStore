set +e
cat > backend-report.env <<EOF
DB=${SPRING_MONGODB_URI}
SPRING_CLOUD_VAULT_ENABLED=TRUE
EOF
docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD} ${REGISTRY}
docker-compose stop backend-report || true
docker-compose rm backend-report || true
set -e
docker-compose --env-file backend-report.env up backend-report -d
