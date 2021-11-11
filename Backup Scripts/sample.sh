#Creted By: Indranil Pal
#Created Date: 10-11-2021 
#Modified By:
#Modified Date:
#Ref: https://cloud.google.com/blog/products/it-ops/filtering-and-formatting-fun-with

#-------------------------------------------------------------------------------------------
echo "Script is running...Please wait..."

#Dynamic Filename Generated
_now=$(date +"%m_%d_%Y")
_filename="output_$_now.csv"
#echo "$_filename"

#Delete the file if exists
#-f checks if it's a regular file and -e checks if the file exist
#if [ -fe $_filename ]; then rm $_filename; fi 
if [ $( ls $_filename ) ]; then rm $_filename; fi 
#-------------------------------------------------------------------------------------------

#Variables
export PROJECT_ID=$DEVSHELL_PROJECT_ID
#export LOCATION=us-central1


#Account has been set
#gcloud auth login
#gcloud config set account $ACCOUNT_ID

#Project has been set
gcloud config set project "$PROJECT_ID"

#Logged in Account details
_output=`gcloud info --format="value(config.account)"`
echo "Logged in by: $_output and PROJECT_ID is: $PROJECT_ID" >> $_filename



#Project Details
echo "------------------------------------------------------------------------------------" >> $_filename
_output=`gcloud projects describe $PROJECT_ID --format="value[separator=';'](name,projectId,projectNumber,lifecycleState)"`
echo "Project Details" >> $_filename
echo "name;projectId;projectNumber;lifecycleState" >> $_filename
echo "$_output" >> $_filename
echo "" >> $_filename
echo "------------------------------------------------------------------------------------" >> $_filename


#Services Details
echo "------------------------------------------------------------------------------------" >> $_filename
_output=`gcloud services list --enabled | wc -l`
echo "Services Details" >> $_filename
echo "Total count of enabled services: $_output" >> $_filename
_output=`gcloud services list --enabled --project $PROJECT_ID --format="value[separator=';'](config.name,config.title,state)"`
echo "name;title;state" >> $_filename
echo "$_output" >> $_filename
echo "" >> $_filename
echo "------------------------------------------------------------------------------------" >> $_filename


#VPC, Subnet, Firewall
echo "------------------------------------------------------------------------------------" >> $_filename
#_output=`gcloud compute networks list --format="value[separator=';'](name)"`
#_output=`gcloud compute networks describe $_output --format="value[separator=';'](name,description,creationTimestamp,autoCreateSubnetworks)"`
#echo "name;description;creationTimestamp;autoCreateSubnetworks" >> $_filename
#echo "$_output" >> $_filename
#echo "" >> $_filename

#_output=`gcloud compute networks peerings list`
#_output=`gcloud compute shared-vpc list-associated-resources $DEVSHELL_PROJECT_ID`

_output=`gcloud compute networks subnets list --format="value[separator=';'](network,REGION,name,RANGE)"`
echo "vpc_network;region;subnet;ip_range" >> $_filename
echo "$_output" >> $_filename
echo "" >> $_filename

_output=`gcloud compute firewall-rules list --format="value[separator=';'](NAME,NETWORK,DIRECTION,PRIORITY,ALLOW,DENY,DISABLED)"`
echo "NAME;NETWORK;DIRECTION;PRIORITY;ALLOW;DENY;DISABLED" >> $_filename
echo "$_output" >> $_filename
echo "" >> $_filename
echo "------------------------------------------------------------------------------------" >> $_filename


#VM Instance LIST
echo "------------------------------------------------------------------------------------" >> $_filename
#gcloud compute instances list --format="csv(name;zone;status)"
_output=`gcloud compute instances list --format="value[separator=';'](name,zone,status)"`
echo "name;zone;status" >> $_filename
echo "$_output" >> $_filename
echo "" >> $_filename
echo "------------------------------------------------------------------------------------" >> $_filename


export IAM_SA_LIST=`gcloud iam service-accounts list`
echo "$IAM_SA_LIST" >> $_filename
echo "" >> $_filename

#Composer Environment List
#export COMPOSER_ENV_LIST=`gcloud composer environments list --locations $LOCATION`
#echo "$COMPOSER_ENV_LIST" >> $_filename
#echo "" >> $_filename


#gcloud projects get-iam-policy $PROJECT --flatten="bindings[].members" --format="table(bindings.members)" --filter="bindings.role:$ROLE"
#export LIST=`gcloud projects get-iam-policy "$PROJECT_ID" --flatten="bindings[].members" --format='table(bindings.members)'`
#_output=`gcloud projects get-iam-policy "$PROJECT_ID" --flatten="bindings[].members" --format='table(bindings.members)'`
#echo "members" >> $_filename
#echo "$_output" >> $_filename
#echo "" >> $_filename



#gcloud projects list
echo "------------------------------------------------------------------------------------" >> $_filename
for project in  $(gcloud projects list --format="csv[no-heading](projectId)") 
do
  gcloud config set project $project
  _account=`gcloud info --format="value(config.account)"`
  echo "ProjectId:  $project" >> $_filename
  echo "Logged in by: $_account" >> $_filename
  
  echo "------------------------------" >> $_filename
  for sa in $(gcloud beta iam service-accounts list --project $project --format="csv[no-heading](email)") 
  do
    echo "    -> service-accounts: $sa" >> $_filename
  done
  echo "------------------------------" >> $_filename
  for subnet in $(gcloud compute networks subnets list --format="csv[separator=';'](network:label='VPC',REGION,name:label='Subnet',RANGE)")
  do
    IFS=';' read -r -a subnetArray<<< "$subnet"
	_region="${subnetArray[1]}"
	
    echo "    -> subnet: $subnet" >> $_filename
	for composer in $(gcloud composer environments list --locations $_region --format="csv[separator=';'](name:label='composer_env',LOCATION,state,create_time)")
	do
	  echo "      -> composer-env: $composer" >> $_filename
	done
  done
  echo "------------------------------" >> $_filename
  for firewall in $(gcloud compute firewall-rules list --format="csv[separator=';'](NAME,NETWORK,DIRECTION,PRIORITY,ALLOW,DENY,DISABLED)")
  do
    echo "    -> firewall: $firewall" >> $_filename
  done
  echo "------------------------------" >> $_filename
  for vm in $(gcloud compute instances list --format="csv[separator=';'](name,zone,status)")
  do
    echo "    -> compute-instances: $vm" >> $_filename
  done
  echo "------------------------------" >> $_filename
  #for gcs in $()
  #do
  #  echo "    -> cloud-storage: $gcs" >> $_filename
  #done
  echo "------------------------------" >> $_filename
done
echo "------------------------------------------------------------------------------------" >> $_filename


echo "------------------------------------------------------------------------------------" >> $_filename
echo "Script is running...Please wait..."
echo "Thanks, output file generated: $_filename"


