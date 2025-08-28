terraform {
  required_version = "~> 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    ######################################
    #  Use Vault provider if needed for  #
    #  secrets management or for         #
    #  getting AWS Creds from Vault      #
    #  Uncomment if using Vault          #
    ######################################
    #
    # vault = {
    #   source  = "hashicorp/vault"
    #   version = "~> 3.20.0" # or latest stable
    # }
    # -*-
  }
}