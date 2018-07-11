#!/bin/bash

export MASTERSIZE=n1-standard-4
export IMAGE=centos-7-v20180611
export IMAGEPROJECT=centos-cloud
export MASTERDISKSIZE=250GB
export ZONE=us-west1-b

gcloud compute instances create ${CLUSTERID}-master \
    --async --machine-type=${MASTERSIZE} \
    --subnet=${CLUSTERID_SUBNET} \
    --address="" --no-public-ptr \
    --maintenance-policy=MIGRATE \
    --scopes=https://www.googleapis.com/auth/cloud.useraccounts.readonly,https://www.googleapis.com/auth/compute,https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol \
    --tags=${CLUSTERID}-master,${CLUSTERID}-node \
    --metadata "ocp-cluster=${CLUSTERID},${CLUSTERID}-type=master" \
    --image=${IMAGE}  --image-project=${IMAGEPROJECT} \
    --boot-disk-size=${MASTERDISKSIZE} --boot-disk-type=pd-ssd \
    --boot-disk-device-name=${CLUSTERID}-master \
    --zone=${ZONE}