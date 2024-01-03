#!/bin/bash

set -xe

CLUSTER_VERSION=$(echo "1.26.5-gke.2100")
CLUSTER_NAME=$(echo "upgrade-demo")
CLUSTER_PROJECT=$(echo "akuity-training")
CLUSTER_ZONE=$(echo "us-central1-a")

CLUSTER_DESCRIPTION=$(gcloud container clusters describe ${CLUSTER_NAME} --zone ${CLUSTER_ZONE} --project ${CLUSTER_PROJECT})

CUR_MASTER_VERS=$(echo "${CLUSTER_DESCRIPTION}" | yq e '.currentMasterVersion')
CUR_NODE_VERS=$(echo "${CLUSTER_DESCRIPTION}" | yq e '.currentNodeVersion')

if [ "${CUR_MASTER_VERS}" == "${CLUSTER_VERSION}" ]; then
    echo "Current master version matches!"
else
    echo "Current master version does not match!"
    exit 1
fi

if [ "${CUR_MASTER_VERS}" == "${CLUSTER_VERSION}" ]; then
    echo "Current node version matches!"
else
    echo "Current node version does not match!"
    exit 1
fi

readarray nodePools < <( echo "${CLUSTER_DESCRIPTION}" | yq e -o=j -I=0 '.nodePools[]' )
for nodePool in "${nodePools[@]}"; do
    nodePoolName=$(echo "$nodePool" | yq e '.name' -)
    nodePoolVersion=$(echo "$nodePool" | yq e '.version' -)

    if [ "${nodePoolVersion}" == "${CLUSTER_VERSION}" ]; then
        echo "${nodePoolName} nodepool version matches!"
    else
        echo "${nodePoolName} nodepool version does not match!"
        exit 1
    fi
done