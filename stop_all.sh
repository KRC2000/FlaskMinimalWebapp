#!/bin/bash

echo ----- Job started: local_deploy.sh -------------------------------------------------

# stop and remove all the containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
echo INFO: All docker containers are stopped and removed

echo ----- Job finished: local_deploy.sh -------------------------------------------------
