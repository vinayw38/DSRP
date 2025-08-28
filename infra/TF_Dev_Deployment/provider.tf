### <--*  AWS Provider Block  *-->

#############################################################################################
#  Comment or remove the below block if you are using Vault for AWS credentials management  #
#############################################################################################
provider "aws" {
  region = var.aws_region
}
# -*-

###############################################################################################
#  AWS Provider Block with Vault                                                              #
#  This setup assumes you are using HashiCorp Vault to manage AWS credentials dynamically     #
#  Ensure you have the Vault provider configured in your Terraform setup                      #
#  Vault provider block with dynamic auth method selection (Token, AppRole, Userpass)         #
#  Uncomment the below block if you want to use Vault for AWS credentials management          #
###############################################################################################
#
# provider "vault" {
#   address = var.vault_address
#
#   # Use direct token if provided
#   token = var.vault_auth_method == "token" ? var.vault_token : null
#
#   # AppRole auth
#   auth_login {
#     path = "auth/${var.vault_auth_method}/login" # e.g., "auth/approle/login"
#     parameters = var.vault_auth_method == "approle" ? {
#       role_id   = var.vault_approle_role_id
#       secret_id = var.vault_approle_secret_id
#     } : null
#   }
#
#   # Userpass auth
#   auth_login {
#     path = "auth/${var.vault_auth_method}/login/${var.vault_username}" # e.g., "auth/userpass/login/vinay"
#     parameters = var.vault_auth_method == "userpass" ? {
#       password = var.vault_password
#     } : null
#   }
# }
#
# data "vault_aws_access_credentials" "creds" {
#   backend = var.vault_aws_backend
#   role    = var.vault_aws_role
# }
#
# provider "aws" {
#   region     = var.aws_region
#   access_key = data.vault_aws_access_credentials.creds.access_key
#   secret_key = data.vault_aws_access_credentials.creds.secret_key
#   token      = data.vault_aws_access_credentials.creds.security_token
# }
#
# -*-