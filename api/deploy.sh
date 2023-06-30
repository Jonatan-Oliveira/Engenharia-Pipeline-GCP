gcloud run deploy engenharia-pipeline-gcp --source . --region us-central1

#!/bin/bash

PROJECT_ID="engenharia-pipeline-gcp"
SERVICE_NAME="engenharia-pipeline-gcp"
REGION="us-central1"

# Faz o build da imagem Docker
gcloud builds submit --tag gcr.io/$PROJECT_ID/$SERVICE_NAME

# Faz o deploy do serviço na Cloud Run
gcloud run deploy $SERVICE_NAME \
  --image gcr.io/$PROJECT_ID/$SERVICE_NAME \
  --region $REGION \
  --platform managed
