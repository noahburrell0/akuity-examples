#!/bin/bash

ORG=$1
INSTANCE=$2
CLUSTER=$3

k3d cluster create ${CLUSTER} \
  --no-lb \
  --k3s-arg '--disable=traefik@server:0' \
  -p '30000-30004:30000:30004@servers:0:direct' \
  --wait

akuity login
akuity argocd cluster get-agent-manifests ${CLUSTER} --org-name ${ORG} --instance-name ${INSTANCE} | kubectl apply -f -
akuity argocd apply -f app-of-apps.yaml --org-name ${ORG} --name ${INSTANCE}

echo "\nMake sure sync your apps and create gcpsm-secret in the external-secrets namespace."