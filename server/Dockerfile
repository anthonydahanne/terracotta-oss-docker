# using the latest OpenJDK 8 update (see https://hub.docker.com/_/openjdk/ for more details)
FROM openjdk:8-jdk-alpine
MAINTAINER Anthony Dahanne <anthony.dahanne@softwareag.com>

# add few utilities, upgrade tar
RUN apk --update add tar openssl ca-certificates bash

# downloading, untarring and removing the archive, link from https://github.com/ehcache/ehcache3/releases
RUN wget -q https://github.com/ehcache/ehcache3/releases/download/v3.1.2/ehcache-clustered-3.1.2-kit.tgz \
  && mkdir /terracotta \
  && tar xvzf ehcache-clustered-3.1.2-kit.tgz -C /terracotta --strip-components=1 \
  && rm ehcache-clustered-3.1.2-kit.tgz

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/

ADD config/tc-config-single-node.xml /terracotta/server/config/
ADD config/tc.custom.log4j.properties /terracotta/.tc.custom.log4j.properties

# all below commands will now be relative to this path
WORKDIR /terracotta/server

# the tsa port (used by the clients to connect to the cluster)
EXPOSE 9510
# the group port (used to sync the passives with the active)
EXPOSE 9530

# default values for offheap, that you can override when starting your container with docker run -e OFFHEAP_RESOURCE_SIZE=512 for example
ENV OFFHEAP_RESOURCE_NAME "primary-server-resource"
ENV OFFHEAP_RESOURCE_UNIT "MB"
ENV OFFHEAP_RESOURCE_SIZE "64"

#ENTRYPOINT ["bin/start-tc-server.sh", "-f"]
#CMD ["config/tc-config-single-node.xml"]

ENTRYPOINT sed -i -r 's/OFFHEAP_RESOURCE_NAME/'$OFFHEAP_RESOURCE_NAME'/; s/OFFHEAP_RESOURCE_UNIT/'$OFFHEAP_RESOURCE_UNIT'/; s/OFFHEAP_RESOURCE_SIZE/'$OFFHEAP_RESOURCE_SIZE'/' config/tc-config*.xml \
  && bin/start-tc-server.sh -f config/tc-config-single-node.xml