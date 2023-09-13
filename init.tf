terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
    }
    local = {
      source = "hashicorp/local"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

locals {
  azure_auth = jsondecode(file("${path.module}/azure_key.json"))
}

provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion     = true
      graceful_shutdown              = false
      skip_shutdown_and_force_delete = true
    }
  }
  client_id       = local.azure_auth.appId
  client_secret   = local.azure_auth.password
  tenant_id       = local.azure_auth.tenantId
  subscription_id = local.azure_auth.subscriptionId
}
