FROM alpine

RUN apk add --no-cache mysql-client file mariadb-connector-c

COPY dist/go-mysql-crud /bin/

RUN rm -rf /var/cache/apk/*

EXPOSE 8005

ENTRYPOINT [ "/bin/go-mysql-crud" ]
