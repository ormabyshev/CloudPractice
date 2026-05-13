resource "yandex_vpc_network" "network" {
    name = "cloud-network"
}

# подсеть 1
resource "yandex_vpc_subnet" "subnet_1" {
    name = "subnet-clients"
    zone = "ru-central1-a"
    network_id = yandex_vpc_network.network.id
    v4_cidr_blocks = ["10.0.1.0/24"]
}

# подсеть 2
resource "yandex_vpc_subnet" "subnet_2" {
    name = "subnet-server"
    zone = "ru-central1-a"
    network_id = yandex_vpc_network.network.id
    v4_cidr_blocks = ["10.0.2.0/24"]
}

# Образ
data "yandex_compute_image" "ubuntu" {  
    family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "vm_a" {
    name = "vm-a-client"
    platform_id = "standard-v1"
    zone = "ru-central1-a"

    resources {
        cores = 2
        memory = 2
    }

    scheduling_policy {
        preemptible = true
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.id
            size = 10
            type = "network-hdd"
        }
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.subnet_1.id
        nat = true
    }

    metadata = {
        ssh-keys = "ubuntu:${file(var.ssh_pub_key_path)}"
    }
}

resource "yandex_compute_instance" "vm_b" {
    name = "vm-b-broker"
    platform_id = "standard-v1"
    zone = "ru-central1-a"

    resources {
        cores = 2
        memory = 2
    }

    scheduling_policy {
        preemptible = true
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.id
            size = 10
            type = "network-hdd"
        }
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.subnet_1.id
        nat = true
    }

    metadata = {
        ssh-keys = "ubuntu:${file(var.ssh_pub_key_path)}"
    }
}

resource "yandex_compute_instance" "vm_c" {
    name = "vm-c-server"
    platform_id = "standard-v1"
    zone = "ru-central1-a"



    resources {
        cores = 2
        memory = 2
    }

    scheduling_policy {
        preemptible = true
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.id
            size = 10
            type = "network-hdd"
        }
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.subnet_2.id
        nat = true
    }

    metadata = {
        ssh-keys = "ubuntu:${file(var.ssh_pub_key_path)}"
    }
}

resource "local_file" "ansible_inventory" {
    content = templatefile("${path.module}/inventory.tpl",
        {
            vm_a_ip = yandex_compute_instance.vm_a.network_interface[0].nat_ip_address
            vm_b_ip = yandex_compute_instance.vm_b.network_interface[0].nat_ip_address
            vm_c_ip = yandex_compute_instance.vm_c.network_interface[0].nat_ip_address
            vm_c_private_ip = yandex_compute_instance.vm_c.network_interface[0].ip_address
            vm_b_private_ip = yandex_compute_instance.vm_b.network_interface[0].ip_address
            ssh_private_key_path = var.ssh_private_key_path
        }
    )
    filename = "../ansible/inventory.ini"
}