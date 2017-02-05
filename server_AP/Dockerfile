# extend the single node image
FROM anthonydahanne/terracotta-server-oss:5.1.0
MAINTAINER Anthony Dahanne <anthony.dahanne@softwareag.com>

ADD config/tc-config-AP.xml /terracotta/server/config/

ENTRYPOINT sed -i -r '\
 s/TC_SERVER1/'$TC_SERVER1'/g;\
 s/TC_SERVER2/'$TC_SERVER2'/g;\
 s/OFFHEAP_RESOURCE_NAME/'$OFFHEAP_RESOURCE_NAME'/;\
 s/OFFHEAP_RESOURCE_UNIT/'$OFFHEAP_RESOURCE_UNIT'/;\
 s/OFFHEAP_RESOURCE_SIZE/'$OFFHEAP_RESOURCE_SIZE'/' config/tc-config*.xml \
 && bin/start-tc-server.sh -f config/tc-config-AP.xml