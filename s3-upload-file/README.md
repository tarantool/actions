# GitHub Action: upload a local file to S3

This action uploads a local file to S3 via cURL.

# Usage

## Parameters

| Parameter         | Description                                                                   | Example                 | Required | Default                      |
|-------------------|-------------------------------------------------------------------------------|-------------------------|----------|------------------------------|
| access-key-id     | The access key ID. You can find it anytime in the account description         | 1a2BCcDdEeFf            | True     | -                            |
| secret-access-key | The secret access key. You can see it only at the time you create the account | QqWwEeRrTtYyUuIiOoPprsg | True     | -                            |
| bucket            | The bucket name                                                               | my-bucket               | True     | -                            |
| source            | The source file path                                                          | my/file/path.txt        | True     | -                            |
| destination       | The destination file path in the bucket, including the file name              | my/directory            | True     | -                            |
| endpoint          | The endpoint URL without protocol prefix                                      | amazon.com              | False    | hb.bizmrg.com                |
| content-type      | The content type for the content being uploaded                               | application/x-zip       | False    | application/x-compressed-tar |

## Example

```YAML
- name: Upload local file
  uses: tarantool/actions/s3-upload-file@master
  with:
    access-key-id: ${{ secrets.MY_KEY_ID }} 
    secret-access-key: ${{ secrets.MY_SECRET_KEY }}
    source: /home/github/_tmp/_workdir/my_file.tar.gz
    destination: dir/my_file.tar.gz
    bucket: my_bucket
```
