# Variables
##_______Providers______________##
variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  default     = "################"
  sensitive   = true
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  default = "################"
}

variable "yc_zone" {
  description = "Yandex Cloud default zone"
  default = "ru-central1-a"
} 

##_______Storage_______________##
variable "bucket_name" {
  description = "Name for the s3-bucket"
  type        = string
  default = "s3-bucket"
}

variable "bucket_max_size" {
  description = "Maximum size of the storage bucket in bytes"
  type        = number
  default     = 104857600 # 1 Gb
}
