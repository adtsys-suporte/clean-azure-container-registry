#!/bin/sh

if [ "x$1" == "x" -o "x$2" == "x" -o "x$3" == "x" -o "x$4" == "x" ]; then
  echo 'Usage: "user.name@email.com" "password" "AzureContainerRegistry_NAME" "NUMBER of images to retain"'
  exit 1
fi

USERNAME="$1"
PASSWORD="$2"
CONTAINER_REGISTRY_NAME="$3"
IMAGES_TO_RETAIN="$4"

az login --username ${USERNAME} --password ${PASSWORD} > /dev/null 2>&1 
for i in $(az acr repository list -n ${CONTAINER_REGISTRY_NAME} --output tsv); do
  echo "Cleaning ${i}..."
  for j in $(az acr repository show-tags -n ${CONTAINER_REGISTRY_NAME} --repository ${i} --orderby time_desc --detail | jq -r .[].name | tail -n +$((IMAGES_TO_RETAIN+1))); do
    az acr repository delete -n ${CONTAINER_REGISTRY_NAME} --image "${i}:${j}" -y
  done
done
