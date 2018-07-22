Install gcloud cli
https://cloud.google.com/sdk/docs/quickstart-macos

CLI docs: https://cloud.google.com/sdk/gcloud/reference/compute/networks/create

or update
gcloud components update

gcloud version
cloud version
Google Cloud SDK 208.0.0
bq 2.0.34
core 2018.07.06
gsutil 4.33

gcloud init
prompt you to login & authorize via browser

gcloud projects create fromcli7102018
and visible in the browser at
https://console.cloud.google.com/cloud-resource-manager?organizationId=0

Make the default project
gcloud config set project fromcli7102018
gcloud config set compute/region us-west1
gcloud config set compute/zone b
gcloud config configurations list

Need to enable billing
gcloud components install beta
gcloud components install alpha
gcloud components list

gcloud beta billing accounts list
pick the one that says Open=True
gcloud alpha billing accounts projects link fromcli7102018 --account-id 003649-EAE8CE-243611

gcloud compute instances list
API [compute.googleapis.com] not enabled on project [634704714398]. 
Would you like to enable and retry (this will take a few minutes)? 
(y/N)?  y

What images are available?
gcloud compute images list 

source createNetwork.sh
source createInstance.sh

the first attempt at ssh creates the key, you will be prompted for a passphrase
./3_ssh.sh

Your identification has been saved in /Users/burr/.ssh/google_compute_engine.
Your public key has been saved in /Users/burr/.ssh/google_compute_engine.pub.

You can generate keys manually but the output is a .json file via the following steps


gcloud iam service-accounts create myserviceaccount

gcloud projects add-iam-policy-binding fromcli7102018 \
    --member serviceAccount:myserviceaccount@fromcli7102018.iam.gserviceaccount.com --role roles/editor

gcloud iam service-accounts keys create \
      --iam-account myserviceaccount@fromcli7102018.iam.gserviceaccount.com key.json


or

gcloud iam service-accounts create vm-instance-admin \
            --display-name "Projects VM Instance Admin"

gcloud iam service-accounts keys create \
            --iam-account vm-instance-admin@myansibleopenshift.iam.gserviceaccount.com gce-key.json

gcloud projects add-iam-policy-binding myansibleopenshift \
    --member serviceAccount:vm-instance-admin@myansibleopenshift.iam.gserviceaccount.com --role roles/compute.instanceAdmin.v1

gcloud projects add-iam-policy-binding myansibleopenshift \
    --member serviceAccount:vm-instance-admin@myansibleopenshift.iam.gserviceaccount.com --role roles/compute.networkAdmin

gcloud projects add-iam-policy-binding myansibleopenshift \
    --member serviceAccount:vm-instance-admin@myansibleopenshift.iam.gserviceaccount.com --role roles/iam.serviceAccountUser


Note: this process does not seem to work
to extract private key (pem) from .json file
brew install jq
cat gce-key.json | jq .private_key | tee temp.pem
chmod 400 temp.pem

once the VM is up,

ssh into the VM
yum install -y docker net-tools firewalld wget git httpd-tools patch
groupadd docker
usermod -aG docker burr
systemctl start docker
systemctl enable docker

