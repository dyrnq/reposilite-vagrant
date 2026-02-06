#!/usr/bin/env bash

docker rm -f repo1
mkdir -p $HOME/repo1/data
docker run \
-d \
--name repo1 \
--restart always \
-v $HOME/repo1/data:/app/data \
-p 18080:8080 \
-e JAVA_OPTS='-Xmx512M' \
-e REPOSILITE_OPTS="--token name:secret --disable-it" \
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
--restart always \
-v $HOME/repo1/data:/app/data \
-p 18080:8080 \
-e JAVA_OPTS='-Xmx512M' \
-e REPOSILITE_OPTS="--disable-it" \
dzikoysk/reposilite:3.5.26