# Output User <-> Permissions Set Map for Dev Org.
output "dev_ps_map" {
  value       = local.dev_ps_map
  description = "Map of user to role assignment in Dev Org."
}