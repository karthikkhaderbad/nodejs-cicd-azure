Creating a Docker registry in Github: <br>
Create a github pat with the following permissions <br>
![](./images/pat.png)<br>
docker login ghcr.io -u karthikkhaderbad -p YOUR_PERSONAL_ACCESS_TOKEN <br>
docker build -t ghcr.io/karthikkhaderbad/nodejs-cicd-azure:v1.0 . <br>
docker push ghcr.io/karthikkhaderbad/nodejs-cicd-azure:v1.0 <br>
now if I go to github .. packages I see <br>
![](./images/ghcr.png)<br>