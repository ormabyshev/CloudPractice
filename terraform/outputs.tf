output "vm_a_public_ip" {
    description = "public IP VM A"
    value = yandex_compute_instance.vm_a.network_interface[0].nat_ip_address
}

output "vm_b_public_ip" {
    description = "public IP VM B"
    value = yandex_compute_instance.vm_b.network_interface[0].nat_ip_address
}

output "vm_b_private_ip" {
    description = "private IP VM B"
    value = yandex_compute_instance.vm_b.network_interface[0].ip_address
}

output "vm_c_public_ip" {
    description = "public IP VM C"
    value = yandex_compute_instance.vm_c.network_interface[0].nat_ip_address
}

output "grafana_url" {
    description = "IP Grafana"
    value = "http://${yandex_compute_instance.vm_c.network_interface[0].nat_ip_address}:3000"
}

