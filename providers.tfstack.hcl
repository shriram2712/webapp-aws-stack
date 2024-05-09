required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"
  }
  
  template = {
    source  = "hashicorp/template"
    version = "~> 2.2.0"  # Specify the version you need
  }
}

provider "aws" "config" {
  config {
    region = var.aws_region

    assume_role_with_web_identity {
      role_arn                = var.role_arn
      web_identity_token_file = var.identity_token_file
    }

    default_tags {
      tags = var.default_tags
    }
  }
}

provider "template" "config" {
}