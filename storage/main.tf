terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.12.0"
}

provider "yandex" {
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.yc_zone
  service_account_key_file = file("~/.ssh/ya/.authorized_key.json")
}

## Service account for Terraform
resource "yandex_iam_service_account" "terraform" {
  name        = "tf-srv-account"
  description = "Service account for Terraform"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.yc_folder_id
  role      = "editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.terraform.id}",
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "storage_admin" {
  folder_id = var.yc_folder_id
  role      = "storage.admin"
  members   = [
    "serviceAccount:${yandex_iam_service_account.terraform.id}",
  ]
}

## Static access key for bucket
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.terraform.id
  description        = "Static access key for Terraform backend"
}

## Create bucket
resource "yandex_storage_bucket" "storage_bucket" {
  bucket     = "${var.bucket_name}-${formatdate("DD.MM.YYYY", timestamp())}" 
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  
  default_storage_class = "STANDARD"
  acl           = "public-read"
  force_destroy = "true"
  max_size      = var.bucket_max_size 


  versioning {
    enabled = true
  }
}
