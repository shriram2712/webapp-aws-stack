# webapp-aws-stack

_This is an example stack configuration for the private preview of Terraform Stacks. Language
constructs and features are subject to change given feedback received during this preview. Do not
use Stacks for production workloads at this time._

![webapp-aws-stack](https://github.com/oeghaneyan/webapp-aws-stack/assets/56609570/ed579397-17c2-4aa8-a530-c9206cb00e76)

This stack provisions an AWS virtual private cloud (VPC) using three availability zones and with six
subnets using the popular AWS VPC Terraform module. An EC2 instance running the latest Ubuntu AMI is
then provisioned within each subnet. 

Two components are used:

* `vpc` uses the popular AWS VPC Terraform module to provision an AWS virtual private network, with
  various subnets.
* `ec2` uses the created VPC's ID to fetch the subnets and provision an EC2 instance running Ubuntu
  within each. Initially, the planning of changes for this component will be _deferred_, and will be
  subsequently planned after the initial apply provisioning the `vpc` component infrastructure.

Without Terraform's new concept of _deferred changes_, the configuration here would fail as follows:

![CleanShot 2024-01-10 at 14 35 36](https://github.com/hashicorp/vpc-ec2-stack/assets/2430490/78c67a81-2647-4797-949b-b191b80edeaf)

Although there are ways in current-day Terraform to avoid the error in this specific example (you
can directly reference the subnets from the VPC module instead of using a data source to query them
separately after creation, or you can use tedious resource targeting to manually hide the EC2 infrastructure
from Terraform until appropriate), this example demonstrates the broader concept of _deferred changes_
clearly: Terraform understands that in order to fetch the appropriate subnets in one component, a
partial plan must be applied and the stack replanned afterward to resolve unknown values only known
after apply. Replanning continues until the all resources are applied no further changes are
necessary, at which point the configuration is considered _converged_.

_We do not recommend using this example within production accounts. This example will incur [small]
costs if provisioned. Please remember to destroy the infrastructure after using this example._

## Usage

_Prerequisites: You must have a Terraform Cloud account with access to the private preview of
Terraform Stacks, a GitHub account, and an AWS account with Terraform Cloud configured as an OIDC
identity provider. Details of all of this are found in the provided Stacks User Guide._

1. **Configure AWS authentication** by creating a new IAM role in the AWS web console (or with
   Terraform itself!) with proper permissions (S3, Lambda, and API Gateway) and a trust policy to
   allow the role to be assumed by Terraform Cloud (the OIDC identity provider). More details on this
   step can be found in the Stacks User Guide.
2. **Fork this repository** to your own GitHub account, such that you can edit this stack configuration
   for your purposes.
3. **Edit your forked stack configuration** and change `deployments.tfdeploy.hcl` to use the ARN of the
   IAM role you created, as well as an audience value for OpenID Connect and the name of a key pair
   to use for the purposes of logging in to the created EC2 instances (import your own SSH public
   key in the AWS console under EC2 -> Key Pairs -> Import Key Pair)
4. **Create a new stack** in Terraform Cloud and connect it to your forked configuration repository.
5. **Provision away!** Once applied, look at the `public_ip` attribute for the
   one of the `aws_instance` resources. Using your local SSH key, you should be able to log in to
   the Ubuntu console for that instance via `ssh ubuntu@<public-ip-of-ec2-instance`.
