identity_token "aws" {
  audience = ["terraform-stacks-private-preview"]
}

deployment "test" {
  variables = {
    aws_region          = "us-east-1"
    role_arn            = "arn:aws:iam::407603399482:role/oe_stacks_iam_role"
    identity_token_file = identity_token.aws.jwt_filename
    default_tags        = { stacks-preview-example = "webapp-ec2-stack-test" }
    user_data           = "/user_data/updated_site.txt"
  }
}


deployment "production" {
  variables = {
    aws_region          = "us-east-1"
    role_arn            = "arn:aws:iam::407603399482:role/oe_stacks_iam_role"
    identity_token_file = identity_token.aws.jwt_filename
    default_tags        = { stacks-preview-example = "webapp-ec2-stack-production" }
    user_data           = "/user_data/legacy_site.txt"
  }
}
