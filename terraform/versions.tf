terraform {
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
            version = ">= 0.75"
        }
        local = {
            source = "hashicorp/local"
            version = ">= 2.2"
        }
    }
}