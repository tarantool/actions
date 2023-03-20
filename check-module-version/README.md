# GitHub Action: Check module version

This action checks the equality of the version from Lua 
module's code and the repository tag that had triggered the workflow.
This action is supposed to work on tag push event only.

## Parameters

- `module-name` — the name of the Lua module.
  The name format as when using require() in tarantool.
- `version-pre-extraction-hook` — the string with Lua code.
  Executed before extracting the version value from _VERSION variable.
  The hook code should not output to STDERR or STDOUT.
- `rock-make-opts` — the rock make options.

## Example workflow:

```yml
name: packaging
on: [...]

jobs:
  version-check:
    runs-on: ubuntu-20.04
    steps:
      - name: Check module version
        # We need to run this step only on push with tag.
        if: github.event_name == 'push' && startsWith(github.ref, 'refs/tags/')
        uses: tarantool/actions/check-module-version@master
        with:
          # Need to use the actual name instead <foobar>.
          module-name: 'foobar'
          # Lua code that does not output to STDERR or STDOUT.
          version-pre-extraction-hook: '...'
          # Rock make options, e.g. STATIC_BUILD=ON.
          rock-make-opts: '...'

  package:
    runs-on: ...
    # Depended on result of the version-check job.
    needs: version-check

    steps:
      - name: ...
      ...
```
