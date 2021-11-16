#!/bin/bash
clear
rm -rf ./log/postgresql/*
docker-compose -f "postgres-compose-14.yml" up --build "$@"
