#!/bin/bash

set -xe

readarray nodePools < <( gcloud container clusters describe upgrade-demo --zone us-central1-a --project akuity-training | yq e -o=j -I=0 '.nodePools[]' )
for nodePool in "${nodePools[@]}"; do
    nodePoolName=$(echo "$nodePool" | yq e '.name' -)
    echo "NodePool: $nodePoolName"
done