#!/usr/bin/env bash

wait4x_image="${wait4x_image:-atkrad/wait4x:3.6.0}"
adminer_image="${adminer_image:-adminer:5.4.1}"


docker network inspect mynet &>/dev/null || docker network create --subnet 172.18.0.0/16 --gateway 172.18.0.1 --driver bridge mynet

docker rm -f mysql84
mkdir -p $HOME/mysql84/data
docker run \
-d \
--name mysql84 \
--restart always \
--network mynet \
-e MYSQL_ROOT_PASSWORD="666666" \
-p 3306:3306 \
mysql:8.4.8 --default-time-zone=+8:00 --innodb-dedicated-server=on


docker run --rm --network mynet --name='wait4x' ${wait4x_image} mysql root:666666@tcp\(mysql84:3306\)/mysql --interval 1s --timeout 360s && \
docker run -it --rm --network mynet mysql:8.4.8 mysql --host mysql84 --user root --password=666666 --loose-default-character-set=utf8 -e "CREATE DATABASE if not exists reposilite DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;show databases;"

docker rm -f adminer
docker run -d --name=adminer --restart always --network mynet -p 28080:8080 ${adminer_image}

docker rm -f repo1
mkdir -p $HOME/repo1/data
docker run \
-d \
--name repo1 \
--restart always \
--network mynet \
-v $HOME/repo1/data:/app/data \
-p 18080:8080 \
-e JAVA_OPTS='-Xmx512M' \
-e REPOSILITE_OPTS="--token name:secret --disable-it" \
-e REPOSILITE_LOCAL_DATABASE="mysql mysql84:3306 reposilite root 666666" \
dzikoysk/reposilite:3.5.26

sleep 10s;

curl \
-X POST http://127.0.0.1:18080/api/console/execute \
-H "Content-Type: application/x-www-form-urlencoded" \
-H "Authorization: Basic $(echo -n name:secret | base64)" \
-d "token-generate -s pass admin m"


docker rm -f repo1
docker run \
-d \
--name repo1 \
--network mynet \
--restart always \
-v $HOME/repo1/data:/app/data \
-p 18080:8080 \
-e JAVA_OPTS='-Xmx512M' \
-e REPOSILITE_OPTS="--disable-it" \
-e REPOSILITE_LOCAL_DATABASE="mysql mysql84:3306 reposilite root 666666" \
dzikoysk/reposilite:3.5.26


sleep 10s
(
curl -fsSL -X GET http://127.0.0.1:18080/api/settings/domains -H "Authorization: Basic $(echo -n admin:pass | base64)" | jq
curl -fsSL -X GET http://127.0.0.1:18080/api/settings/domain/maven -H "Authorization: Basic $(echo -n admin:pass | base64)" | jq
)