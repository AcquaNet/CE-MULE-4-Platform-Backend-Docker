#!/bin/bash
DIR=/docker-entrypoint.d   
cd /docker-entrypoint.d
./maven-start.sh
exec "$@"