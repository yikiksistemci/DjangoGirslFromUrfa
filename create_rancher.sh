#!/bin/bash
# for debux mod please run # bash -x 
# <yikiksistemci> <Yunus.Yasar@sahibinden.com"

CLUSTER_NAME="k3d-rancher"
CLUSTER_URL="rancher.localhost"
TEMP_DIR=/tmp
SERVER_COUNT=1
AGENT_COUNT=1
EXEC_DIR=/usr/local/bin


# install docker by Rancher docker install script
echo -n "Install Docker ... "
curl https://releases.rancher.com/install-docker/19.03.sh | sh
sudo usermod -aG docker $USER
newgrp docker

echo -n "Done"

### install k3d 

curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

k3d --version

### install kubectl 
echo -n "Install kubectl"

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x ./kubectl

sudo mv ./kubectl $EXEC_DIR/kubectl

kubectl version

echo -n "Done"

### install helm 
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

helm version

echo -n "Done"

k3d cluster create $CLUSTER_NAME --api-port 6550 --servers $SERVER_COUNT --agents $AGENT_COUNT --port 443:443@loadbalancer --wait

#### configure hosts file

cat <<EOF>> /etc/hosts
127.0.0.1 rancher.localhost
127.0.0.1 django.localhost
EOF

### get cluster
k3d cluster list

# get nodes
kubectl get nodes

### 3. Install Rancher (and its dependency cert-manager) with helm according to the docs https://rancher.com/docs/rancher/v2.x/en/installation/k8s-install/helm-rancher/
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.15.0/cert-manager.crds.yaml
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.15.0 --wait
kubectl -n cert-manager rollout status deploy/cert-manager

helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=$CLUSTER_URL --wait
kubectl -n cattle-system rollout status deploy/rancher
