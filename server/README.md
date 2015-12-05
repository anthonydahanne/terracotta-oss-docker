# Docker image definition for Terracotta Server

## Introduction

The Terracotta 4.x OSS offering includes the following:

 *  Ehcache 2.x compatibility
 *  Distributed In-Memory Data Management with fault-tolerance via Terracotta Server (1 stripe – active with optional mirror)
 *  In memory off-heap storage - take advantage of all the RAM in your server

The current [Dockerfile]() is based on the java:8-jdk image, and adds Terracotta 4.3.1 OSS on top of it (http://terracotta.org/downloads/open-source/catalog)

## How to start your Terracotta Server(s) in Docker containers

### Quick start : one active node

    docker run --name tc-server -d -p 9510:9510 terracotta-server-oss:4.3.1

A quick look at the logs :

    docker logs -f tc-server

Should return some logs ending with :

    [TC] 2015-12-05 04:17:31,299 INFO - Management server started on 0.0.0.0:9540

You can also load [http://DOCKER_HOST:9510/config](http://DOCKER_HOST:9510/config) from the host machine to see the configuration of your Terracotta Server Array.

It's now ready and waiting for clients

## How to build this image

To build this [Dockerfile](), clone this [git repository]() and run :

    docker build -t terracotta-server-oss:4.3.1 .
