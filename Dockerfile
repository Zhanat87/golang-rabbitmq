# golang image where workspace (GOPATH) configured at /go.
FROM golang
# сначала надо залить все файлы в github
# затем обновить все файлы с github'а
# и тогда обновления появятся в докере
# так же надо все время перезапускать контейнер
# в главном docker-compose.yml файле, restart: always
RUN go get -u github.com/Zhanat87/golang-rabbitmq
# Copy the local package files to the container’s workspace.
ADD . /go/src/github.com/Zhanat87/golang-rabbitmq
# Setting up working directory
WORKDIR /go/src/github.com/Zhanat87/golang-rabbitmq
# Get godeps for managing and restoring dependencies
RUN go get github.com/tools/godep
# Restore godep dependencies
# RUN godep restore
# Build the golang-rabbitmq command inside the container.
RUN go install github.com/Zhanat87/golang-rabbitmq
# Run the golang-rabbitmq command when the container starts.
ENTRYPOINT /go/bin/golang-rabbitmq
# Service listens on port 8083.
EXPOSE 8083


################################################################################
## golang-rabbitmq
################################################################################

golang-rabbitmq:
# Builds from Dockerfile located under ../golang-rabbitmq
  build: ../golang-rabbitmq
  restart: always
  dockerfile: Dockerfile
  container_name: golang-rabbitmq
  volumes:
    - ../stack-auth:/go/src/github.com/Zhanat87/golang-rabbitmq
  links:
    - stack-postgres
    - stack-rabbitmq
  ports:
    - "8083:8083"