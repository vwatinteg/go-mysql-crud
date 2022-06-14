FROM alpine

COPY dist/go-mysql-crud /bin/

EXPOSE 8005

ENTRYPOINT [ "/bin/go-mysql-crud" ]
