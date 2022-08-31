#!/usr/bin/env bash
#mc alias set deploy $MINIO_ENDPOINT $MINIO_ACCESS_KEY $MINIO_SECRET_KEY --api S3v4
curl -H "Content-Type: application/json" -d '{"username": "test", "content": "hello"}' $WEBHOOK_URL
echo "deploy to: $SOURCE_FILE deploy/$TARGET_DIR"
echo "Send webhook $WEBHOOK_URL"
#mc cp --recursive $SOURCE_FILE "deploy/"$TARGET_DIR
