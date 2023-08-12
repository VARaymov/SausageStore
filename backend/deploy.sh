#! /bin/bash
#чтобы скрипт завершался, если есть ошибки. Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -rf sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service
sudo rm -f /home/jarservice/sausage-store.jar||true
#Переносим в нужную папку
#скачиваем артефакт
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store-backend-${VERSION}.jar ${NEXUS_REPO_URL_BACKEND}/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar
pwd
ls -la
sudo cp ./sausage-store-backend-${VERSION}.jar /home/jarservice/sausage-store.jar||true #"<...>||true" говорит, если команда обвалится - продолжай
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-backend.service
