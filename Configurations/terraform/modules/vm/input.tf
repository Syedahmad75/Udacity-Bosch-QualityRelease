
variable "packer_image" {
  default     = "/subscriptions/78edc3c6-6f4c-46b2-8fed-9503d6b80433/resourceGroups/udacityEnsureQualityReleaseRG/providers/Microsoft.Compute/images/packerImage-UdacityBosch"
}
variable "public_ip" {}
variable "resource_group" {
  default = "UdacityBoschQR-RG"
}
variable "location" {
  default = "westeurope"
}
variable "name" {
  default = "linux-vm"
}
variable "subnet_id" {}
variable "admin_username" {
  default     = "syedahmad75"
}
variable "public_key_path" {
  default     = "~/.ssh/id_rsa.pub"
}
variable "azurerm_network_interface" {
  default     = "Nic"
}
variable "suffix" {
  default     = "dev-westeurope-001"
}
variable "environment" {
  default     = "Dev"
}
variable "createdBy" {
  default     = "Syed Ahmad"
}
variable "managedBy" {
  default     = "Udacity Devops Team"
}
variable "purpose" {
  default     = "Web Server Deployment"
}
variable "colorBand" {
  default     = "Green"
}