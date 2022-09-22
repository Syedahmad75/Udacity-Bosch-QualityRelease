provider "azurerm" {
  subscription_id = "78edc3c6-6f4c-46b2-8fed-9503d6b80433"
  client_id = "c81093a9-ea0a-411d-8b82-a88e48268117"
  client_secret = "hKX8Q~SVPDa9yZxkkN4A0X4IRZoBwMndCC6d3a0U"
  tenant_id = "2eb22f58-b36a-47c8-b690-66fc8cc59a0b"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tfstate464486048"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "mYGa4YvYeUx8uQxc9H5U+jFNCNPVknzBOuX6lSSFsY+9Pvn85S8Fjo/jVGbQA4ETr0J3TCz3lbGg+AStwp6d3w=="
  }
}
module "resource_group" {
  source               = "./modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}
module "network" {
  source               = "./modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "NET"
  resource_group       = "${module.resource_group.resource_group_name}"
  address_prefix_test  = "${var.address_prefix_test}"
}

module "nsg-test" {
  source           = "./modules/networksecuritygroup"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "NSG"
  resource_group   = "${module.resource_group.resource_group_name}"
  subnet_id        = "${module.network.subnet_id_test}"
  address_prefix_test = "${var.address_prefix_test}"
}
module "appservice" {
  source           = "./modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group   = "${module.resource_group.resource_group_name}"
}
module "publicip" {
  source           = "./modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "publicip"
  resource_group   = "${module.resource_group.resource_group_name}"
}
module "vm" {
  source          = "./modules/vm"
  name            = "vm-test-automation"
  location        = var.location
  subnet_id       = module.network.subnet_id_test
  resource_group  = module.resource_group.resource_group_name
  public_ip       = module.publicip.public_ip_address_id
  #admin_username  = "${var.admin_username}"
  #packer_image    = "${var.packer_image}"
  #public_key_path = "${var.public_key_path}"
}