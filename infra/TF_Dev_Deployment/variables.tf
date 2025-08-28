#################################
#  AWS Configuration Variables  #
#################################
variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
}

# -*-


#######################################
#  Vault Configuration Variables      #
#  Uncomment the below variables if   #
#  you are using Vault for AWS creds  #
#######################################
#
# variable "vault_address" {
#   description = "Vault server URL"
#   type        = string
# }
#
# variable "vault_auth_method" {
#   description = "Vault auth method to use: token, approle, or userpass"
#   type        = string
# }
#
# # Token-based auth
# variable "vault_token" {
#   description = "Vault token for token auth"
#   type        = string
#   default     = null
# }
#
# # AppRole auth
# variable "vault_approle_role_id" {
#   description = "AppRole Role ID"
#   type        = string
#   default     = null
# }
#
# variable "vault_approle_secret_id" {
#   description = "AppRole Secret ID"
#   type        = string
#   default     = null
# }
#
# # Username/password auth
# variable "vault_username" {
#   description = "Vault username (for userpass auth)"
#   type        = string
#   default     = null
# }
#
# variable "vault_password" {
#   description = "Vault password (for userpass auth)"
#   type        = string
#   default     = null
# }
#
# variable "vault_aws_backend" {
#   description = "Vault AWS secret engine mount path (e.g. 'aws')"
#   type        = string
# }
#
# variable "vault_aws_role" {
#   description = "Vault role mapped to IAM permissions"
#   type        = string
# }
#
# -*-

########################################
#  Automation Configuration Variables  #
########################################

variable "prefix" {
  description = "Prefix for all resources created"
  type        = string
  default     = "dsrp"
}

variable "env" {
  description = "Environment suffix for resources (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "allow_admin_access" {
  type        = bool
  description = "Boolean variable to allow or disallow Administrator Access Policy."
  default     = false
}

# -*-
