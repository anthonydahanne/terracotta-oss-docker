# using the latest OpenJDK 8 update (see https://registry.hub.docker.com/u/library/java/ for more details)
FROM java:openjdk-8-jdk
MAINTAINER Anthony Dahanne <anthony.dahanne@softwareag.com>

# maven section inspired by https://github.com/carlossg/docker-maven/blob/8ab542b907e69c5269942bcc0915d8dffcc7e9fa/jdk-8/Dockerfile
ENV MAVEN_VERSION 3.3.9

RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

RUN git clone https://github.com/anthonydahanne/spring-petclinic.git /usr/src/app/
WORKDIR /usr/src/app/
RUN git checkout using-oss-clustered-ehcache

# in a more serious deployment scenario and environment, this is where you would download your java jar
RUN mvn package -DskipTests

# expose the webapp port
EXPOSE 9966

# the default TSA url - can be overriden to match your environments
ENV TSA_URL 'tsa:9510'

# use a custom entry point to be able to read the ENV var properly
COPY ./docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
