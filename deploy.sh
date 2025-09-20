#!/bin/bash

for ARG in "$@"; do
    if [[ "$ARG" == *=* ]]; then
        eval "$ARG"
    fi
done



if [ -z "$service1_version" ]; then
    service1_version="1.0.0"
    echo "service1_version not provided, defaulting to $service1_version"
fi
if [ -z "$service2_version" ]; then
    service2_version="4.0.0"
    echo "service2_version not provided, defaulting to $service2_version"
fi

if [ -z "$service1_port" ]; then
    service1_port=8080
    echo "service1_port not provided, defaulting to $service1_port"
fi

if [ -z "$service2_port" ]; then
    service2_port=8081
    echo "service2_port not provided, defaulting to $service2_port"
fi


echo Deploying application with configuration: service1_version=$service1_version, service2_version=$service2_version, service1_port=$service1_port, service2_port=$service2_port

docker login -u "$DOCKERHUB_USERNAME" -p "$DOCKERHUB_PASSWORD"

docker pull jetpans/avl-services:service1-$service1_version
docker pull jetpans/avl-services:service2-$service2_version

docker network create avl-net 

docker run -d -p $service1_port:8080 --network avl-net --name service1 jetpans/avl-services:service1-$service1_version
docker run -d -p $service2_port:8081 --network avl-net -e SERVICE1_URL="http://service1:8080" --name service2 jetpans/avl-services:service2-$service2_version 

echo Application deployed successfully

# Wait for user to press a key before stopping and removing containers
read -p "Press enter to continue"
docker stop service1 service2
docker rm service1 service2
docker network rm avl-net
docker logout
