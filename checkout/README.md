# Checkout action

Reliably checkout a git repository with submodules.
Uses actions/checkout and supports a subset of its input variables:
`token`, `fetch-depth` and `submodules`. All other inputs are used with the
default values.

This action is intended to be a drop-in replacement for actions/checkout,
improving reliability with submodules and other git repository problems.

Usage:

```diff
  - name: Checkout code
-   uses: actions/checkout@v3
+   uses: tarantool/actions/checkout@master
    # just use the same values for these input variables
    with:
      fetch-depth: 0
      submodules: 'true'
      token: ${{ secrets.REPO_ACCESS_TOKEN }}
```

If a workflow had extra tricks against repository problems, they can now be removed:


```diff
- - name: Cleanup workspace
-   uses: tarantool/actions/cleanup@master

  - name: Checkout code
-   uses: actions/checkout@v3
+   uses: tarantool/actions/checkout@master
    with:
      fetch-depth: 0
      submodules: 'true'
      token: ${{ secrets.REPO_ACCESS_TOKEN }}

- # Work-around for https://github.com/actions/checkout/issues/435
- - name: Update submodules
-   run: |
-     pushd tarantool-${{ matrix.tarantool-branch }}
-     git submodule update --init --recursive --force
-     git fetch origin --prune --progress --recurse-submodules \
-       +refs/heads/*:refs/remotes/origin/* +refs/tags/*:refs/tags/*
-     popd
```