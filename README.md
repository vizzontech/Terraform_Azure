# Deploy infrastructure on azure using terraform

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database

## Install terrafrom using Chocolatey package  
If you haven't installed Chocolatey yet, follow this quick guide to set it up on your machine. https://docs.chocolatey.org/en-us/choco/setup/

```
choco install terraform
```

```
terraform -help
```

```
az login 
```

az login using subscription Id
```
az account set --subscription <SUBSCRIPTION_ID>
```

list account
```
az account list
```
Create a Service Principal in Azure AD with tokens for Terraform, replacing <SUBSCRIPTION_ID> with your subscription ID.

```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>
```
Set service principal ids in environment variable 

```
$ $Env:ARM_CLIENT_ID = "<APPID_VALUE>"
$ $Env:ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"
$ $Env:ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"
$ $Env:ARM_TENANT_ID = "<TENANT_VALUE>"
```


## Terraform commands

Init
```
terraform init
```
Format
```
terraform fmt
```
Validate
```
terraform validate
```
Apply
```
terraform apply
```

Apply with auto approve
```
terraform apply -auto-approve
```


<img width="1172" alt="image" src="https://github.com/user-attachments/assets/9738bd49-84cd-4c86-938c-bf805dfd3a5a" />


```
terraform show
```

```
terraform state list
```

```
terraform destroy
```

Override variales.tf values 
```
terraform apply -var "resource_group_name=vizzon-tf-2025-1" -var "location=UKWest"
```

```
terraform init -upgrade
```