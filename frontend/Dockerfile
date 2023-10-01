FROM node:16
# Create app directory
WORKDIR /usr/src/app
RUN addgroup --system frontenduser \
    && adduser -S -s /bin/false -G frontenduser frontenduser -D -H 
COPY --chown=frontenduser:frontenduser . .
RUN npm install
RUN npm install -g http-server
RUN npm run build
RUN cat /etc/passwd
EXPOSE 80
USER frontenduser
ENTRYPOINT ["http-server", "dist/frontend/", "-p", "80", "--proxy", "http://sausage-backend:8080"]
