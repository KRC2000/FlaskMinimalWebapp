#!/bin/bash

echo ----- Job started: build_n_rerun.sh -------------------------------------------------

docker stop webserver
docker rm webserver
echo INFO: Webserver container is stopped and removed

docker build --build-arg ENDPOINT="0.0.0.0" -t flask_webserver .
./ensure_network_main.sh
docker run --network network_main --name webserver -p 5000:5000 flask_webserver
echo: INFO: Webserver image is built and container started.

echo ----- Job finished: build_n_rerun.sh -------------------------------------------------
