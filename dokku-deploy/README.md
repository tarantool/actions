# dokku-deploy

Deploy to a Dokku host using GitHub Actions.
Based on [idoberko2/dokku-deploy-github-action](https://github.com/idoberko2/dokku-deploy-github-action).

## Inputs

### ssh-private-key (required)

The private ssh key used for Dokku deployments. Never use as plain text!
Configure it as a secret in your repository by navigating to
https://github.com/USERNAME/REPO/settings/secrets.

ATTENTION, your private key must *not* have a passphrase.

### ssh-port

Port for ssh host. If not specified, `22` will be used.

### dokku-user

The user to login into the Dokku host. If not specified, "dokku" user will be used.

### dokku-host (required)

The Dokku host to deploy to.

### dokku-app-name (required)

The Dokku app name to be deployed.

### git-remote-branch

The Dokku remote branch to push your branch to. If not specified, `master` will be used.

### git-push-flags

Additional flags to be passed to the git push command. For example, it could be used for force push
if you're pushing to Dokku from other places and encounter the following error:
```
error: failed to push some refs to 'dokku@mydokkuhost.com:mydokkurepo'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

### git-ref

Branch, tag or commit SHA to deploy. If not specified, `$GITHUB_SHA` (current commit) will be used.

## Example

Note: `actions/checkout` must preceed this action in order for the repository data to be exposed
for the action.
It is recommended to pass `actions/checkout` the `fetch-depth: 0` parameter to avoid errors such as
`shallow update not allowed`.

```
steps:
  - uses: actions/checkout@v2
    with:
        fetch-depth: 0
  - id: deploy
    name: Deploy to Dokku
    uses: tarantool/actions/dokku-deploy@master 
    with:
        ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}
        dokku-host: 'my-dokku-host.com'
        dokku-app-name: 'my-dokku-app'
        git-push-flags: '--force'
```
