locals {

  # Get all YAML files in the Dev roles directory
  files = fileset(path.root, "../Roles/Dev/*/*.yaml")

  # Parse YAML files and filter out expired roles
  roles = {
    for role_file in local.files :
    yamldecode(file(role_file))["Parameters"]["RoleName"]
    =>
    yamldecode(file(role_file))["Parameters"]
    if timecmp(
      format(
        "%sT%sZ",
        yamldecode(file(role_file))["Parameters"]["EndDate"],
        yamldecode(file(role_file))["Parameters"]["EndTime"]
      ),
      plantimestamp()
    ) >= 0
  }

  # Map role names to their corresponding inline policy JSON content, if the file exists
  inline_policy_map = {
    for role_file in local.files :
    yamldecode(file(role_file))["Parameters"]["RoleName"]
    =>
    fileexists(replace(role_file, "/config.yaml", "/inline_policy.json"))
    ?
    file(replace(role_file, "/config.yaml", "/inline_policy.json"))
    :
    null
  }

  # Combine role data with inline policy content
  data = {
    for role_name, role_data in local.roles :
    role_name
    =>
    local.inline_policy_map[role_name] != null
    ?
    merge(role_data, { "InlinePolicy" : local.inline_policy_map[role_name] })
    :
    merge(role_data, { "InlinePolicy" : jsonencode({}) })
  }

  # Create a map of user to role assignment details for output
  ps_map = {
    for role_name, role_data in local.data : role_data["UserList"][0] => {
      (role_name) = {
        expiry   = formatdate("DD MMM YYYY hh:mm ZZZ", format("%sT%sZ", role_data["EndDate"], role_data["EndTime"])),
        accounts = role_data["AccountIds"]
      }
    }...
  }
}

# Deploy SSO assignments for each role in the dev_data map
module "sso_assignment" {
  source = "../modules/"

  for_each = local.data

  env              = var.prefix
  prefix           = var.prefix
  user_name        = each.value["UserList"][0]
  managed_policies = each.value["ManagedPolicies"]
  account_ids      = each.value["AccountIds"]
  role_name        = each.key
  session_duration = contains(keys(each.value), "SsoSessionDuration") ? each.value["SsoSessionDuration"] : "4H"
  inline_policy    = each.value["InlinePolicy"]

  allow_admin_access = var.allow_admin_access
}
