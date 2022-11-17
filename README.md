# govkite

This project demonstrates how pipeline governance can be achieved with Buildkite.  

- Any agent machine image or bootstrap will clone a shared controlled repository containing the replacement `buildkite-agent upload` command. This command/function should be created as a bash alias and used instead of buildkite-agent upload.

- Using a pre-checkout agent hook to only allow specific commands to be run.
  - This hook script will be stored in a github repository, so the latest version will always be used.