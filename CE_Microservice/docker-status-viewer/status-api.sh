#!/bin/bash
cd /home
echo '---------------------------------------------'
echo 'Iniciando Status API'
echo '------------------------------------------------------------------------------------'
echo '          API_STATUS URL: ' ${API_STATUS_URL} 
echo '------------------------------------------------------------------------------------'
response=$(curl -k -s -w "\n%{http_code}" ${API_STATUS_URL})
http_code=$(echo "$response" | tail -n1)
response_body=$(echo "$response" | sed '$d')
# Mostrar la respuesta en la consola
echo "Response from API:"
echo "$response_body"
echo "HTTP Status Code: $http_code"
