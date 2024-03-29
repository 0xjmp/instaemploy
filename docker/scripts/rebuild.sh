docker stop web
docker rm web
docker build -t web /app
docker run -d -p 3000:3000 -v /app:/app --link redis:redis --link postgres:db --name web web:latest