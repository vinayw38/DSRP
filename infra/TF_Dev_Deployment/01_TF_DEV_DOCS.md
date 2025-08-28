## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sso_assignment"></a> [sso\_assignment](#module\_sso\_assignment) | ../modules/ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_admin_access"></a> [allow\_admin\_access](#input\_allow\_admin\_access) | Boolean variable to allow or disallow Administrator Access Policy. | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy into | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment suffix for resources (e.g., dev, prod) | `string` | `"dev"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resources created | `string` | `"dsrp"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dev_ps_map"></a> [dev\_ps\_map](#output\_dev\_ps\_map) | Map of user to role assignment in Dev Org. |
