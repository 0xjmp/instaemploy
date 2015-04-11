#!/bin/bash
docker stop web

docker run -i -t -v /app:/app --link redis:redis --link postgres:db  --rm web:latest bash -c "/setup_database.sh"

docker start web