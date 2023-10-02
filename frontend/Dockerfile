FROM node:16 as builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install \
&& npm run build

# release
FROM node:16-slim
RUN npm install -g http-server \
&& addgroup --system frontenduser \
&& adduser --system --disabled-password --home /home/frontenduser --shell /bin/false --group frontenduser 
COPY --chown=frontenduser:frontenduser \
     --from=builder /usr/src/app/dist/frontend ./frontend
EXPOSE 80
USER frontenduser
ENTRYPOINT ["http-server", "./frontend/", "-p", "80", "--proxy", "http://backend:8080"]
