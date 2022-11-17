#!/bin/bash

set -eox pipefail

# HOOK_TYPE="pre-bootstrap"
# HOOK_TYPE="pre-checkout"

echo "Executing bootstrap script"

echo "Creating pre-checkout hook"
cat <<EOF >>/etc/buildkite-agent/hooks/pre-checkout
#!/bin/bash
set -euxo pipefail
# Created on $(date)
echo "--- :evergreen_tree: Pre-Checkout Hook"
env
echo "pre-checkout hook executed successfully"
# buildkite-agent annotate "pre-checkout hook executed successfully 🚀"
EOF

echo "Changing permissions on pre-checkout hook"
sudo chmod +x /etc/buildkite-agent/hooks/pre-checkout

echo "bootstrap script executed successfully"
