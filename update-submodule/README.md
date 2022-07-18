# GitHub Action: Creates Pull Request when Submodules are Updated

This action updates a submodule of the parent repository in a feature branch and opens a pull request against the main branch.

If there is an open PR already, the action will just update and force-push the branch.

## Variables

- `parent_repository` — full name of the repository which has the submodule: `<owner>/<repo>`.
- `owner` — owner of the parent repository.
- `checkout_branch` — the base branch in the parent repository.
- `parent_branch_for_update` — base name for new branches, opened from the base branch in the parent repository.
- `pr_against_branch` is the branch to open PR against; usually the same as `CHECKOUT_BRANCH`.
- `pull_request_text` is used as the commit message, PR title, and PR body.
- `github_token` — GitHub token of a user with `write` permissions in the target (parent) repository. Provide this token as an action secret.

Example workflow:

```yml
---
name: Submodule update

on:
  push:
    branches: 
    - master
    - main

jobs:
  build:
    name: Submodule update
    runs-on: docker
    env:
      PARENT_REPOSITORY: 'org/repo'
      CHECKOUT_BRANCH: 'main'
      PR_AGAINST_BRANCH: 'main'
      PARENT_BRANCH_FOR_UPDATE: 'branch-for-update'
      PULL_REQUEST_TEXT: 'Update submodule <name> on branch <checkout branch>'
      OWNER: 'owner'

    steps:
      - name: Checkout Code
        uses: actions/checkout@v2

      - name: run action
        id: run_action
        uses: tarantool/actions/update-submodule@master
        with:
          github_token: ${{ secrets.PARENT_REPO_TOKEN }}
          parent_repository: ${{ env.PARENT_REPOSITORY }}
          checkout_branch: ${{ env.CHECKOUT_BRANCH }}
          pr_against_branch: ${{ env.PR_AGAINST_BRANCH }}
          parent_branch_for_update: ${{ env.PARENT_BRANCH_FOR_UPDATE }}
          pull_request_text: ${{ env.PULL_REQUEST_TEXT }}
          owner: ${{ env.OWNER }}
          branch: ${{ github.head_ref || github.ref_name }}
          current_repo: "${{ github.repository }}"

```
