variable "TFE_HOST" {}
variable "TFE_ORG" {}
variable "TFE_TOKEN" {}

data "terraform_remote_state" "rstate" {
  backend = "remote"
  config = {
#     hostname     = "${var.TFE_HOST}"
    organization = "${var.TFE_ORG}"
    token        = "${var.TFE_TOKEN}"
    workspaces = {
      name = "tfe-remote-parent"
    }
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.62.1"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "child_01" {
  name                = "child_01_network"
  resource_group_name = data.terraform_remote_state.rstate.outputs.azure_resource_group_name
  location            = data.terraform_remote_state.rstate.outputs.azure_resource_group_location
  address_space       = ["10.0.0.0/16"]
}
