####🔹 Step 0: Prepare ALL nodes (Master + Workers)

sudo apt update
sudo apt install docker.io -y
sudo systemctl enable docker && sudo systemctl start docker

sudo apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key \
| sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" \
| sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubelet kubeadm kubectl

######## Kernel + Networking (MANDATORY)
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

#####🔹 Step 1: Initialize MASTER ONLY
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
#Then:
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#✅ At this point: (1)API server is alive. (2)kubectl works. (3)Node will show NotReady (EXPECTED)



######🔹 Step 2: Install CNI FIRST (before workers)
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.3/manifests/calico.yaml
#Wait until: 
kubectl get nodes

#Shows :
control-plane   Ready



####🔹 Step 3: Join Workers (ONCE, ONLY ON WORKERS)
kubeadm join <MASTER-IP>:6443 --token <token> \
--discovery-token-ca-cert-hash sha256:<hash>

# ⚠️ Never repeat join, ⚠️ Never run on master



#####🔹 Step 4: Ingress (after cluster is Ready)
kubectl apply -f \
https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/baremetal/deploy.yaml





















##
