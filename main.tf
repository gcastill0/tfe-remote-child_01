variable "TFE_HOST" {}
variable "TFE_ORG" {}
variable "TFE_TOKEN" {}

data "terraform_remote_state" "rstate" {
  backend = "remote"
  config = {
    hostname     = "${var.TFE_HOST}"
    organization = "${var.TFE_ORG}"
    token        = "${var.TFE_TOKEN}"
    workspaces = {
      name = "tfe-remote-parent"
    }
  }
}

# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.38.0"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "child_01" {
  name                = "child_01_network"
  resource_group_name = data.terraform_remote_state.rstate.outputs.azure_resource_group_name
  location            = data.terraform_remote_state.rstate.outputs.azure_resource_group_location
  address_space       = ["10.0.0.0/16"]
}
