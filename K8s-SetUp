#K8s SetUp (Both)

#sudo apt-get update
#sudo apt install docker.io -y
#sudo service docker restart

#########
sudo apt-get install -y apt-transport-https ca-certificates curl

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key \
| sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" \
| sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

sudo kubeadm init --pod-network-cidr=192.168.0.0/16


########

#Step 2(On Master Node)
kubeadm init --pod-network-cidr=192.168.0.0/16

#Step 3 (On Worker Node)
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/cofig
sudo chown $(id -u):$(id -g) $HOME/.kube/config







