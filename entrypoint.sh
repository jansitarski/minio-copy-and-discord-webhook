#!/usr/bin/env bash
mc alias set deploy $MINIO_ENDPOINT $MINIO_ACCESS_KEY $MINIO_SECRET_KEY --api S3v4
ls -al
echo "deploy to: $SOURCE_FILE deploy/$TARGET_DIR"
mc cp --recursive $SOURCE_FILE "deploy/"$TARGET_DIR
#echo "URL to download."
#url=$(mc share download deploy/$2$FILE_TO_DOWNLOAD  --json | jq -r '.share')
#echo $url
#curl -X POST --data-urlencode "payload={\"channel\": \"#general\", \"username\": \"$BOT\", \"text\": \"$MSG $url\", \"icon_emoji\": \":rocket:\"}" $SLACK_HOOK
