### Docker image definition for High Availability Terracotta Server (Failover support)

#### Based on terracotta-server-oss:5.1.0

And adds the Terracotta configuration necessary to form a cluster stripe of 2 nodes: 1 active, 1 passive.

In case the active goes down, the passive will take over without any downtime.

You can achieve high availability with Terracotta servers with such a docker-compose configuration : 

```yml
version: '2'
services:
    demo-app:
        image: demo
        ports:
            - 8080
            
    demo-postgresql:
        container_name: demo-postgresql
        image: postgres:9.5.4
        environment:
            - POSTGRES_USER=demo
            - POSTGRES_PASSWORD=
        ports:
            - 5432:5432
    demo-postgresql:
        extends:
            file: postgresql.yml
            service: demo-postgresql
    demo-terracotta-server1:
        container_name: demo-terracotta-server1
        image: anthonydahanne/terracotta-server-oss:5.1.0_AP
        environment:
            - OFFHEAP_RESOURCE_SIZE=256
            - OFFHEAP_RESOURCE_UNIT=MB
            - OFFHEAP_RESOURCE_NAME=primary-server-resource
            - TC_SERVER1=demo-terracotta-server1
            - TC_SERVER2=demo-terracotta-server2
        ports:
            - 9510
    demo-terracotta-server2:
        container_name: demo-terracotta-server2
        image: anthonydahanne/terracotta-server-oss:5.1.0_AP
        environment:
            - OFFHEAP_RESOURCE_SIZE=256
            - OFFHEAP_RESOURCE_UNIT=MB
            - OFFHEAP_RESOURCE_NAME=primary-server-resource
            - TC_SERVER1=demo-terracotta-server1
            - TC_SERVER2=demo-terracotta-server2
        ports:
            - 9510

```

You can find some more information on the [ehcache3-samples/fullstack github repository](https://github.com/ehcache/ehcache3-samples/tree/master/fullstack)

#### How to build this image

To build this [Dockerfile](https://github.com/anthonydahanne/terracotta-oss-docker/blob/master/server/Dockerfile), clone this [git repository](https://github.com/anthonydahanne/terracotta-oss-docker) and run :

    $ cd server_AP
    $ docker build -t terracotta-server-oss:5.1.0_AP .
