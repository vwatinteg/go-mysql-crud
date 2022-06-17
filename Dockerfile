# FROM docker.io/bitnami/mysql:8.0.29-debian-10-r22
FROM alpine

RUN apk add --no-cache mysql-client

COPY dist/go-mysql-crud /bin/

RUN rm -rf /var/cache/apk/*

EXPOSE 8005

ENTRYPOINT [ "/bin/go-mysql-crud" ]
