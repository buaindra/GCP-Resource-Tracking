# GCP-Resource-Tracking
This repo I am creating, to easily track the GCP Resources. It can be project details, VMs, Bucket details, Bigquery tables etc.

#Ref site-
1. Gcloud Bash Script: https://cloud.google.com/blog/products/it-ops/filtering-and-formatting-fun-with
2. Billing data export to Bigquery: https://cloud.google.com/billing/docs/how-to/export-data-bigquery-tables
3. Cloud SDK-Command Line Interface: https://cloud.google.com/sdk/gcloud/reference/alpha/bq/tables/list

#Pre-requisite
1. Make sure, you have atleast viewer role in GCP Console.
2. Project should be linked with billing account to list down some resources.

#Step by step process to track the GCP Resource Tracking
1. Connect with the CloudShell from your GCP Console
2. Authorize the cloudshell to perform/execute/make GCP API Call: (**$ gcloud auth list**)
3. Download the script file (GCP_Resource_Tracking_Bash_Script.sh) from GIT: (**$ git clone https://github.com/buaindra/GCP-Resource-Tracking.git**)
5. Then, execute the bash script: (**$ bash <location_path>/GCP-Resource-Tracking/GCP_Resource_Tracking_Bash_Script.sh**)
6. Wait for sometime, you will get message that, 1 output_mm_dd_yyyy.csv file.
7. ![image](https://user-images.githubusercontent.com/46111257/141246857-8ba1cde1-b36a-4a40-bd63-6f26909483e1.png)
8. ![image](https://user-images.githubusercontent.com/46111257/141247242-2c5b9c28-75fb-47c8-bb77-b77868b33f58.png)
9. Open the file via nano, vim editor or download from cloudshell machine.

