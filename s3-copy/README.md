# GitHub Action: Save the file archive to the S3 storage

This action archives the file or directory set as input to the zip-archive
and uploads it to the S3 storage with the path from `destination` input.

# Usage

## Parameters

| variable             | description                                                                                                                                                      | example                 | required | default       |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|----------|---------------|
| s3-access-key-id     | S3 access key ID. You can find it anytime in the account description (Object storage -> Accounts -> Your account name).                                          | 1a2BCcDdEeFf            | True     | -             |
| s3-secret-access-key | S3 secret access key. You can see it only at the time you create the account.                                                                                    | QqWwEeRrTtYyUuIiOoPprsg | True     | -             |
| s3-region            | The region set in your S3 endpoint. You can find it in the documentation of your S3 storage, i.e. https://mcs.mail.ru/docs/ru/base/s3/quick-start/create-bucket. | ru-msck                 | False    | ru-msk        |
| bucket               | The name of the S3 bucket.                                                                                                                                       | my-bucket               | True     | -             |
| source               | The path to the file or directory you want to save to S3.                                                                                                        | my/file/path.txt        | True     | -             |
| destination          | The path in the bucket with the file name. If you want to store the file in the bucket root, destination must be the file name.                                  | my/directory            | True     | -             |
| endpoint             | The URL of your S3 storage to get the access to the uploaded files without protocol prefix.                                                                      | amazon.com              | False    | hb.bizmrg.com |


## Example

```YAML
- name: Sync artifacts
        uses: tarantool/actions/s3-copy@master
        with:
          s3-access-key-id: ${{ secrets.MY_KEY_ID }} 
          s3-secret-access-key: ${{ secrets.MY_SECRET_KEY }}
          s3-region: ru-msk
          source: /home/github/_tmp/_workdir/my_artifacts
          destination: dir/file.tar.gz
          bucket: my_bucket
          endpoint: hb.bizmrg.com
```