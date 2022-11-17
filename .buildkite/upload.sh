set -eo pipefail

# Create yq alias in bootstrap
# Add if statements for relevant BUILDKITE_VARS
# Use script as an agent hook
# Could instead be a plugin?
# Could alias/wrap the buildkite-agent pipeline upload command

echo "--- :hammer: Running Governed Pipeline Upload"

governed-pipeline-upload () {
  if [ -z ${var+x} ]; then echo "var is unset"; else echo "var is set to '$var'"; fi

  commands

}

echo "original pipeline.yml"
cat .buildkite/pipeline.yml

echo "dry-run output to json file"
buildkite-agent pipeline upload --dry-run > pipeline_output.json
cat pipeline_output.json

echo "yq json file to override output file"
OVERRIDE_PRIORITY=-1
docker run --rm -v "${PWD}":/workdir mikefarah/yq -o=json "(.steps[] | select(has(\"command\"))).priority = $OVERRIDE_PRIORITY" pipeline_output.json > override_output.json
cat override_output.json

echo "upload override file"
buildkite-agent pipeline upload override_output.json


# echo "yq pipeline.yml"
# docker run --rm -v "${PWD}":/workdir mikefarah/yq -C "." .buildkite/pipeline.yml
# echo "override priority"
# OVERRIDE_PRIORITY="-1"
# docker run --rm -v "${PWD}":/workdir mikefarah/yq -C "(.steps[] | select(has(\"command\"))).priority = \"$OVERRIDE_PRIORITY\"" .buildkite/pipeline.yml
# echo "buildkite-agent pipeline upload dry-run"
# buildkite-agent pipeline upload --dry-run
# echo "dry-run output to file"
# buildkite-agent pipeline upload --dry-run > pipeline_output.json
# echo "yq dry-run json to yaml (file cat)"
# docker run --rm -v "${PWD}":/workdir mikefarah/yq -P "." pipeline_output.json > pipeline_output.yaml
# cat pipeline_output.yaml

# echo "yq override file"
# OVERRIDE_PRIORITY="-1"
# docker run --rm -v "${PWD}":/workdir mikefarah/yq -C "(.steps[] | select(has(\"command\"))).priority = \"$OVERRIDE_PRIORITY\"" pipeline_output.yaml > pipeline_override.yaml
# cat pipeline_override.yaml
# echo "upload pipeline with overrides"
# buildkite-agent pipeline upload pipeline_override.yaml
# echo "upload pipeline json"
# buildkite-agent pipeline upload pipeline_override.yaml
# buildkite-agent pipeline upload pipeline_output.json
# buildkite-agent pipeline upload
#  | docker run --rm -v "${PWD}":/workdir mikefarah/yq -C "(.steps[] | select(has(\"command\"))).priority = $OVERRIDE_PRIORITY"
# OVERRIDE_PRIORITY=-1
# docker run --rm -v "${PWD}":/workdir mikefarah/yq -C "(.steps[] | select(has(\"command\"))).priority = $OVERRIDE_PRIORITY" pipeline_output.json


# buildkite-agent pipeline upload --dry-run | docker run --rm -v "${PWD}":/workdir mikefarah/yq -C "(.steps[] | select(has(\"command\"))).priority = $OVERRIDE_PRIORITY" | buildkite-agent pipeline upload

# docker run --rm -v "${PWD}":/workdir mikefarah/yq \
# '.steps[] *=n load("defaults.yaml").steps' \
# pipeline.yaml


# yq '.layouts | map(select(.layout == "gb"))'

# This appears to select every command step
# docker run --rm -v "${PWD}":/workdir mikefarah/yq -C '.steps | map(select(.command))' pipeline2.yml
# yq -C '.steps | map(select(.command))' pipeline2.yml
# yq -C '.steps[].priority = 1' pipeline2.yml
# This seems to add/update every command step to include priority = 1

# docker run --rm -v "${PWD}":/workdir mikefarah/yq -C "(.steps[] | select(has(\"command\"))).priority = \"$OVERRIDE_PRIORITY\"" ./yaml-examples/test.json