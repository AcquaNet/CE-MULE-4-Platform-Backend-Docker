#!/bin/bash
echo '------------------------------------------------------------------------------------'
sleep 60
echo 'Copying Mule App' >>/home/start.log
cp /tmp/${MULEAPP_ARTIFACT_ID}-${MULEAPP_VERSION}.zip /opt/mule/mule-standalone-${muleVersion}/apps/${MULEAPP_ARTIFACT_ID}-${MULEAPP_VERSION}.zip
echo 'Copiado' >>/home/start.log
exit 0
