# GitHub Action: Creates Pull Request when Submodules are Updated

This GitHub action creates a new branch and pull request against the parent repository when submodules are updated.

## Notice
 - This action doesn't create another PR for all merges, commits for on branch, all updates in one PR
 - Name of commit and title and body of PR have same text and can be set by variable TEXT_PULL_REQUEST
 - variable owner can be set as organization
 - branch name for updating can be set in variable PARENT_UPDATED_BRANCH
 - parrent repoitory can be set by secret - ***PARENT_REPOSITORY: '${{ secret.PARENT_REPO }}***

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
      PARENT_UPDATED_BRANCH: 'branch-for-update'
      TEXT_PULL_REQUEST: 'Submodule updated time for renew'
      OWNER: 'owner'

    steps:
      - name: Checkout Code
        uses: actions/checkout@v2

      - name: run action
        id: run_action
        uses: tarantool/actions/update-submodule@master
        with:
          github_token: ${{ secrets.RELEASE_HUB_SECRET }}
          parent_repository: ${{ env.PARENT_REPOSITORY }}
          checkout_branch: ${{ env.CHECKOUT_BRANCH }}
          pr_against_branch: ${{ env.PR_AGAINST_BRANCH }}
          parent_updated_branch: ${{ env.PARENT_UPDATED_BRANCH }}
          text_pull_request: ${{ env.TEXT_PULL_REQUEST }}
          owner: ${{ env.OWNER }}
          branch: ${{ github.head_ref || github.ref_name }}
          current_repo: "${{ github.repository }}"

```
