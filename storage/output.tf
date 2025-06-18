output "service_account_id" {
  value       = yandex_iam_service_account.terraform.id
  description = "ID of the created service account"
}

output "bucket_name" {
  value       = yandex_storage_bucket.storage_bucket.bucket
  description = "Name of the created bucket for Terraform state"
}

output "access_key" {
  value       = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  description = "Access key for the service account"
  sensitive   = true
}

output "secret_key" {
  value       = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  description = "Secret key for the service account"
  sensitive   = true
}
