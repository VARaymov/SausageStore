#!/bin/bash
set +e
cat > backend.env <<EOF
SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
EOF
echo "$CI_REGISTRY_PASSWORD" | docker login --username "$CI_REGISTRY_USER" --password-stdin "$CI_REGISTRY"
docker pull gitlab.praktikum-services.ru:5050/std-019-002/sausage-store/sausage-backend:latest
if [[ "$(docker ps --filter "name=green-backend" -q)" ]]; then
	echo "Уже запущен green-backend"
	HEALTHY=false
	while [ "$HEALTHY" != "healthy" ]; do
		HEALTHY=$(docker inspect --format '{{.State.Health.Status}}' green-backend)
		sleep 15
		if [ "$HEALTHY" == "exited" ]; then
			echo "Состояние green-backend не true"
		fi
	done
	echo "green-backend запущен успешно, blue-backend будет остановлен"
	docker-compose stop blue-backend
	exit 0
elif [[ "$(docker ps --filter "name=blue-backend" -q)" ]]; then
	echo "Запущен blue-backend, будет запущен green-backend"
	docker-compose --env-file backend.env up -d green-backend
	sleep 15
	HEALTHY=false
	while [ "$HEALTHY" != "healthy" ]; do
		HEALTHY=$(docker inspect --format '{{.State.Health.Status}}' green-backend)
		sleep 15
		if [ "$HEALTHY" == "exited" ]; then
			echo "Состояние green-backend не true"
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
