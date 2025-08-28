# Data Source for AWS SSO Admin Instances
data "aws_ssoadmin_instances" "sso" {}

# Data Source for AWS Identity Store User
data "aws_identitystore_user" "user_data" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.sso.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = var.user_name
    }
  }
}

# Data Source for AWS Managed Policies
data "aws_iam_policy" "aws_managed_policies" {
  for_each = toset(var.managed_policies)
  name     = each.value
}
