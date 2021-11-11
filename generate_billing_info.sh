#Created by: Indranil Pal
#Created Date: 11-11-2021

#Variable
export PROJECT_ID=$DEVSHELL_PROJECT_ID
export LOCATION=us
export DATASET=GCP_Billing

#set the project
gcloud config set project $PROJECT_ID

#enable the bigquery api
#gcloud services list | grep bigquery
gcloud services enable bigquery.googleapis.com
gcloud services enable bigquerystorage.googleapis.com
gcloud services enable bigquerystorage.googleapis.com
echo "Bigquery API has been enabled"

#Bigquery dataset creation
if [[ $(bq ls | grep $DATASET) ]]
then
  echo "dataset already created"
else
  echo "dataset is being created"
  bq --location=$LOCATION mk --dataset $PROJECT_ID:$DATASET
fi
#bq rm -r -f $DEVSHELL_PROJECT_ID:GCP_Billing
#bq mk --table --expiration 36000 $DEVSHELL_PROJECT_ID:GCP_Billing.test_table
SELECT * FROM `poc01-330806.GCP_Billing.gcp_billing_export_resource_v1_01F748_D68B6C_7BFEF3` WHERE DATE(_PARTITIONTIME) = "2021-11-11"

