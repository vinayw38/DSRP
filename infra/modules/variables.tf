########################################
#  Automation Configuration Variables  #
########################################

variable "env" {
  type        = string
  description = "Variable to be added as a suffix to resource names."
  default     = "dev"
}

variable "prefix" {
  type        = string
  description = "Prefix to be added to resource names."
  default     = "dsrp"
}

variable "user_name" {
  type        = string
  description = "Email id of the User, who needs to be granted access via AWS IAM Identity Center."

  validation {
    condition     = length(var.user_name) > 0
    error_message = "User Name cannot be empty."
  }
}

variable "allow_admin_access" {
  type        = bool
  description = "Boolean variable to allow or disallow Administrator Access Policy."
  default     = false
}

variable "managed_policies" {
  type        = list(string)
  description = "List of Managed Policies to be attached to the Permission Set."

  validation {
    condition     = length(var.managed_policies) > 0 && length(var.managed_policies) <= 10
    error_message = "Managed Policies List can neither be empty nor exceed 10 policies."
  }
}

variable "account_ids" {
  type        = list(string)
  description = "List of Account IDs to be attached to the Permission Set."

  validation {
    condition     = length(var.account_ids) > 0
    error_message = "Account IDs List cannot be empty."
  }
  validation {
    condition     = alltrue([for i in var.account_ids : can(regex("^[0-9]{12}$", i))])
    error_message = "Account IDs should be 12 digit numbers."
  }
}

variable "role_name" {
  type        = string
  description = "Name of the Permission to be created within AWS IAM Identity Center."

  validation {
    condition     = length(var.role_name) > 0
    error_message = "Role Name cannot be empty."
  }
}

variable "inline_policy" {
  type        = string
  description = "Inline policy to be attached to the Permission Set."
}

variable "session_duration" {
  type        = string
  description = "Session Duration for the Permission Set."
  default     = "4H"

  validation {
    condition     = can(regex("^[0-9]+[H]$", var.session_duration)) && tonumber(regex("^[0-9]+", var.session_duration)) <= 12 && tonumber(regex("^[0-9]+", var.session_duration)) > 0
    error_message = "Session duration should be in the format of '4H' and the duration should be between 0 to 12 hours."
  }
}
