# GitHub Action: Create Pull Request for Submodule Update

This action updates a submodule of the target repository in a feature branch and 
opens a pull request against the main branch to commit changes.

If there is an open pull request already, the action will just force-push the 
feature branch.

## Parameters

- `github_token` — the GitHub token of a user with `write` permissions in the 
  target repository. Provide this token as an action secret.
- `submodule` - the submodule path to update in the target repository; define a 
  space-separated list to update a few submodules or leave empty to update all.
- `repository` — the full name of the target repository: `<owner>/<repo>`.
- `checkout_branch` — the target repository branch to checkout.
- `feature_branch` — the target repository feature branch.
- `pr_against_branch` - the target repository branch to open a pull request 
  against; usually the same as `checkout_branch`.
- `pr_title` - the title of the pull request; used as the pull request body 
  as well.
- `commit_user` - the user for the commit.
- `commit_user_email` - the user email for the commit.
- `commit_message` - the message for the commit.

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
  submodule-update:
    name: Submodule update
    runs-on: docker
    env:
      SUBMODULE: 'sm'
      REPOSITORY: 'org/repo'
      CHECKOUT_BRANCH: 'main'
      FEATURE_BRANCH: 'update-submodule'
      PR_AGAINST_BRANCH: 'main'
      PR_TITLE: 'Update submodule <name> on branch <checkout branch>'
      COMMIT_USER: SomeBot
      COMMIT_USER_EMAIL: bot@example.com
      COMMIT_MESSAGE: Bump submodule to new version

    steps:
      - name: Create PR with submodule update
        uses: tarantool/actions/update-submodule@master
        with:
          github_token: ${{ secrets.GH_TOKEN }}
          submodule: ${{ env.SUBMODULE }}
          repository: ${{ env.REPOSITORY }}
          checkout_branch: ${{ env.CHECKOUT_BRANCH }}
          feature_branch: ${{ env.FEATURE_BRANCH }}
          pr_against_branch: ${{ env.PR_AGAINST_BRANCH }}
          pr_title: ${{ env.PR_TITLE }}
          commit_user: ${{ env.COMMIT_USER }}
          commit_user_email: ${{ env.COMMIT_USER_EMAIL }}
          commit_message: ${{ env.COMMIT_MESSAGE }}
```
