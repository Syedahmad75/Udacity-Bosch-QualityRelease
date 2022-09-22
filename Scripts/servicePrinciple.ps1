$servicePrincipalName = "servicePrincpleUdacity"
$roleName = "contributor"
$subscriptionID = $(az account show --query id -o tsv)
# Verify the ID of the active subscription
Write-Output "Using subscription ID $subscriptionID"
#$resourceGroup = "udacityEnsureQualityReleaseRG"

Write-Output "Creating SP for RBAC with name $servicePrincipalName, with role $roleName and in scopes /subscriptions/$subscriptionID"

#Set Environment Variables to Null
$Env:ARM_SUBSCRIPTION_ID = $null
$Env:ARM_CLIENT_ID = $null
$Env:ARM_CLIENT_SECRET = $null
$Env:ARM_TENANT_ID = $null

#Create Service Principle and parse into Json values
$servicePrincipalDetails = az ad sp create-for-rbac -n $servicePrincipalName --role $roleName --scopes /subscriptions/$subscriptionID --query "{client_id: appId, client_secret: password, tenant_id: tenant, display_Name: displayName}" | ConvertFrom-Json

#Get Secret Values from the command and dump into the variables and then store in the environment variables.
$Env:ARM_SUBSCRIPTION_ID = $subscriptionID
$Env:ARM_CLIENT_ID = $servicePrincipalDetails.client_id
$Env:ARM_CLIENT_SECRET = $servicePrincipalDetails.client_secret
$Env:ARM_TENANT_ID = $servicePrincipalDetails.tenant_id