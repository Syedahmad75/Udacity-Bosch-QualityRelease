# Azure GUIDS
variable "subscription_id" {
    default= "78edc3c6-6f4c-46b2-8fed-9503d6b80433"
}
variable "client_id" {
    default= "5d4e8aac-bae9-43d7-a77a-6de37ab5ce90"
}
variable "client_secret" {
    default= "W6M8Q~Q816dU49oqQpHbi1NmCaE57gDNe.QgKaKy"
}
variable "tenant_id" {
    default= "2eb22f58-b36a-47c8-b690-66fc8cc59a0b"
}

# Resource Group/Location
variable "location" {
    default= "westeurope"
}
variable "resource_group" {
    default= "UdacityBoschQR-RG"
}
variable "application_type" {
    default= "dev-westeurope-001"
}

# Network
variable virtual_network_name {
    default= "vnet"
}
variable address_prefix_test {
    default= ["10.0.2.0/24"]
}
variable address_space {
    default= ["10.0.0.0/16"]
}

