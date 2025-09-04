# NOTE: All features and deliverables completed (app code, Dockerization, CI/CD workflows, Terraform infrastructure, Kubernetes deployment, monitoring with Prometheus/Grafana).The only missing piece is exposing the app publicly. 

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
# install ingress-nginx  
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx  
helm repo update  
# make the app available to the internet  
helm install nginx-ingress ingress-nginx/ingress-nginx  --set controller.service.type=NodePort  
kubectl get svc -l app.kubernetes.io/name=ingress-nginx  
# look for tcp ports in this service and allow inbound traffic in this NSG  

  

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

# Adding helm repos for prometheus and grafana    
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts  
helm repo add grafana https://grafana.github.io/helm-charts  
helm repo update  
# install prometheus and grafana  
helm install prometheus prometheus-community/prometheus  
helm install grafana grafana/grafana  
# port forward grafana  
kubectl port-forward svc/grafana 3000:80 &  
# since our vm is cli only, I am going to create a tunnel to my local in order to view grafana  
ssh -L 3000:localhost:3000 azureuser@<local IP>
# open localhost:3000 in your local browser with credentials below  
Username: admin  
Password: get password with:  
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode  
# login and add a data source, select prometheus and add   
url=http://prometheus-server.default.svc.cluster.local:80  
create a dashboard and add 2 panels for cpu and memory  
query for cpu panel: sum(rate(container_cpu_usage_seconds_total{pod=~"nodejs-hello-world.*"}[5m])) by (pod)  
query for memory panel: sum(container_memory_working_set_bytes{pod=~"nodejs-hello-world.*"}) by (pod)  


terraform destroy
