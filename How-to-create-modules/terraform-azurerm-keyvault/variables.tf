variable "location" {
  type        = string
  default     = "westeurope"
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "kv_name" {
  type        = string
  description = "Specifies the name of the Key Vault. Changing this forces a new resource to be created. The name must be globally unique. If the vault is in a recoverable state then the vault will need to be purged before reusing the name."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
}

variable "tenant_id" {
  type        = string
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
}

variable "sku_name" {
  type        = string
  default     = "standard"
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
}

variable "network_acl" {
  type = object({
    bypass                     = optional(string, "None") # required
    default_action             = optional(string, "Deny") # required
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  default     = null
  description = "A network_acl (access control lists) block consisting of: bypass (required), default_action (required), ip_rules (Optional), virtual_network_subnet_ids (Optional). https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault "
}

variable "secret_permissions" {
  type = map(object({
    tenant_id   = string
    object_id   = string
    permissions = list(string)
  }))
  description = "List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set."
}

variable "secrets" {
  type = map(object({
    value        = string
    content_type = optional(string, "text/plain")
  }))
  description = "Azure Key Vault secrets"
  default     = null
}
