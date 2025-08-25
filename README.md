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
ssh-copy-id -f -i ~/.ssh/id_rsa.pub azureuser@{public ip of vm}  
ssh -i ~/.ssh/id_rsa azureuser@{ vm public ip}

# once loged into vm  
sudo usermod -aG docker $USER  
newgrp docker  
docker version  
minikube start  
git clone https://github.com/karthikkhaderbad/nodejs-cicd-azure.git  
cd nodejs-cicd-azure/k8s  
# make necessary changes to the yaml files and apply them  
kubectl apply -f deployment.yaml  
kubectl apply -f service.yaml  
kubectl apply -f ingress.yaml  


terraform destroy
