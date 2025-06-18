[all]
%{ for master in masters ~}
${master.name} ansible_host=${master.public_ip} ip=${master.private_ip} node_role=master
%{ endfor ~}
%{ for worker in workers ~}
${worker.name} ansible_host=${worker.public_ip} ip=${worker.private_ip} node_role=worker
%{ endfor ~}

[all:vars]
%{ for master in masters ~}
ansible_user=ubuntu
supplementary_addresses_in_ssl_keys='["${master.public_ip}"]'
%{ endfor ~}

[kube_control_plane]
master-01

[etcd]
master-01

[kube_node]
worker-01
worker-02

[calico_rr]

[k8s_cluster:children]
kube_control_plane
kube_node
calico_rr
