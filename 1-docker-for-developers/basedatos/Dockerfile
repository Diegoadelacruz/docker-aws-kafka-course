FROM mariadb:10
LABEL maintainer="w.marchanaranda@gmail.com"

ENV MARIADB_ROOT_PASSWORD=toor
ENV MARIADB_DATABASE=demobd
ENV MARIADB_ROOT_HOST=%

COPY ./scripts/ /docker-entrypoint-initdb.d/

# RUN ls -al /docker-entrypoint-initdb.d/ && sleep 5s

CMD ["--default-authentication-plugin=mysql_native_password"]