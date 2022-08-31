#!/usr/bin/env bash
mc alias set deploy $MINIO_ENDPOINT $MINIO_ACCESS_KEY $MINIO_SECRET_KEY --api S3v4
echo "deploy to: $SOURCE_FILE deploy/$TARGET_DIR"
mc cp --recursive $SOURCE_FILE "deploy/"$TARGET_DIR

if($WEBHOOK_URL!="error"){
  echo "Send webhook $WEBHOOK_URL"
  curl -H "Content-Type: application/json" \
          -d '{"username": "MinIO",  "embeds": [{
              "title": $WEBHOOK_TITLE,
              "description": $WEBHOOK_DESC
              }]}' $WEBHOOK_URL
}

