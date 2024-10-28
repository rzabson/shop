docker buildx build --platform linux/amd64 -t my-jenkins:buildx-latest . &&  docker compose  up -d  my-jenkins
docker network create jenkins-sonarqube
