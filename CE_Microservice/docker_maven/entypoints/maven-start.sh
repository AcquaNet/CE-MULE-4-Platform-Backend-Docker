#!/bin/bash
cd /home
echo '---------------------------------------------'
echo '------------------------------------------------------------------------------------'
echo '          ATINA_REPOSITORY_PROTOCOL: ' ${ATINA_REPOSITORY_PROTOCOL}
echo '          ATINA_REPOSITORY_URL: ' ${ATINA_REPOSITORY_URL}
echo '          MULEAPP_GROUP_ID: ' ${MULEAPP_GROUP_ID}
echo '          MULEAPP_ARTIFACT_ID: ' ${MULEAPP_ARTIFACT_ID}
echo '          MULEAPP_VERSION: ' ${MULEAPP_VERSION}
echo '------------------------------------------------------------------------------------'
GROUP_PATH=$(echo ${MULEAPP_GROUP_ID} | tr '.' '/')
ARTIFACT_PATH=/home/repository/${GROUP_PATH}/${MULEAPP_ARTIFACT_ID}/${MULEAPP_VERSION}
# Verificar si el directorio existe y eliminarlo
if [ -d "${ARTIFACT_PATH}" ]; then
  echo "Eliminando artefacto de ${ARTIFACT_PATH}"
  rm -rf "${ARTIFACT_PATH}"
  echo "Artefacto eliminado."
else
  echo "El artefacto no se encontró en ${ARTIFACT_PATH}"
fi
echo 'Downloading Applications...'
echo 'mvn org.apache.maven.plugins:maven-dependency-plugin:2.4:get -DremoteRepositories=${ATINA_REPOSITORY_PROTOCOL}://${ATINA_REPOSITORY_URL} -Dartifact=${MULEAPP_GROUP_ID}:${MULEAPP_ARTIFACT_ID}:${MULEAPP_VERSION} -Ddest=/home/apps/${MULEAPP_ARTIFACT_ID}-${MULEAPP_VERSION}-mule-application.jar'
mvn org.apache.maven.plugins:maven-dependency-plugin:2.4:get -DremoteRepositories=${ATINA_REPOSITORY_PROTOCOL}://${ATINA_REPOSITORY_URL} -Dartifact=${MULEAPP_GROUP_ID}:${MULEAPP_ARTIFACT_ID}:${MULEAPP_VERSION} -Ddest=/home/apps/${MULEAPP_ARTIFACT_ID}-${MULEAPP_VERSION}-mule-application.jar -U
echo '------------------------------------------------------------------------------------'
echo 'Maven Ejecutado'