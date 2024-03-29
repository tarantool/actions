# GitHub Action: report failed job to VK Teams chat

This action composes a message about the failed job and sends it to the
specified VK Teams chat. The message contains the following information:

* __Job__: name of the failed job with the link to this job
* __Commit__: hash of the commit that triggered the job with the link to
this commit
* __Branch__: name of the branch with the link to this branch
* __History__: link to the commit history
* __Triggered on__: name of the event that triggered the job
* __Committer__: GitHub login of the commit author
* __Commit message subject__: first line of the commit message
* __Failed steps info__: info about the failed steps (outputs, outcome,
conclusion)

# Prepare your workflow

The action can tell you about the failed steps only if your steps have IDs,
for example:

```yaml
steps:
  - name: This step does some useful work
    id: some-useful-work
    run: some useful work

  - name: This step does some other useful work
    id: other-useful-work
    uses: some/additional/action@v1.0
```

# Usage

## Basic usage

Add the following code to the running steps:

```yaml
  - name: Send VK Teams notification
    if: failure()
    uses: tarantool/actions/report-job-status@master
    with:
      bot-token: ${{ secrets.VKTEAMS_BOT_TOKEN }}
      chat-id: ${{ secrets.VKTEAMS_CHAT_ID }}
      job-steps: ${{ ToJson(steps) }}
```
| variable  | how to get                      | example                                |
|-----------|---------------------------------|----------------------------------------|
| api-url   | `/help` in Metabot              | https://myteam.mail.ru/bot/v1          |
| bot-token | API token received from Metabot | `000.1234567890.0987654321:1111111111` |                            
| chat-id   | Can be found in the chat info   | `tntcore_ghaction_chat`                |
| job-steps | Must be `${{ ToJson(steps) }}`  | `${{ ToJson(steps) }}`                 |

## Usage with matrix strategy

In workflows with matrix strategy, jobs have names with matrix options.
Action cannot get this name from GitHub API but needs it to produce
a direct link to job logs.
Provide this name in the `job-name` input variable:

```yaml
- name: Send VK Teams notification
  if: failure()
  uses: tarantool/actions/report-job-status@master
  with:
    bot-token: ${{ secrets.VKTEAMS_BOT_TOKEN }}
    chat-id: ${{ secrets.VKTEAMS_CHAT_ID }}
    job-name: "${{ github.job }} (${{ join(matrix.*, ', ') }})"
```

For this syntax to work, matrix parameters should not be equal to empty strings.
Instead, just skip values, as shown in the [matrix strategy documentation](
https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs#expanding-or-adding-matrix-configurations).
GitHub skips empty strings when making a job name, but the 
`join(matrix.*, ', ')` expression does not skip them.
