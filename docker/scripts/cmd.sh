#!/bin/bash
docker run -i -t -v /app:/app --link redis:redis --link postgres:db  --rm web:latest bash -c "cd /app && eval '$1'"