# Resource Group/Location
variable "location" {
    default= "westeurope"
}
variable "application_type" {
    default= "dev-westeurope-001"
}
variable "resource_type" {
    default= "nsg"
}
variable "resource_group" {
    default= "UdacityBoschQR-RG"
}
variable "subnet_id" {
   # default= "azurerm_subnet.test.id"
}
variable "address_prefix_test" {
    default= "*"
}
