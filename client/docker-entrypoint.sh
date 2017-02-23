#!/bin/bash

echo "Inside entrypoint -- Will connect the app to TSA_URL = ${TSA_URL}"

# start the app using maven command
mvn tomcat7:run -Dtsa_url=${TSA_URL}