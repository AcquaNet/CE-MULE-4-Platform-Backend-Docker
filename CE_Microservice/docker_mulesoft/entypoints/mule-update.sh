#!/bin/bash
cd /home
echo '------------------------------------------------------------------------------------'
echo 'Updating Microservice: ' ${MULEAPP_GROUP_ID_FOLDER}/${MULEAPP_ARTIFACT_ID}/${MULEAPP_VERSION}    
echo '------------------------------------------------------------------------------------'>>/home/start.log 
echo '          REPOSITORY: ' ${REPOSITORY_PROTOCOL}: ${REPOSITORY_URL}>>/home/start.log
echo '          MULEAPP_GROUP_ID: ' ${MULEAPP_GROUP_ID}>>/home/start.log
echo '          MULEAPP_ARTIFACT_ID: ' ${MULEAPP_ARTIFACT_ID}>>/home/start.log
echo '          MULEAPP_VERSION: ' ${MULEAPP_VERSION}>>/home/start.log
echo '          muleVersion: ' ${muleVersion}>>/home/start.log
rm -r -f $MAVEN_CONFIG/repository/${MULEAPP_GROUP_ID_FOLDER}/${MULEAPP_ARTIFACT_ID}/${MULEAPP_VERSION}
rm -f /tmp/${MULEAPP_ARTIFACT_ID}-${MULEAPP_VERSION}.zip
mvn org.apache.maven.plugins:maven-dependency-plugin:2.4:get -DremoteRepositories=$REPOSITORY_PROTOCOL://$REPOSITORY_URL -Dartifact=${MULEAPP_GROUP_ID}:${MULEAPP_ARTIFACT_ID}:${MULEAPP_VERSION}:zip -Ddest=/tmp/${MULEAPP_ARTIFACT_ID}-${MULEAPP_VERSION}.zip
echo 'Actualizacione descargada ' ${MULEAPP_GROUP_ID_FOLDER}/${MULEAPP_ARTIFACT_ID}/${MULEAPP_VERSION}

