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


sudo vim /etc/hosts
add the following :  
<vm-ip> myapp.local  

kubectl apply -f ingress.yaml  
kubectl port-forward svc/nodejs-hello-world-service 8080:80 &

# testing the app  
curl http://localhost:8080/health  
output: Handling connection for 8080  
{"status":"ok"}  


curl http://localhost:8080/  
Handling connection for 8080  
output: {"message":"Hello World"}  
# please note that this app is accessible only from this machine. If you want to be able to access from internet you need to register your domain and update your ingress accordingly  
terraform destroy
