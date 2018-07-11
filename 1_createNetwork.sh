#!/bin/bash

export CLUSTERID=mycluster1
export CLUSTERID_NETWORK=mynetwork1
export CLUSTERID_SUBNET=mysubnet1
export CLUSTERID_SUBNET_CIDR="172.19.0.0/24"
export SOURCES="0.0.0.0/0"

# Network
gcloud compute networks create ${CLUSTERID_NETWORK} --subnet-mode custom

# Subnet
gcloud compute networks subnets create ${CLUSTERID_SUBNET} \
  --network ${CLUSTERID_NETWORK} \
  --range ${CLUSTERID_SUBNET_CIDR}

# firewall setup
gcloud compute firewall-rules create ${CLUSTERID}-443 \
  --direction=INGRESS --priority=1000  --network=${CLUSTERID_NETWORK} \
  --action=ALLOW --rules=tcp:443 \
  --source-ranges=${SOURCES} --target-tags=${CLUSTERID}-master

gcloud compute firewall-rules create ${CLUSTERID}-8443 \
  --direction=INGRESS --priority=1000  --network=${CLUSTERID_NETWORK} \
  --action=ALLOW --rules=tcp:8443 \
  --source-ranges=${SOURCES} --target-tags=${CLUSTERID}-master

gcloud compute firewall-rules create ${CLUSTERID}-80 \
  --direction=INGRESS --priority=2000  --network=${CLUSTERID_NETWORK} \
  --action=ALLOW --rules=tcp:80 \
  --source-ranges=${SOURCES} --target-tags=${CLUSTERID}-master
  
gcloud compute firewall-rules create ${CLUSTERID}-22 \
  --direction=INGRESS --priority=3000  --network=${CLUSTERID_NETWORK} \
  --action=ALLOW --rules=tcp:22 \
  --source-ranges=${SOURCES} --target-tags=${CLUSTERID}-master

gcloud compute firewall-rules create ${CLUSTERID}-2376 \
  --direction=INGRESS --priority=3000  --network=${CLUSTERID_NETWORK} \
  --action=ALLOW --rules=tcp:2376 \
  --source-ranges=${SOURCES} --target-tags=${CLUSTERID}-master
