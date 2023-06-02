resource "google_storage_bucket" "gcs_bucket" {
  name     = "bucket-eng-pipeline-gcp-9114"
  location = var.region

  # Additional configuration for the bucket...
}