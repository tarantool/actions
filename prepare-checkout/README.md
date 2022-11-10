# Prepare workspace for checkout action

This action creates and checks out an empty detached commit.
It helps subsequent [`actions/checkout`](https://github.com/actions/checkout) action
correctly clean the workspace.

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

By creating a detached empty commit, this actions forces `actions/checkout`
to clean up the project's workspace entirely, removing any files that could
break checkout. Meanwhile, the `.git` directory stays intact, so full checkout
isn't required and the workflow does not waste much time.

If this is a first job run on a particular runner and there's no repository yet,
the command in this action will silently fail, thanks to `|| :`,
but the action itself will succeed.

This action uses a solution proposed in a
[comment](https://github.com/actions/checkout/issues/590#issuecomment-970586842)
at actions/checkout#590.
