#!/bin/bash

# Assign CLI to local variables
cmd=$1
db_username=$2
db_password=$3

# Check if docker is already running, if not launch it
sudo systemctl status docker || systemctl start docker

docker container inspect jrvs-psql
container_status=$?


case $cmd in
  create)

  if [ $container_status -eq 0 ]; then
		echo 'Container already exists'
		exit 1
	fi

  if [ $# -ne 3 ]; then
    echo 'Create requires username and password'
    exit 1
  fi

	docker volume create pgdata

	docker run --name jrvs-psql -e POSTGRES_USER="$db_username" -e POSTGRES_PASSWORD="$db_password" -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine

	exit $?
	;;

  start|stop)

  if [ $container_status -ne 0 ]; then
    echo 'The container has not been found'
    exit 1
  fi

	docker container $cmd jrvs-psql
	exit $?
	;;

  *)
	echo 'Illegal command'
	echo 'Commands: start|stop|create'
	exit 1
	;;
esac