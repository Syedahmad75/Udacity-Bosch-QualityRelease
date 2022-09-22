az login

#Get the ID of the active Subscription
$subscriptionID = $(az account show --query id -o tsv)

#Set the ID of active subscription
az account set --subscription $subscriptionID

#Show the Subscription 
az account show