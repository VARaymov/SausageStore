#! /bin/bash
set -xe
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
sudo rm -f /home/student/sausage-store.jar||true
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store-frontend-${VERSION}.jar ${NEXUS_REPO_URL_BACKEND}/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar
sudo cp ./sausage-store-frontend-${VERSION}.jar /home/front-user/sausage-store.jar||true
sudo systemctl daemon-reload 
sudo systemctl restart sausage-store-frontend.service
