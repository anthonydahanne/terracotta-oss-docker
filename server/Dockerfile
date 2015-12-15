# using the latest OpenJDK 8 update (see https://registry.hub.docker.com/u/library/java/ for more details)
FROM java:openjdk-8-jdk
MAINTAINER Anthony Dahanne <anthony.dahanne@softwareag.com>

# downloading, untarring and removing the archive
RUN wget -q https://d2zwv9pap9ylyd.cloudfront.net/terracotta-4.3.1.tar.gz \
  && mkdir bigmemory \
  && tar xvzf terracotta-4.3.1.tar.gz -C /bigmemory --strip-components=1 \
  && rm terracotta-4.3.1.tar.gz

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# all below commands will now be relative to this path
WORKDIR /bigmemory/server

# the management port
EXPOSE 9540
# the tsa port (used by the clients to connect to the cluster)
EXPOSE 9510
# the group port (used to sync the passives with the active)
EXPOSE 9530

ADD config/tc-config-single-node.xml /bigmemory/server/config/
ADD config/tc-config-active-passive.xml /bigmemory/server/config/

ADD config/tc.custom.log4j.properties /root/.tc.custom.log4j.properties

# default values for offheap, that you can override when starting your container with docker run -e OFFHEAP_MAX_SIZE=512g for example
ENV OFFHEAP_ENABLED "true"
ENV OFFHEAP_MAX_SIZE "1g"
# before starting the terracotta server, we update the tc-config.xml configuration file
ENTRYPOINT sed -i -r 's/OFFHEAP_ENABLED/'$OFFHEAP_ENABLED'/; s/OFFHEAP_MAX_SIZE/'$OFFHEAP_MAX_SIZE'/; s/TC_SERVER1/'$TC_SERVER1'/g; s/TC_SERVER2/'$TC_SERVER2'/g' config/tc-config*.xml \
#  && bash
#  && if [[ -n $TC_SERVER1 &&  -n $TC_SERVER2 ]]; then bin/start-tc-server.sh -f config/tc-config-active-passive.xml; else bin/start-tc-server.sh -f config/tc-config-single-node.xml; fi \
  && if [ \( -n $TC_SERVER1 \) -o  \( -n $TC_SERVER2 \) ]; then bin/start-tc-server.sh -f config/tc-config-active-passive.xml -n $HOSTNAME; else bin/start-tc-server.sh -f config/tc-config-single-node.xml; fi \

#  && cat config/tc-config-single-node.xml \
#  && echo "Hello $CONFIG_FILE" \
#  && bin/start-tc-server.sh -f config/$CONFIG_FILE
