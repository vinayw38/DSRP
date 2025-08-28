# Resource block for creating SSO Permission Set
resource "aws_ssoadmin_permission_set" "permission_set" {
  name             = "${var.prefix}-${var.role_name}-${var.env}"
  description      = "This is a permission set deployed for - ${data.aws_identitystore_user.user_data.display_name}."
  instance_arn     = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  session_duration = "PT${var.session_duration}"
}

# Resource block for attaching Managed Policies to the Permission Set
resource "aws_ssoadmin_managed_policy_attachment" "managed_policy_attachment" {

  for_each = data.aws_iam_policy.aws_managed_policies

  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  managed_policy_arn = each.value["arn"]
  permission_set_arn = aws_ssoadmin_permission_set.permission_set.arn
}

# Resource block for attaching Inline Policy to the Permission Set (if provided)
resource "aws_ssoadmin_permission_set_inline_policy" "inline_policy" {

  count = length(jsondecode(var.inline_policy)) != 0 ? 1 : 0

  inline_policy      = var.inline_policy
  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.permission_set.arn
}

# Resource block for creating Account Assignments (User <-> Accounts <-> Permission Set mapping)
resource "aws_ssoadmin_account_assignment" "sso_acc_assignment" {

  for_each = toset(var.account_ids)

  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.permission_set.arn

  principal_id   = data.aws_identitystore_user.user_data.user_id
  principal_type = "USER"

  target_id   = each.value
  target_type = "AWS_ACCOUNT"

  depends_on = [data.aws_identitystore_user.user_data, aws_ssoadmin_permission_set.permission_set, aws_ssoadmin_managed_policy_attachment.managed_policy_attachment, aws_ssoadmin_permission_set_inline_policy.inline_policy]
}
