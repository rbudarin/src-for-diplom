# Variables
##_______Providers______________##
variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  default     = "##########################"
  sensitive   = true
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  default = "##########################"
}

variable "yc_zone" {
  description = "Yandex Cloud default zone"
  default = "ru-central1-a"
}

##_______VM-K8S_________________##
variable "vm_image" {
  type        = string
  description = "VM OS image" 
}

variable "vm_resources" {
  description = "Map of VM instances to create"
  type = map(object({
    zone        = string
    subnet_name = string
    role        = string
    cpu         = number
    ram         = number
    disk_type   = string
    disk_size   = number
    preemptible = bool
  }))
}

variable "ssh_public_key" {
  description = "SSH public key 'ssh-keygen -t ed25519'"
  type        = string
}
