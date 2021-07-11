package-charts:
	helm package helm -d charts

index-charts:
	helm repo index charts 


# ----------------------------------------------

dryrun-helm:
	helm install helm helm -f helm/values.yaml --dry-run > test-helm.yaml 
	
add-repo:
	helm repo add library https://renegmed.github.io/library-playground/charts

update-repo:
	helm repo update library https://renegmed.github.io/library-playground/charts

dryrun-lib:
	helm install lib library/Library --set database.volume.storageClassName=do-block-storage --set database.rootPassword=secretpassword --dry-run > test-lib.yaml 

install-lib:
	# helm install lib library/Library --set database.volume.storageClassName=do-block-storage --set database.rootPassword=secretpassword
	helm install lib library/Library --set database.volume.storageClassName=standard --set database.rootPassword=secretpassword  
	# $ kubectl get pvc -n database
	# $ kubectl exec -it pod/mysql-6df55bffdc-pm5gr -n database -- bin/sh
	# mysql -u root --password=secretpassword 
	# create database library;
	# use library;
	# create table books (id varchar(100), name varchar(100), isbn varchar(100));
	# insert into books values ("1", "The Everything Store", "ISBN-1");

uninstall-lib:
	helm uninstall lib 

# create-ingress-controller:
# 	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/do/deploy.yaml

# uninstall-ingress-controller:
# 	kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/do/deploy.yaml


# ---------- install/run ingress controller using local repo -------------------

# NOTE: using minikube, there is no need to install ingress controller
#       Minikube provides its own ingress controller
#
#		$ kubect get all -n kube-system 
#		
#  			pod/ingress-nginx-controller-558664778f-lkgt9   1/1     Running     9          29d
#
#       $ kubectl addon list  - ingress should be enabled 



# add-repo-ingress-controller:
# 	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# 	helm repo update 
# 	# helm repo list 
# 	# NAME            URL
# 	# ingress-nginx   https://kubernetes.github.io/ingress-nginx  

# install-ingress-controller:
# 	helm install ingress-nginx ingress-nginx/ingress-nginx

# uninstall-ingress-controller:
# 	helm uninstall ingress-nginx 


# ---------- ingress ----------------



dryrun-ingress: 
	helm install ingress helm-ingress -f helm-ingress/values.yaml --dry-run > test-ingress.yaml

install-ingress:
	helm install ingress helm-ingress -f helm-ingress/values.yaml

apply-ingress:
	helm apply ingress helm-ingress -f helm-ingress/values.yaml

uninstall-ingress:
	helm uninstall ingress 


list:
	curl 192.168.49.2/apis/v1/books 

post1:
	curl -XPOST 192.168.49.2/apis/v1/books -d '{"Id":"2", "Name":"To Be Or Not To Be, What is the Question!","Isbn":"ISBN-2"}'
