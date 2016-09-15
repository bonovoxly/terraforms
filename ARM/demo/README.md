# arm_demo

This Terraform plan deploys a resource group and a demo Azure Resource Group (ARM) infrastructure.

# quick start

- cd to the `terraforms/ARM/demo` directory. Source the `azure_credentials.sh` (symlinked):

```
cd terraform/arm_demo
source ./azure_credentials.sh
```

- Run Terraform:

```
terraform plan
terraform apply
```
