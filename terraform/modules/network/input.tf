# Resource Group
variable resource_group {
    default= "UdacityBoschQR-RG"
}
variable location {
    default= "westeurope"
}

# Network
variable virtual_network_name {
    default= "vnet"
}
variable address_space {
    default= ["10.0.0.0/16"]
}
variable "application_type" {
    default= "dev-westeurope-001"
}
variable "resource_type" {
    default= "vnet"
}
variable "address_prefix_test" {
    default= ["10.0.2.0/24"]
}

