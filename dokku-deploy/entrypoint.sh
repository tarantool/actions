#!/bin/bash

SSH_PRIVATE_KEY=$1
SSH_PORT=$2
DOKKU_USER=$3
DOKKU_HOST=$4
DOKKU_APP_NAME=$5
GIT_REMOTE_BRANCH=$6
GIT_PUSH_FLAGS=$7
GIT_REF="${8:-$GITHUB_SHA}"

# Setup the SSH environment
mkdir -p ~/.ssh
eval `ssh-agent -s`
ssh-add - <<< "$SSH_PRIVATE_KEY"
ssh-keyscan $DOKKU_HOST >> ~/.ssh/known_hosts

# Setup the git environment
git_repo="$DOKKU_USER@$DOKKU_HOST:$DOKKU_APP_NAME"
cd "$GITHUB_WORKSPACE"
git remote add "$DOKKU_APP_NAME" "$git_repo"

# Prepare to push to Dokku git repository
REMOTE_REF="$GIT_REF:refs/heads/$GIT_REMOTE_BRANCH"

GIT_COMMAND="git push "$DOKKU_APP_NAME" $REMOTE_REF $GIT_PUSH_FLAGS"
echo "GIT_COMMAND=$GIT_COMMAND"

# Push to Dokku git repository
GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p $SSH_PORT" $GIT_COMMAND
