docker build -t <nickname>/<nombre-imagen>:<version> <contexto>

docker build -t wjma90/bd-tmp:latest .
docker build -t wjma90/api-tmp:latest .
docker build --build-arg password=toor -t wjma90/api-tmp:latest .


docker run <opciones> <nickname>/<nombre-imagen>:<version>
    <opciones>:
        -d
        -p <puerto-computador>:<puerto-contenedor>
        --rm
        -e

docker run -d -p 3306:3306 -e MARIADB_ROOT_PASSWORD=12345678 --name bd01 mariadb:10
docker run -d -p 3306:3306 --name bd02 wjma90/bd-tmp

docker run -d -p 8090:8080 -e host=172.17.0.2 -e password=toor --name api02 wjma90/api-tmp


docker network create test

docker run -d -p 3306:3306 --name bd_server --network test wjma90/bd-tmp
docker run -d -p 8090:8080 -e host=bd_server -e password=toor --network test --name api02 wjma90/api-tmp

docker network rm test