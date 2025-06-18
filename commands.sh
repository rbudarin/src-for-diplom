#!/bin/bash
# source ~/venv3.11/bin/activate
cd storage
terraform init
terraform apply -auto-approve
echo -e "bucket = $(terraform output bucket_name)\naccess_key = $(terraform output access_key)\nsecret_key = $(terraform output secret_key)" > ../.backend.hcl
cd ../ && terraform init -reconfigure -backend-config=.backend.hcl

terraform apply -auto-approve
./inventory.sh
cd ./kubespray
ssh-add ~/.ssh/k8s
sleep 2
ansible-playbook -i inventory/mycluster/inventory.ini -u ubuntu --become --become-user=root cluster.yml
cd ..

master_ip_private=$(terraform output -json masters | jq -r '.["master-01"].private_ip')
master_ip_public=$(terraform output -json masters | jq -r '.["master-01"].public_ip')
sed -i "s/$master_ip_private/$master_ip_public/g" ./kubespray/inventory/mycluster/artifacts/admin.conf
cp ./kubespray/inventory/mycluster/artifacts/admin.conf ~/.kube/config

