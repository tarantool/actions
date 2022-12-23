# Get pull request information

This action provides information about a pull request,
analogous to `github.pull_request` context in workflows,
triggered by `pull_request` events.

## Usage

```yaml
- uses: tarantool/actions/get-pr-info@master
  id: get-pr-info
  with:
    # Owner of the repository, where the pull request is opened.
    # When working with repo forks, it is the main repo.
    owner: ''
    # Name of the repository, where the pull request is opened.
    repo: ''
    # Number of the pull request.
    pr_number: 42
    # Personal access token (PAT) used to access the GitHub API.
    # Should have read permissions in the target repository.
    # With public repositories or when the pull request is in the same repo
    # as the workflow, ${{ github.token }} should be enough.
    #
    # Default: ${{ github.token }}
    token: ''
    # Whether to set the variables in the GitHub workflow environment,
    # accessible via ${{ env.VAR_NAME }}.
    # Note that existing variables will be overwritten.
    # For details, see the outputs section.
    #
    # Default: 'true'
    set-env: 'true'

- name: Get results as step outputs or env variables
  run: |
    echo 'example'
    echo '${{ steps.get-pr-info.outputs.merge_commit_sha }}'
    echo '${{ env.MERGE_COMMIT_SHA }}'
```

## Outputs

The action outputs a number of variables, similar to those in 
the `github.pull_request` context. They are available as values
in the `${{ steps.get-pr-info.outputs.* }}` variables and also as
the environment variables, if `set-env` is set to `true`.

* `base_repo`, `env.BASE_REPO`: owner/name of the main repository, 
  where the pull request is opened.
* `base_ref`, `env.BASE_REF`: the name of the target branch of the pull request,
  for example, `master` or `main`.
* `base_sha`, `env.BASE_SHA`: the target branch HEAD commit's SHA.
* `head_repo`, `env.HEAD_REPO`: owner/name of the repository with the feature
   branch; can be the same as `base_repo` or a fork repository.
* `head_ref`, `env.HEAD_REF`: the name of the feature branch of the pull request.
* `head_sha`, `env.HEAD_SHA`: the feature branch HEAD commit's SHA.
* `merge_commit_sha`, `env.MERGE_COMMIT_SHA`: SHA of the merge commit that 
  GitHub makes between the base and head branches in each mergeable pull request.
  When base or head branches change, this commit changes as well.