output "kv_id" {
  value = azurerm_key_vault.key_vault.id
}

output "kv_uri" {
  value = azurerm_key_vault.key_vault.vault_uri
}
