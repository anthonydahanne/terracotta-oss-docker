### Terracotta Server OSS running in a Docker container

Here are instructions to build and execute Docker images for Terracotta OSS server and a client

#### Before proceeding, make sure to
* have installed the latest [Docker Toolbox](https://www.docker.com/docker-toolbox)

Further instructions to build and execute are in those 2 sub folders :

 1. __server__ : instructions to build and execute a Terracotta Server Array in Docker containers, according to several deployment scenarios
 2. __client__ : instructions to build and execute a Java app connecting to a Terracotta Server Array, in a Docker container

It is strongly suggested you follow the steps in the above order.
In each folder, you'll find a README document explaining you how to create a Docker image, how to spawn it as a Docker container, with various deployment scenarios (including some Docker Compose examples)

#### Important notes

Those instructions are targeted at Docker version 1.9.1 and onwards, Docker machine at least 0.5.0

You will need a host with at least 2GB of memory

    docker-machine create --driver virtualbox --virtualbox-memory "2048" dev

````
$ docker-machine ls
NAME   ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER   ERRORS
dev    -        virtualbox   Running   tcp://192.168.99.103:2376           v1.9.1
````

so in my case, my DOCKER_HOST is reachable at 192.168.99.103