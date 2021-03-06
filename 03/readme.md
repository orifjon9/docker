# Kubernetes

### Install 
The best resources are in https://kubernetes.io

1. Install tools and setup kubectr https://kubernetes.io/docs/tasks/tools/install-kubectl/
2. Install and start minikube https://minikube.sigs.k8s.io/docs/start/


## Kubernetes in Action - Diving into the Core Concepts(Imperative approach)

### Deployment
NOTE: Mke sure minikube started
If not then run this commends
`
minikube start
minikube dashboard
`

Take any image builds to exprore how kubertines works. In my case, I build simple web app and that contains a single page. So, I use orifjon9/ec2-docker-simple-web-app this

1. kubectl create deployment simple-web-app --image=orifjon9/ec2-docker-simple-web-app:2
    1.1 kubectl delete deployment simple-web-app -- if fails
2. kubectl expose deployment simple-web-app --type=LoadBalancer --port=8080
3. kubectl get service -- make sure it runs
4. minikube service simple-web-app -- otherwise it doesn't work because there is not a service between to get data from pods

It should start working. It opens a browser link to web app. So, you should see all green in the kubernetes dashboard

Scaling in Action
5. kubectl scale deployment/simple-web-app --replicas=3
6. kubectl get pods     --- to make sure all run

Updating deployments
If you have a new build, so updated web app then. But make sure docker hub has updated build
Make sure it tagged with a different version otherwise it wouldn't download

7. kubectl set image deployment/simple-web-app ec2-docker-simple-web-app=orifjon9/ec2-docker-simple-web-app:3

To make sure, deployment got an update
8. kubectl rollout status deployment/simple-web-app

If you want to rollback deployment to previous deployment
9. kubectl rollout undo deployment/simple-web-app
    9.1 kubectl rollout undo deployment/simple-web-app --to-revision=1 --  if you want to roll back deployment to exact revision

To see history of deployment
10. kubectl rollout history deployment/simple-web-app

To delete created deployment
11. kubectl delete deployment/simple-web-app
12. kubectl delete service/simple-web-app

## Kubernetes in Action - Creating a Deployment Configuration File (Declarative Approach)

To run a container(pods) and a service
`kubectl apply -f=deployment.yaml -f=service.yaml`

Or make a onle file and run
`kubectl apply -f=master-deployment.yaml`

### Persistent Volume
To create a persistent valume needs to run this command.
`kubectl apply -f=host-pv.yaml`

To create a persistent volume claim
`kubectl apply -f=host-pvc.yaml`

Connect the created persistent volume claim with container:
Apply configuration changes in deployment.yaml and run it
`kubectl apply -f=deployment.yaml`

And check, the app should running

### Environment variables & ConfigMaps
To store environment variables in ConfigMap
`kubectl apply -f=environment.yaml`

To see all configmaps
`kubectl get configmap`

Then bring variables from ConfigMap(in the devloyment.yaml) then apply latest deployment.yaml 