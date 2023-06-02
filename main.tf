resource "google_storage_bucket" "gcs_bucket" {
  name     = "bucket-eng-pipeline-gcp-9114"
  location = "US-CENTRAL1"
  project  = "eng-pipeline-gcp-104358"

  # Other attributes...
}
