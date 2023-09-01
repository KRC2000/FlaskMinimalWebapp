#!/bin/bash
# Expected that "krs" user exists and is added to "docker" user group, docker and git is installed

echo -----------------------------------------------------------------------
# stop and remove all the containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

echo -----------------------------------------------------------------------
# run a MongoDB container with a mounted host folder for storing a database
# name: mongo
# network: network_main
# default port that gets exposed: 27017
# host folder that is mounted to store databases: /home/krs/db
networks=$(docker network ls)
if [[ $networks != *"network_main"* ]]; then
	docker network create -d bridge network_main
fi
docker run --detach --volume /home/krs/db:/data/db --network network_main --name mongo mongo

echo -----------------------------------------------------------------------
# build a docker image, run that image in the container
# network: network_main
# external port: 80
# name: webserver

docker build -t flask_webserver .
docker run --network network_main --name webserver -p 80:5000 flask_webserver