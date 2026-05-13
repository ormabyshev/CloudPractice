variable "yc_region" {
    description = "YC region"
    type = string
    default = "ru-central1-a"
}

variable "yc_token" {
    description = "Token Yandex Colud"
    type = string 
    sensitive = true
}

variable "yc_cloud_id" {
    description = "ID CLoud in YC"
    type = string
}

variable "yc_folder_id" {
    description = "ID Folder YC"
    type = string
}

variable "ssh_pub_key_path" {
    description = "the path to pub_ssh_key"
    type = string
    default = "~/.ssh/id_ed25519.pub"
}

variable "ssh_private_key_path" {
    description = "the path to private_ssh_key for Ansible"
    type = string
    default = "~/.ssh/id_ed25519"
}