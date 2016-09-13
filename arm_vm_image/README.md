# arm_vm_image

This Terraform plan deploys a resource group and a public VM that will be used to create a standardized VM template for deploying to Azure Resource Manager.

# quick start

- cd to the `arm_vm_image` directory. Source the `azure_credentials.sh`:

```
cd terraform/arm_vm_image
source ../azure_credentials.sh
```

- Run Terraform:

```
terraform plan
terraform apply
```
