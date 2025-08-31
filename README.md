# Dynamic SSO Role Provisioning for AWS IAM Identity Center  

This repository provides a reference implementation for automating time-bound AWS IAM Identity Center (SSO) role provisioning using YAML role definitions, Terraform workflows, and CI/CD pipelines.  

The goal is to reduce operational overhead and improve security by ensuring that elevated privileges are granted dynamically and revoked automatically after expiry.  

---

## Medium Blog Post
For a detailed explanation of the concepts and implementation, please refer to the accompanying Medium blog post:
[Dynamic SSO Role Provisioning for AWS IAM Identity Center](https://medium.com/@yourusername/dynamic-sso-role-provisioning-for-aws-iam-identity-center-1234567890ab)

---

## Repository Structure
```plaintext
.
├── .github/                            # GitHub repository configuration
│   └── workflows/                      # GitHub Actions pipeline for automation
│       └── terraform-apply.yml         # GitHub Actions workflow file (for main branch - running terraform plan and apply)
│       └── terraform-plan.yml          # GitHub Actions workflow file (for pull requests - just running terraform plan))
├── infra/                     
│   ├── modules/                        # Reusable Terraform module
│   ├── Roles/                          # YAML role definitions
│   │   └── Dev/                        # Development roles
│   │       ├── Sample_Role_1/          # Example role definition 1 (without inline policy)
│   │       │   └── config.yaml         # YAML configuration for Sample_Role_1
│   │       └── Sample_Role_2/          # Example role definition 2 (with inline policy)
│   │           └── config.yaml         # YAML configuration for Sample_Role_2
│   │           └── inline_policy.json  # Inline policy for Sample_Role_2
│   └── TF_Dev_deployment/              # Example Terraform workflow (invoking the above module)
├── .gitignore                          # Git ignore file
└── README.md                           # This file
```

---

## Getting Started

### Prerequisites
- AWS IAM Identity Center configured
- Terraform v1.5+

### Setup
Clone this repository :-

```bash
git clone git@github.com:vinayw38/DSRP.git
cd DSRP/infra/
```

### Define Roles
Create your role definitions in the `Roles/` directory using the provided YAML structure. 
You can refer to the sample roles for guidance or use them instead.

Below would be the parameters you can define in the `config.yaml` file:

```yaml
Parameters:
  EndTime: "23:59:59"                               # UTC, HH:mm:SS
  EndDate: "2024-06-16"                             # YYYY-MM-DD
  AccountIds: ["123456789012", "098765432109"]      # List of AWS Account IDs
  SsoSessionDuration: "6H"                          # Session duration of the role. Format: 1H, 2H, ..., 12H
  RoleName: "sample-role-1"                         # Name of the role to be created in AWS IAM Identity Center
  UserList: ['<<user_email_addr>>']                 # List of user email addresses to be assigned this role. Currently, supports ony 1 user.
  ManagedPolicies: ['AWSOrganizationsFullAccess']   # List of AWS Managed Policies to attach to the role
```

Below is how to define an inline policy in a JSON file (optional):

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::sample-bucket-*"
        }
    ]
}

```

> **Note:** 
> 1. If you want to attach an inline policy, create a JSON file in the same directory as the `config.yaml` and reference it in the YAML file.
> 2. Ensure that the `EndTime` and `EndDate` are in UTC format.
> 3. The `UserList` currently supports only one user email address. It is formated as a list to allow for future enhancements.
> 4. Each `RoleName` must be unique within the AWS IAM Identity Center instance. To distinguish roles provisioned by this automation, a predefined automation prefix is automatically added to the role name.
> 5. The `ManagedPolicies` should be valid AWS Managed Policy names and a maximum of 10 can be attached to a role.
> 6. For fainer control over permissions, consider using inline policies.
> 7. `SsoSessionDuration` - The session duration defines how long a user can stay logged in during a single session and is not the same as the role expiry time. For more details, refer to the [Terraform Registry documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set#session_duration-1).

### Deploy Roles
You can use the provided example Terraform workflow in the `TF_Dev_deployment/` directory to deploy the roles. 
Make sure to update the provider configuration with your AWS IAM Identity Center instance ARN.

You can use the default aws provider configuration as shown below by replacing the region parameter.
```hcl
provider "aws" {
  region = "us-west-2"  # Replace with your desired region
}
```
Or, you can use aws login via vault or any other method of your choice.

Make sure to update the backend configuration to use your desired backend (S3, local, etc.).

Initialize Terraform and apply the configuration:

```bash
cd TF_Dev_deployment/
terraform init
terraform validate
terraform plan
terraform apply
```


### CI/CD Integration

This repository includes GitHub Actions workflows to automate the deployment process.
- `terraform-plan.yml`: Runs on pull requests to validate the Terraform code and show a plan.
- `terraform-apply.yml`: Runs on pushes to the main branch to apply the Terraform changes

Make sure to set up the necessary secrets in your GitHub repository for AWS credentials.
Refer to the workflow files for more details on the steps involved.


### Cleanup

To remove the provisioned roles, simply run `terraform destroy` in the `TF_Dev_deployment/` directory.

```bash
terraform destroy
```

---
## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

---


---
Thanks for checking out this repository! If you found it useful, please consider starring it.

> **Vinay Wupadhrasta** - [GitHub](https://github.com/vinayw38) | [LinkedIn](https://www.linkedin.com/in/vinay-wupadhrasta-3a7052143/) | [Medium](https://medium.com/@wvinay38) <br>
> Cloud Automation Engineer | DevOps Enthusiast