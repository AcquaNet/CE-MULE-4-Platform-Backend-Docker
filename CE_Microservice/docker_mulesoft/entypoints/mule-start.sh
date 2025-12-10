#!/bin/bash
cd /home
echo '---------------------------------------------'
echo 'Starting Mule Server'
export app_version=$(cat /opt/mule/build-date.txt)
echo '            Build date: ' $app_version >>/home/start.log
echo '------------------------------------------------------------------------------------'
echo '          ATINA_REPOSITORY_PROTOCOL: ' ${ATINA_REPOSITORY_PROTOCOL}
echo '          ATINA_REPOSITORY_URL: ' ${ATINA_REPOSITORY_URL}
echo '          muleVersion: ' ${muleVersion}
echo '          Mule Environment: ' ${mule_env}
echo '------------------------------------------------------------------------------------'
echo 'Iniciando Mule'
exec /opt/mule/mule-standalone-${muleVersion}/bin/mule  -dmule_env=${mule_env}
echo 'Mule Iniciado'