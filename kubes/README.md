# another_kubernetes

Another Terraform + Ansible Kubernetes deployment.

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
  - `kubernetes_cluster_id` - this is a tag that Kubernetes uses to manage AWS resources.  Must match the Ansible variable.
  
- Run Terraform:

```
cd another_kubernetes
terraform plan
terraform apply
```
