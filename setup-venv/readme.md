# Setup Python virtual environment

Simple usage, given that the requirements file is called `requirements.txt`

```yaml
- uses: tarantool/actions/setup-venv@master
```

Providing the names of virtualenv directory and requirements file:

```yaml
- uses: tarantool/actions/setup-venv@master
  with:
    venv: '.venv'
    requirements: 'requirements-test.txt'
```

Activate the virtual environment with:

```bash
source venv/bin/activate
```

This action is made as a (partial) replacement for
https://github.com/actions/setup-python,
particularly for using on ARM64 machines, where setup-python doesn't work.

Sometimes we don't need to set up the exact version of Python, but rather
need to set up a virtual environment and install a few packages in it.

If `virtualenv` is not found in the system, this action will install it
with `pip install --user`. This way it will not interfere with
system Python packages.
