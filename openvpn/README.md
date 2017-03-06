# openvpn

Deploys the infrastructure for OpenVPN.  Based around the Ansible playbook for OpenVPN deployment ([see this blog post](http://bonovoxly.github.io/2016-12-30-personal-aws-vpn-using-openvpn)).

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

- Run Terraform:

```
cd openvpn 
terraform plan
terraform apply
```
