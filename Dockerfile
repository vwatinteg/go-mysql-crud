FROM alpine

COPY dist/go-mysql-crud /bin/
COPY ci/bin/* /bin/

RUN /bin/init_db.sh

EXPOSE 8005

ENTRYPOINT [ "/bin/go-mysql-crud" ]
