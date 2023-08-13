#! /bin/bash
set -xe
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
sudo rm -f /home/student/sausage-store-frontend-${VERSION}.tar.gz||true
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store-frontend-${VERSION}.tar.gz ${NEXUS_REPO_URL_FRONTEND}/sausage-store-front/sausage-store/${VERSION}/sausage-store-${VERSION}.tar.gz
ls -la
tar -xvf sausage-store-frontend-${VERSION}.tar.gz -C .
ls -la
sudo cp ./sausage-store-frontend-${VERSION}/builds/std-019-002/sausage-store/frontend/dist/frontend /home/front-user/sausage-store/||true
sudo systemctl daemon-reload 
sudo systemctl restart sausage-store-frontend.service
