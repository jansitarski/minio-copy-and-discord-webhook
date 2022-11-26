# Minio Upload and Discord Webhook

- Run [minio client][] in GitHub Actions to deploy files to MinIO object storage.
- Send webhook notification to Discord integration. 

It uses the `mc cp --recursive` command to upload.

#### Disclaimer
This is a container action, so it doensn't work in Windows runners.
Requests have to be made to console port

## Usage
Put the following step in your workflow:

```yml
- name: Minio upload
  uses: jansitarski/minio-copy-discord-notify@v1
  with:
    endpoint: ${{ secrets.MINIO_ADDRESS }}
    access_key: ${{ secrets.MINIO_ACCESS_KEY }}
    secret_key: ${{ secrets.MINIO_SECRET_KEY }}
    bucket: 'bucket-name'
    source_file: 'folder/file'
    target_dir: '/'
    # Optional inputs with their defaults:
    webhook: 'https://discord.com/api/webhooks/123/w3bh00k_t0k3n'
    webhook_title: "MinIO upload"
    webhool_desc: "Uploaded file to bucket"
```

Workflow example of uploading build artifacts to current date named folder:
```yml
- name: Get current date
  id: date
  run: echo "::set-output name=date::$(date +'%Y-%m-%d')"

- name: Minio Upload and Discord webhook
  uses: jansitarski/minio-copy-discord-notify@v1
  with:
    endpoint: ${{ secrets.MINIO_ADDRESS }}
    access_key: ${{ secrets.MINIO_ACCESS_KEY }}
    secret_key: ${{ secrets.MINIO_SECRET_KEY }}
    bucket: ${{ secrets.MINIO_BUCKET }}
    source_file: 'build/Build-linux.tar'
    target_dir: '/Release-${{ steps.date.outputs.date }}/linux-amd64/'
    # Optional inputs with their defaults:
    webhook: ${{ secrets.DISCORD_WEBHOOK }}
    webhook_title: "MinIO upload"
    webhook_desc: "Uploaded file to $RELEASE_NAME bucket"
  env:
    RELEASE_NAME: Release-${{ steps.date.outputs.date }}
```

## License

Licensed under the MIT license. See [LICENSE](LICENSE).

[minio client]: https://docs.min.io/docs/minio-client-quickstart-guide
