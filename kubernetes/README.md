Expose port in minikube

minikube start 
kubectl run laravel --image=jaysalpatel/laravel --port=8000
$ kubectl expose deployment laravel --type=NodePort
$ curl $(minikube service laravel --url)
CLIENT VALUES:
client_address=192.168.99.1
command=GET
real path=/ ....

$ kubectl run laravel --image=jaysalpatel/laravel --port=8000
deployment "laravel" created
$ kubectl expose deployment laravel --type=NodePort
service "laravel" exposed
$ kubectl get svc
NAME      CLUSTER-IP   EXTERNAL-IP   PORT   
laravel   10.0.0.102   <nodes>       8000/TCP  
kubernetes 10.0.0.1    <none>        443/TCP    

$ minikube service laravel
Opening kubernetes service default/laravel in default browser...



$ minikube service laravel --url
http://192.168.99.100:31167
