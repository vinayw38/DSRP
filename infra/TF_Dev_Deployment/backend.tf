### <--*  Configure the backend for storing Terraform state         *-->
### <--*  Uncomment and configure one of the backend options below  *-->

terraform {
  ###########################################################
  #  *** Remote Backend via Terraform Cloud/Enterprise ***  #
  ###########################################################
  #
  # backend "remote" {
  #   hostname     = "app.terraform.io"         # or your custom hostname
  #   organization = "org-name"                 # your Terraform Cloud/Enterprise organization name
  #
  #   workspaces {
  #     name = "workspace-name"                 # your workspace name
  #   }
  # }
  #
  # -*-

  #############################################
  #  *** S3 + DynamoDB Backend (for AWS) ***  #
  #############################################
  #
  # backend "s3" {
  #   bucket         = "your-s3-bucket-name"
  #   key            = "terraform/state.tfstate"       # path within the bucket
  #   region         = var.aws_region
  #   encrypt        = true                            # encrypt state at rest
  #   dynamodb_table = "your-dynamodb-lock-table"      # for state locking
  #   profile        = "your-aws-cli-profile"          # optional: named AWS CLI profile
  #   role_arn       = "arn:aws:iam::123456789012:role/TerraformExecutionRole"  # optional: for cross-account use
  # }
  #
  # -*-

}
