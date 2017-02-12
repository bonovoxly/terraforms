# vm_image

This Terraform plan deploys a resource group to Azure Resource Manager (ARM), with a single VM.  It's purpose is to create a base VM template to use.

# quick start

- cd to the `./terraforms/ARM/vmimage` directory. Source the `azure_credentials.sh` (symlinked):

```
cd terraform/arm_demo
source ./azure_credentials.sh
```

- Run Terraform.  Note that the SSH key variable should be set:

```
TF_VAR_sshkey=/path/to/ssh_public_key terraform plan
TF_VAR_sshkey=/path/to/ssh_public_key terraform apply
```
