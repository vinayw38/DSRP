# Output User <-> Permissions Set Map for Dev Org.
output "ps_map" {
  value       = local.ps_map
  description = "Map of user to role assignment in the Org."
}