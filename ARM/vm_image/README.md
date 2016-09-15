# arm_demo

This Terraform plan deploys a resource group to Azure Resource Manager (ARM), with a single VM.  It's purpose is to create a base VM template to use.

# quick start

- cd to the `arm_vm_image` directory. Source the `azure_credentials.sh` (symlinked):

```
cd terraform/arm_demo
source ./azure_credentials.sh
```

- Run Terraform:

```
terraform plan
terraform apply
```
