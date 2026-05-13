[client]
${vm_a_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_private_key_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[broker]
${vm_b_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_private_key_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[server]
${vm_c_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_private_key_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[all:vars]
broker_private_ip=${vm_b_private_ip}