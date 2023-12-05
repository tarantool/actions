# Prepare workspace for checkout action

This action creates and checks out an empty detached commit.
It helps subsequent [`actions/checkout`](https://github.com/actions/checkout) action
correctly clean the workspace.

By default, it also deletes stale references associated with `origin`, which
helps check out the repository without errors like this:
```
error: cannot lock ref 'refs/remotes/origin/<repo>/<branch>': 'refs/remotes/origin/<repo>' exists; cannot create 'refs/remotes/origin/<repo>/<branch>'
 ! [new branch]        <repo>/<branch> -> origin/<repo>/<branch>  (unable to update local ref)
```

## Parameters

- `prune` — delete stale references associated with `origin`. This will
not affect local branches, and it will not change anything remote, but it will
update the local references to remote branches. Submodules are affected as well.
Default: `true`.

## Usage

Add the following line to your workflow before the `actions/checkout` action:

```diff
+ - uses: tarantool/actions/prepare-checkout@master
  - uses: actions/checkout@v3
    ...
```

## Explanation and rationale

This action is a solution for 
[tarantool/tarantool-qa#145](https://github.com/tarantool/tarantool-qa/issues/145).
First attempt to solve this was the `tarantool/actions/cleanup` action.
The `tarantool/actions/prepare-checkout` action is a softer alternative to it.

When submodules change, `actions/checkout` can fail with git errors. 
It's a well-known problem and the related issues are still open:
actions/checkout#354,
actions/checkout#385,
actions/checkout#418, and
actions/checkout#590.

Before checking out a new revision, `actions/checkout` runs the following code:

```bash
# removes ignored and non-versioned files
git clean -ffdx
# resets workspace to the commit, on which it was left
# after the last job run
git reset --hard
```

The problem is that when a workflow fails because of a particular commit,
the repository still stays on that commit. On the next job run, 
`actions/checkout` will run the above code, restore that particular commit,
and fail to make a proper code checkout.

By creating a detached empty commit, this action forces `actions/checkout`
to clean up the project's workspace entirely, removing any files that could
break checkout. Meanwhile, the `.git` directory stays intact, so full checkout
isn't required and the workflow does not waste much time. But sometimes the
`.git` directory also needs a little cleanup, at least all `index.lock` files
must be absent when checking out a repo to not encounter the following error:

```bash
Error: fatal: Unable to create '/<path>/.git/<path>/index.lock': File exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.
```

That's why this action also removes all `index.lock` files in the `.git`
directory to make subsequent checkout successful.

If this is a first job run on a particular runner and there's no repository yet,
the command in this action will silently fail, thanks to `|| :`,
but the action itself will succeed.

This action uses a solution proposed in a
[comment](https://github.com/actions/checkout/issues/590#issuecomment-970586842)
at actions/checkout#590.
