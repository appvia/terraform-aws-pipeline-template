
terraform {
  required_version = ">= 1.11.0"

  ## This is configured in the pipeline template
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0"
    }
  }
}
