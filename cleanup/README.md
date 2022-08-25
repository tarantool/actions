# Clean up workspace directory

This action cleans up the workspace directory after the previous job run. The 
main reason for that is [tarantool/tarantool-qa#145](https://github.com/tarantool/tarantool-qa/issues/145). 
When submodules are changed, the standard checkout action fails with git errors. 
It's a well-known problem and the related issue [actions/checkout#418](https://github.com/actions/checkout/issues/418) 
is still opened.

## How to use GitHub Action from GitHub workflow

Add the following code to the running steps before the `checkout` action:
```
  - uses: tarantool/actions/cleanup@master
```
