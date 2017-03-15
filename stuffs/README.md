# stuffs

Stuffs, a proof-of-concept AWS instance inventory management documentation generator, using Terraform, Ansible, AWS S3, and Hugo.

# quick start

- Export your AWS keys (note - if you have your credentials saved at `~/.aws/config`, you can just source the `../aws_credentials.sh` file).

```
export AWS_ACCESS_KEY_ID=YOURACCESSKEY
export AWS_SECRET_ACCESS_KEY=YOURSECRETKEY
```

- Edit the `variables.tf` accordingly.  Some important ones:
  - `env` - the environment, used for tagging/labeling instances.
  - `cidr` - the first two octets of the AWS VPC cidr.  
  - `keypair` - this should be the public SSH key that manages the instances.  Needs to exist in AWS.
  - `stuffs_bucket_name` - the AWS S3 bucket name to use.  Must be globally unique.
  - `stuffs_bucket_acl` - the AWS bucket ACL.  For this demo it's public, but inventory documentation should be private.

- Run Terraform:

```
cd another_kubernetes
terraform plan
terraform apply
```

# issues and notes

- You will definitely want to change the bucket name and ACL;  no one will want to have a truly public bucket.  Better to configure some NGINX front end.  This was a proof of concept configuration.
