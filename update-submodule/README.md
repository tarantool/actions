# GitHub Action: Creates Pull Request when Submodules are Updated

This GitHub action creates a new branch and pull request against the parent repository when submodules are updated.


```yml

---
name: Submodule update

on:
  push:
    branches: 
    - master
    - main
    - "2.10"

jobs:
  build:
    name: Submodule update
    runs-on: docker
    env:
      PARENT_REPOSITORY: 'org/repo'
      CHECKOUT_BRANCH: 'main'
      PR_AGAINST_BRANCH: 'main'
      PARENT_UPDATED_BRANCH: 'branch-for-update-'
      TEXT_PULL_REQUEST: 'Submodule updated time for renew'
      OWNER: 'owner'
      BRANCH_NAME: ${{ github.head_ref || github.ref_name }} 

    steps:
      - name: Checkout Code
        uses: actions/checkout@v2

      - name: run action
        id: run_action
        uses: tarantool/action/update-submodule@master
        with:
          github_token: ${{ secrets.RELEASE_HUB_SECRET }}
          parent_repository: ${{ env.PARENT_REPOSITORY }}
          checkout_branch: ${{ env.CHECKOUT_BRANCH }}
          pr_against_branch: ${{ env.PR_AGAINST_BRANCH }}
          parent_updated_branch: ${{ env.PARENT_UPDATED_BRANCH }}
          text_pull_request: ${{ env.TEXT_PULL_REQUEST }}
          owner: ${{ env.OWNER }}
          branch: ${{ env.BRANCH_NAME }}

```
