# GitHub Action: Setup etcd

This action sets up an etcd store from [a release archive](https://github.com/etcd-io/etcd/releases).

# Usage

## Parameters

- `version` — Release archive version (for example, `v3.5.10`).
  Defaults to `v3.5.12`.
- `platform` — Release archive platform (`amd64` or `arm64`).
  Defaults to `amd64`.
- `install-prefix` — Release archive installation directory.
  Defaults to `${{ github.workspace }}/.etcd/bin/`.

## Example

```yml
- name: Set up etcd
  uses: tarantool/actions/setup-etcd@master
  with:
    version: v3.5.10
```
