# GitHub Action: get ID of the current workflow job

There are some situations when we need to get ID of the current workflow job,
but GitHub doesn't provide us with any context to do it. This action returns
ID of the current workflow job by the given job name.

The result will be saved in the environment variable `JOB_ID` and in the action
output as `job-id`.

# Usage

```yaml
    - name: Get job ID
      id: get-job-id
      uses: tarantool/actions/get-job-id@master
      with:
        job-name: ${{ github.job }} (${{ join(matrix.*, ', ') }})

    - name: Use job ID
      run: |
        echo ${{ env.JOB_ID }}
        echo ${{ steps.get-job-id.outputs.job-id }}
```

# Parameters

You should provide the `job-name` parameter if your workflow uses the matrix
strategy. Don't worry if you provide the name as `foobar ()`: the action will 
remove empty brackets from the job name.

If the `job-name` is empty, the action will use `${{ github.job }}` to find the
job ID.
