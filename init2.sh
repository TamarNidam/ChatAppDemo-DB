#!/bin/bash

docker stop $(docker ps -a -q) # Stop all running containers
docker rm $(docker ps -a -q) # Remove all stopped containers
docker rmi -f $(docker images -a -q)   # Remove all images  
#docker-compose up -d  