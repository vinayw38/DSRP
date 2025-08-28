## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssoadmin_account_assignment.sso_acc_assignment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_ssoadmin_managed_policy_attachment.managed_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_managed_policy_attachment) | resource |
| [aws_ssoadmin_permission_set.permission_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set) | resource |
| [aws_ssoadmin_permission_set_inline_policy.inline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set_inline_policy) | resource |
| [aws_iam_policy.aws_managed_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_identitystore_user.user_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/identitystore_user) | data source |
| [aws_ssoadmin_instances.sso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_ids"></a> [account\_ids](#input\_account\_ids) | List of Account IDs to be attached to the Permission Set. | `list(string)` | n/a | yes |
| <a name="input_allow_admin_access"></a> [allow\_admin\_access](#input\_allow\_admin\_access) | Boolean variable to allow or disallow Administrator Access Policy. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | Variable to be added as a suffix to resource names. | `string` | `"dev"` | no |
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | Inline policy to be attached to the Permission Set. | `string` | n/a | yes |
| <a name="input_managed_policies"></a> [managed\_policies](#input\_managed\_policies) | List of Managed Policies to be attached to the Permission Set. | `list(string)` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to be added to resource names. | `string` | `"dsrp"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the Permission to be created within AWS IAM Identity Center. | `string` | n/a | yes |
| <a name="input_session_duration"></a> [session\_duration](#input\_session\_duration) | Session Duration for the Permission Set. | `string` | `"4H"` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | Email id of the User, who needs to be granted access via AWS IAM Identity Center. | `string` | n/a | yes |

## Outputs

No outputs.
