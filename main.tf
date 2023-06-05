# resource "google_storage_bucket" "gcs_bucket" {
  # name     = "bucket-eng-pipeline-gcp-9114"
  # location = var.region
# }


module "bigquery-dataset-gasolina1" {
  source  = "./modules/bigquery"
  dataset_id                  = "gasolina_brasil"
  dataset_name                = "gasolina_brasil"
  description                 = "Dataset a respeito do histórico de preços da Gasolina no Brasil a partir de 2004"
  project_id                  = var.project_id
  location                    = var.region
  delete_contents_on_destroy  = true
  deletion_protection = false
  access = [
    {
      role = "OWNER"
      special_group = "projectOwners"
    },
    {
      role = "READER"
      special_group = "projectReaders"
    },
    {
      role = "WRITER"
      special_group = "projectWriters"
    }
  ]
  tables=[
    {
        table_id           = "tb_historico_combustivel_brasil",
        description        = "Tabela com as informacoes de preço do combustível ao longo dos anos"
        time_partitioning  = {
          type                     = "DAY",
          field                    = "data",
          require_partition_filter = false,
          expiration_ms            = null
        },
        range_partitioning = null,
        expiration_time = null,
        clustering      = ["produto","regiao_sigla", "estado_sigla"],
        labels          = {
          name    = "data_pipeline"
          project  = "gasolina"
        },
        deletion_protection = true
        schema = file("./bigquery/schema/gasolina_brasil/tb_historico_combustivel_brasil.json")
    }
  ]
}

module "bucket-raw" {
  source  = "./modules/gcs"

  name       = "data-pipeline-combustiveis-brasil-raw1"
  project_id = var.project_id
  location   = var.region
}

module "bucket-curated" {
  source  = "./modules/gcs"

  name       = "data-pipeline-combustiveis-brasil-curated2"
  project_id = var.project_id
  location   = var.region
}

module "bucket-pyspark3-tmp" {
  source  = "./modules/gcs"

  name       = "data-pipeline-combustiveis-brasil-pyspark-tmp"
  project_id = var.project_id
  location   = var.region
}

module "bucket-pyspark4-code" {
  source  = "./modules/gcs"

  name       = "data-pipeline-combustiveis-brasil-pyspark-code"
  project_id = var.project_id
  location   = var.region
}