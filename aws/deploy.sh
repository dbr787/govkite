aws cloudformation create-stack \
  --output json \
  --stack-name buildkite-govkite \
  --template-url "https://s3.amazonaws.com/buildkite-aws-stack/latest/aws-stack.yml" \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
  --parameters "$(cat ./aws/config.json)"
