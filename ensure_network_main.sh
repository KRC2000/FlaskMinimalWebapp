#!/bin/bash

networks=$(docker network ls)
if [[ $networks != *"network_main"* ]]; then
	docker network create -d bridge network_main
	echo INFO: Network "network_main" is not present, created.
else
    echo INFO: Network "network_main" exists.
fi