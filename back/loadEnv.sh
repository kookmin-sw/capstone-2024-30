#!/bin/bash

ENV_FILE=".env"

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file does not exist."
    exit 1
fi

while IFS='=' read -r key value
do
  if [ ! -z "$key" ]; then
    export "$key=$value"
  fi
done < "$ENV_FILE"

echo "All variables from $ENV_FILE are now exported."

gradle clean build