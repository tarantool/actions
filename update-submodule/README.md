# GitHub Action: Creates Pull Request when Submodules are Updated

This action updates a submodule of the parent repository in a feature branch and opens a pull request against the main branch.

## Notice
 - This action doesn't create another PR for all merges, commits for on branch, all updates in one PR
 - Name of commit and title and body of PR have same text and can be set by variable TEXT_PULL_REQUEST
 - variable owner can be set as organization
 - branch name for updating can be set in variable PARENT_BRANCH_FOR_BRANCH
 - parrent repoitory can be set by secret - ***PARENT_REPOSITORY: '${{ secret.PARENT_REPO }}***
 - variable PARENT_REPO_TOKEN is token with permisson to
 - if you need to disable creating PR set `create_pr` false

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
