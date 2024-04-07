FROM postgres:latest

WORKDIR /

COPY dump.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
