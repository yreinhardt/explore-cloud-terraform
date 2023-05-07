resource "random_id" "id" {
  byte_length = 4
}


locals {
  id          = random_id.id.hex
  namespace   = var.namespace
  environment = var.environment
  name        = var.name
  delimiter   = var.delimiter

  label_result = lower(format("%s%s%s%s%s%s%s", local.namespace, local.delimiter, local.name, local.delimiter, local.environment, local.delimiter, local.id))
}
