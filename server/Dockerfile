# using the latest OpenJDK 8 update (see https://registry.hub.docker.com/u/library/java/ for more details)
FROM java:8-jdk
MAINTAINER Anthony Dahanne <anthony.dahanne@softwareag.com>

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# downloading, untarring and removing the archive
RUN wget https://d2zwv9pap9ylyd.cloudfront.net/terracotta-4.3.1.tar.gz \
  && mkdir bigmemory \
  && tar xvzf terracotta-4.3.1.tar.gz -C /bigmemory --strip-components=1 \
  && rm terracotta-4.3.1.tar.gz

# all below commands will now be relative to this path
WORKDIR /bigmemory/server

# the management port
EXPOSE 9540
# the tsa port (used by the clients to connect to the cluster)
EXPOSE 9510
# the group port (used to sync the passives with the active)
EXPOSE 9530

ADD config/tc-config-single-node.xml /bigmemory/server/config/
ADD config/tc.custom.log4j.properties /root/.tc.custom.log4j.properties

# default values for offheap, that you can override when starting your container with docker run -e OFFHEAP_MAX_SIZE=512g for example
ENV OFFHEAP_ENABLED "true"
ENV OFFHEAP_MAX_SIZE "1g"
# before starting the terracotta server, we update the configuration tc-config.xml file
ENTRYPOINT sed -i -r 's/OFFHEAP_ENABLED/'$OFFHEAP_ENABLED'/; s/OFFHEAP_MAX_SIZE/'$OFFHEAP_MAX_SIZE'/' config/tc-config-single-node.xml \
#  && if [ $OFFHEAP_ENABLED = "false" ]; then sed -i -r '/<maxDataSize>.*<\/maxDataSize>/d' config/tc-config-single-node.xml ; fi \
#  && cat config/tc-config-single-node.xml \
  && bin/start-tc-server.sh -f config/tc-config-single-node.xml
