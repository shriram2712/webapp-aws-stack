identity_token "aws" {
  audience = ["terraform-stacks-private-preview"]
}

deployment "test" {
  variables = {
    region              = "us-west-1"
    role_arn            = "arn:aws:iam::407603399482:role/oe_stacks_iam_role"
    identity_token_file = identity_token.aws.jwt_filename
    default_tags      = { stacks-preview-example = "webapp-ec2-stack-west" }
  }
}


deployment "production" {
  variables = {
    region              = "us-east-1"
    role_arn            = "arn:aws:iam::407603399482:role/oe_stacks_iam_role"
    identity_token_file = identity_token.aws.jwt_filename
    default_tags      = { stacks-preview-example = "webapp-ec2-stack-east" }
  }
}
