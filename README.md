# steps to create the infrastructure in azure
First you need to clone the repo
az login
az account set --subscription "<your-subscription-id-or-name>"  
export ARM_SUBSCRIPTION_ID="<your-subscription-id>"
cd terraform

make appropriate changes in terraform.tfvars

terraform init

# next 2 commands are optional, you can run them just to be sure everything is alright before you go ahead and apply
terraform fmt  
$terraform validate

terraform plan -var-file="terraform.tfvars"  
terraform apply -var-file="terraform.tfvars" -auto-approve

# once resources are up and running, connect to the vm from portal using cloud shell  



terraform destroy
