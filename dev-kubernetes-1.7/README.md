# kubernetes 1.7.x Terraform

Deployment of the Kubernetes infrastructure. Meant to be used with the AWS VPC deployment. This deploys:

- cfssl instance.
- etcd cluster.
- kubernetes controller cluster.
- an internal ELB for controller API access.
- kubernetes workers.
- EFS storage (NFS backend if needed).

# quick start

- Export your AWS keys (note - if you have your credentials saved at `~/.aws/config`, you can just source the source script, `source ../source_credentials.sh`).


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
terraform plan
terraform apply
```
