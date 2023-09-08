#!/bin/bash
# Expected that host has a "krs" user who is added to "docker" user group, docker and git is installed


REMOTE_HOST="188.34.192.184"
REMOTE_USER="krs"

ssh ${REMOTE_USER}@${REMOTE_HOST} << 'EOF'
	echo ----- Job started: deploy.sh -------------------------------------------------
	cd ~

	# clone webapp repo, if repo already clonned - fetch and pull new changes
	if [ -d "FlaskMinimalWebapp" ]; then
		echo INFO: FlaskMinimalWebapp folder already exists, pulling changes
		cd FlaskMinimalWebapp
		git pull --rebase
	else
		echo INFO: FlaskMinimalWebapp folder absent, cloning
		git clone https://KRC2000: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@github.com/KRC2000/FlaskMinimalWebapp.git
		cd FlaskMinimalWebapp
	fi

	
	# ensure that "network_main" docker network exists
	./ensure_network_main.sh

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

	# build a docker webserver image, run that image in the container
	# network: network_main
	# external port: 80
	# name: webserver
	docker build --build-arg ENDPOINT="188.34.192.184" -t flask_webserver .
	docker run --network network_main --name webserver -p 80:5000 flask_webserver
	echo: INFO: Webserver image is built and container started.

	echo ----- Job finished: deploy.sh -------------------------------------------------

	# Add more commands as needed
EOF
