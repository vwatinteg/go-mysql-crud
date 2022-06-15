FROM alpine

RUN apk add --no-cache mysql-client

COPY dist/go-mysql-crud /bin/
COPY ci/bin/ /bin/

RUN rm -rf /var/cache/apk/*
EXPOSE 8005

ENTRYPOINT [ "/bin/go-mysql-crud" ]
