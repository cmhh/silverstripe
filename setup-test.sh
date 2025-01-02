#! /usr/bin/env bash

docker build -t composer docker/composer/.
docker build -t silverstripe docker/silverstripe/.