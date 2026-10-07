# shellcheck shell=sh

if command -v aws >/dev/null 2>&1; then
  export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
  export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
fi
