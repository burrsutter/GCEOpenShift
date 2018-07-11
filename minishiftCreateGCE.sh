#!/bin/bash
minishift profile set gceInstance
# what memory and CPU will minishift pick?
# minishift config set memory 14GB
# minishift config set cpus 3
minishift config set vm-driver generic
# minishift config set image-caching true
minishift addon enable admin-user
minishift addon enable anyuid
# minishift ip --set-static
minishift config set remote-ipaddress $publicIP
minishift config set remote-ssh-user burr
minishift config set remote-ssh-key ~/.ssh/google_compute_engine

minishift start

