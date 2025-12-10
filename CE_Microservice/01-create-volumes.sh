#!/usr/bin/env bash
set -e

# Carga variables del .env
source .env

ROOT="${FOLDER_ROOT}"

mkdir -p \
  "${ROOT}/Backend/activeMQ/conf" \
  "${ROOT}/Backend/activeMQ/data" \
  "${ROOT}/Backend/mule/logs" \
  "${ROOT}/Backend/mule/apps" \
  "${ROOT}/Backend/mysql/conf" \
  "${ROOT}/Backend/mysql/data" \
  "${ROOT}/Backend/maven/repository"
