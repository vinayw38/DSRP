# Check block to ensure AdministratorAccess is not included in managed policies when allow_admin_access is false
check "no_admin_access_when_validation_enabled" {
  assert {
    condition     = var.allow_admin_access || !contains(var.managed_policies, "AdministratorAccess")
    error_message = "AdministratorAccess is not allowed when allow_admin_access is false."
  }
}