#!/bin/bash

# Create the directory if it does not exist
mkdir -p container_env_files

# Check for required environment variables
if [ -z "${CONFIG_DOMAIN}" ]
then
  echo CONFIG_DOMAIN env is missing
  exit 1
fi

if [ -z "${EXCHANGE_API_KEY}" ]
then
  echo EXCHANGE_API_KEY env is missing
  exit 1
fi

if [ -z "${SUPERUSER_EMAIL}" ]
then
  echo SUPERUSER_EMAIL env is missing
  exit 1
fi

if [ -z "${SUPERUSER_USERNAME}" ]
then
  echo SUPERUSER_USERNAME env is missing
  exit 1
fi

if [ -z "${SUPERUSER_PASSWORD}" ]
then
  echo SUPERUSER_PASSWORD env is missing
  exit 1
fi

# Generate the environment files using `sed`
sed "s/SUPERUSER_EMAIL_VALUE/$SUPERUSER_EMAIL/g; s/SUPERUSER_USERNAME_VALUE/$SUPERUSER_USERNAME/g; s/SUPERUSER_PASSWORD_VALUE/$SUPERUSER_PASSWORD/g; s|CONFIG_DOMAIN|$CONFIG_DOMAIN|g;" $1 ./container_env_files_templates/cfg.env > ./container_env_files/cfg.env

sed "s/EXCHANGE_API_KEY_VALUE/$EXCHANGE_API_KEY/g" $1 ./container_env_files_templates/cgw.env > ./container_env_files/cgw.env

sed "s/SUPERUSER_EMAIL_VALUE/$SUPERUSER_EMAIL/g; s/SUPERUSER_PASSWORD_VALUE/$SUPERUSER_PASSWORD/g" $1 ./container_env_files_templates/events.env > ./container_env_files/events.env

sed "s|CONFIG_DOMAIN|$CONFIG_DOMAIN|g;" $1 ./container_env_files_templates/txs.env > ./container_env_files/txs.env

sed "s|CONFIG_DOMAIN|$CONFIG_DOMAIN|g;" $1 ./container_env_files_templates/ui.env > ./container_env_files/ui.env

sed "s|RPC_NODE_URL_VALUE|$RPC_NODE_URL|g;" $1 ./container_env_files_templates/.env > .env
