# dev aws-vpc deployment

This Terraform project deploys a dev VPC AWS environment. These particular variabless deploy to us-east-1 (N. Virginia). Total resources deployed:

- VPC
- multiple subnets (general private/public subnets, etcd subnets, kubernetes subnets, ELB subnets, and DB subnets).
- managed NAT gateway (for outbound traffic).
- OpenVPN instance (and security groups).
- A private Route53 zone.

# quick start

- Export your AWS keys (note - if you have your credentials saved at `~/.aws/config`, you can just source the source script, `source ../source_credentials.sh`).

```
export AWS_ACCESS_KEY_ID=YOURACCESSKEY
export AWS_SECRET_ACCESS_KEY=YOURSECRETKEY
```

- Edit the `variables.tf` accordingly.  Some important ones:
  - `dns` - internal DNS zone to use
  - `env` - the environment, used for tagging/labeling instances.
  - `cidr` - the first two octets of the AWS VPC cidr.  
  - `keypair` - this should be the public SSH key that manages the instances.  Needs to exist in AWS.
  
- Run Terraform:

```
terraform plan
terraform apply
```

