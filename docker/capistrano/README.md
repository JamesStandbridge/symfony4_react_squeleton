# Deploying with docker

First, you need to build docker image:

```
docker build -f docker/capistrano/Dockerfile . -t moins7clouderp/capistrano:latest
```


## SSH authentication

### Through SSH Socket


$SSH_AUTH_SOCK is the content of your current ssh socket, in your machine.
It's an elegant way to share SSH agent/connections from your machine to the docker container.

``̀`
docker run -v $SSH_AUTH_SOCK:/ssh-agent -v ${PWD}:/work -e SSH_AUTH_SOCK=/ssh-agent --entrypoint sh -ti moins7clouderp/capistrano:latest
