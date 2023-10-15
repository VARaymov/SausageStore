#!/bin/bash
set +e
cat > backend.env <<EOF
SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
EOF
echo "$CI_REGISTRY_PASSWORD" | docker login --username "$CI_REGISTRY_USER" --password-stdin "$CI_REGISTRY"
docker pull gitlab.praktikum-services.ru:5050/std-019-002/sausage-store/sausage-backend:latest
CURRENT_CONTAINER="0"
if [[ "$(docker ps --filter "name=green-backend" -q)" ]]; then
    CURRENT_CONTAINER="green-backend"
	echo "Уже запущен green-backend"
	exit 0
elif [[ "$(docker ps --filter "name=blue-backend" -q)" ]]; then
    CURRENT_CONTAINER="blue-backend"
	echo "Запущен blue-backend, будет запущен green-backend"
	docker-compose --env-file backend.env up -d green-backend
	sleep 15
	HEALTHY=false
	while [ "$HEALTHY" != "true" ]; do
		HEALTHY=$(docker inspect -f "{{.State.Status}}" green-backend)
		sleep 15
		if [ "$HEALTHY" == "exited" ]; then
			echo "Не удалось запустить green-backend"
			exit 1
		fi
	done
	echo "green-backend запущен успешно, blue-backend будет остановлен"
	docker-compose stop blue-backend
	exit 0
else
    docker-compose --env-file backend.env up -d green-backend
	echo "Не запущено ни одного контейнера, будет запущен green-backend"
	exit 0
fi
