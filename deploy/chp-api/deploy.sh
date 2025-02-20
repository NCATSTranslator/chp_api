#!/bin/bash

# variables 
projectName="chp-api"
namespace="chp"
# replace place_holder with values from env var
# env var's key needs to be the same as the place_holder
toReplace=('BUILD_VERSION')

# export .env values to env vars
# export $(egrep -v '^#' .env)

# printenv

# replace variables in values.yaml with env vars

for item in "${toReplace[@]}";
do
  sed -i.bak \
      -e "s/${item}/${!item}/g" \
      values.yaml
  rm values.yaml.bak
done

kubectl apply -f namespace.yaml

# deploy helm chart
helm -n ${namespace} upgrade --install ${projectName} -f values.ncats.yaml ./