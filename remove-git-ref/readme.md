# Remove git reference

This action removes a git branch,
from a repository on GitHub with an API call.
It is a convenient way to remove temporary branches, like
those created by `tarantool/actions/update-submodule`.

Note: removing tags is not supported yet.

## Usage

```yaml
- uses: tarantool/actions/remove-git-ref@master
  with:
    # Owner of the repository
    owner: ''
    # Name of the repository
    repo: ''
    # Name of the branch to remove, like `example` or `username/example`.
    ref: ''
    # Personal access token (PAT) used to access the GitHub API.
    # Should have write permissions in the target repository.
    token: ''
```
