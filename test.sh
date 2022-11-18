#!/bin/bash
set -euo pipefail

original_json="$1"
echo $1

# if build author is dependabot upsert priority = -1 into all command steps
for line in "$(grep "^BUILDKITE_BUILD_AUTHOR=" "${BUILDKITE_ENV_FILE}")"
do
  author="$(echo "${line}" | cut -d= -f2)"
  if [ "${author}" == "Dependabot" ]
  then
    yq -o=json "(.steps[] | select(has(\"command\"))).priority = -1" $original_json
    exit 0
  fi
done
