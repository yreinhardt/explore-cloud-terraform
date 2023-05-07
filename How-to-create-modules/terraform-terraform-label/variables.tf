variable "environment" {
  type        = string
  description = "The name of the environment."

  validation {
    condition     = contains(["dev", "stg", "prod"], var.environment)
    error_message = "Provide a correct environment value (dev, stg or prod)."
  }
}

variable "delimiter" {
  type        = string
  description = "The delimiter."
}

variable "name" {
  type        = string
  description = "The Resourcename."
}

variable "namespace" {
  type        = string
  description = "Namespace of project."
}
