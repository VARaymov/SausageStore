FROM node:16 as builder
WORKDIR /app
COPY . .
RUN npm install \
&& npm run build

FROM nginxproxy/nginx-proxy
COPY --from=builder /app/dist/frontend/ /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
