#! /usr/bin/env bash

docker build -t composer docker/composer/.
docker run -it --rm --user 1000:1000 -v ${PWD}/projects/test:/work composer install