
locals {
  namespace   = "foo"
  environment = "dev"
  delimiter   = "-"
  name_rg     = "rg"
  name_kv     = "kv"
  location    = "westeurope"
}

module "rg_label" {
  source      = "git@github.com-yreinhardt:yreinhardt/terraform-terraform-label.git?ref=v1.0.0"
  namespace   = local.namespace
  environment = local.environment
  name        = local.name_rg
  delimiter   = local.delimiter
}

module "kv_label" {
  source      = "git@github.com-yreinhardt:yreinhardt/terraform-terraform-label.git?ref=v1.0.0"
  namespace   = local.namespace
  environment = local.environment
  name        = local.name_kv
  delimiter   = local.delimiter
}

resource "azurerm_resource_group" "rg" {
  name     = module.rg_label.label_result
  location = local.location
}

# access azurerm provider configuration (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config)
data "azurerm_client_config" "current" {}


module "key_vault_dev" {
  source = "../"

  kv_name             = module.kv_label.label_result
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # set permissions here
  secret_permissions = {
    admin = {
      tenant_id   = "<TENANT ID>"
      object_id   = "<OBJECT ID>"
      permissions = ["Get", "List", "Backup", "Delete", "Purge", "Recover", "Restore", "Set"]
    },
    readers = {
      tenant_id   = "<TENANT ID>"
      object_id   = "<OBJECT ID>"
      permissions = ["Get", "List"]
    }
  }

  # set secrets here (don't store secrets in plain text in source control)
  secrets = {
    myFirstSecret = {
      value        = "your first secret"
      content_type = "text/plain"
    },
    mySecondSecret = {
      value = "your second secret"
      # content_type = "text/plain"
    }
  }

}
