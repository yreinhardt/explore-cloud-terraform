# azure key vault
resource "azurerm_key_vault" "key_vault" {
  name                = var.kv_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name

  # Since access_policy can be configured both inline and via the separate azurerm_key_vault_access_policy resource, we have to explicitly set it to empty slice ([]) to remove it.
  access_policy = []

  dynamic "network_acls" {
    # skip blog if no acl is defined
    for_each = var.network_acl == null ? [] : [var.network_acl]

    content {
      bypass                     = network_acl.value.bypass
      default_action             = network_acl.value.default_action
      ip_rules                   = network_acl.value.ip_rules
      virtual_network_subnet_ids = network_acl.value.virtual_network_subnet_ids
    }
  }
}

# access policies
resource "azurerm_key_vault_access_policy" "access_policies" {
  # no conditional check, force to set access policiy
  for_each = var.secret_permissions

  key_vault_id       = azurerm_key_vault.key_vault.id
  tenant_id          = each.value.tenant_id
  object_id          = each.value.object_id
  secret_permissions = each.value.permissions

  depends_on = [
    azurerm_key_vault.key_vault
  ]
}

# secrets
resource "azurerm_key_vault_secret" "secrets" {
  # dont create resource if no secrets are available
  for_each = var.secrets == null ? {} : var.secrets

  key_vault_id = azurerm_key_vault.key_vault.id
  name         = each.key
  value        = each.value.value
  content_type = each.value.content_type

  depends_on = [
    azurerm_key_vault.key_vault,
    azurerm_key_vault_access_policy.access_policies
  ]
}
