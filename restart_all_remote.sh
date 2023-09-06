#!/bin/bash
# Expected that host has a "krs" user who is added to "docker" user group, docker and git is installed, images are loaded


REMOTE_HOST="188.34.192.184"
REMOTE_USER="krs"

ssh ${REMOTE_USER}@${REMOTE_HOST} << 'EOF'
	echo ----- Job started: restart_all.sh -------------------------------------------------
	cd ~

	# stop and remove all the containers
	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)
	echo INFO: All docker containers are stopped and removed

	# run a MongoDB container with a mounted host folder for storing a database
	# name: mongo
	# network: network_main
	# default port that gets exposed: 27017
	# host folder that is mounted to store databases: /home/krs/db
	docker run --detach --volume /home/krs/db:/data/db --network network_main --name mongo mongo
	echo INFO: MongoDB container started.

	# run webapp image
	# network: network_main
	# external port: 80
	# name: webserver

	docker run --network network_main --name webserver -p 80:5000 flask_webserver
	echo: INFO: Webserver container started.

	echo ----- Job finished: restart_all.sh -------------------------------------------------

	# Add more commands as needed
EOF
