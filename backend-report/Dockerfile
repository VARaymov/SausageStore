FROM python:latest
ADD . /app
WORKDIR /app
RUN curl https://storage.yandexcloud.net/cloud-certs/CA.pem -o YandexInternalRootCA.crt && cp YandexInternalRootCA.crt /usr/local/share/ca-certificates/YandexInternalRootCA.crt && update-ca-certificates
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
EXPOSE 8081
