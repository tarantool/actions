# GitHub Action: get the current job ID

There are several situations when we need the Job ID, but the GitHub
doesn't give the context with the Job ID. This action gets the Job ID
from the jobs' context (info about all the jobs in the run) with job
name and run attempt. 

The result will be saved in the environmental variable `JOB_ID` and as
the action output `job-id`.

# Usage
```yaml
    - name: Get job ID
      uses: tarantool/actions/get-job-id@master
      with:
        job-name: ${{ github.job }} (${{ join(matrix.*, ', ') }})

    - name: Use job ID
      run: echo ${{ env.JOB_ID }}
```

# Parameters
This action uses the only one parameter - `job-name`. You should set this
parameter if your workflow uses matrix strategy. Don't worry if one of the
parameters is the empty string: the action will remove empty brackets from
the job name.

If the `job-name` is empty, the action will use ${{ github.job }} to find the
job ID.
