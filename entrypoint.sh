#!/usr/bin/env bash
if [ -z "$MINIO_ENDPOINT" ]
  then
    echo "No endpoint specified"
    exit 1
fi
if [ -z "$MINIO_ACCESS_KEY" ]
  then
    echo "No access key specified"
    exit 1
fi
if [ -z "$MINIO_SECRET_KEY" ]
  then
    echo "No access key specified"
    exit 1
fi

mc alias set deploy $MINIO_ENDPOINT $MINIO_ACCESS_KEY $MINIO_SECRET_KEY --api S3v4

echo "deploy to: $1 deploy/$2"
mc cp --debug --recursive $1 "deploy/"$2

if [ $WEBHOOK_URL != 'error' ]
then
  echo "Send webhook"
  echo $WEBHOOK_TITLE
  echo $WEBHOOK_DESC
  curl -H "Content-Type: application/json" -d "{\"username\": \"MinIO\",  \"embeds\": [{ \"title\": \"$WEBHOOK_TITLE\", \"description\": \"$WEBHOOK_DESC\"}]}" $WEBHOOK_URL
fi

