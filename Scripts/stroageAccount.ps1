$RESOURCE_GROUP_NAME='tfstate'
$STORAGE_ACCOUNT_NAME="tfstate$(Get-Random)"
$CONTAINER_NAME='tfstate'
$Location = 'westeurope'

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $Location

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# Get Access Account Key and Store it in the Environment Variable as well
$ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
$env:ARM_ACCESS_KEY=$ACCOUNT_KEY

#Output the values
Write-Host "Storage Account Name: $STORAGE_ACCOUNT_NAME"
Write-Host "Container Name: $CONTAINER_NAME"
Write-Host "Access Account Key: $ACCOUNT_KEY"

