#!/bin/bash

#Giovanni De Franceschi

# Assign CLI to local variables
cmd=$1
db_username=$2
db_password=$3

# validate parameters
if [ $# -ge 4 ] || [ $# -lt 1 ]; then
  echo "Illegal number of parameters"
  exit 1
fi

# Check if docker is already running, if not start it
sudo systemctl status docker || systemctl start docker

docker container inspect jrvs-psql
container_status=$?

#check number of parameters
case $cmd in
  create)if [ $# -ge 4 ] || [ $# -lt 1 ]; then
  echo "Illegal number of parameters"
  exit 1
fi

#check if container is created
  if [ $container_status -eq 0 ]; then
		echo 'Container already exists'
		exit 1
	fi

#check if username and password are provided
  if [ $# -ne 3 ]; then
    echo 'Create requires username and password'
    exit 1
  fi

#check for the volume, create it if it doesn't exist
if [ $(docker volume ls | awk '{print $2}' | egrep 'pgdata') == '' ]; then
      docker volume create pgdata
    fi

#create postgres sql container
	docker run --name jrvs-psql -e POSTGRES_USER="$db_username" -e POSTGRES_PASSWORD="$db_password" -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine

	exit $?
	;;

  start)

    start)
    if [ "$docker_status" -eq 1 ]; then
      echo jrvs-psql container is not created
      exit 1
    fi
    docker container start jrvs-psql
    ;;
  stop)
    if [ "$docker_status" -eq 1 ]; then
      echo jrvs-psql container not  created
      exit 1
    fi
    docker container stop jrvs-psql
    ;;
  *)
    echo Please,  enter a valid command
    exit 1
esac
