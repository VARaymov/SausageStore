FROM node:16
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm install -g http-server
RUN npm run build
RUN addgroup --system frontend-user \
    && adduser -S -s /bin/false -G frontend-user frontend-user -D -H 
EXPOSE 80
USER frontend-user
ENTRYPOINT ["http-server", "dist/frontend/", "-p", "80", "--proxy", "http://sausage-backend:8080"]
