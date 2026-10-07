if ! command -v mise >/dev/null 2>&1; then
  return
fi

eval "$(mise activate bash)"
# shellcheck disable=SC1090
source <(mise completion bash --include-bash-completion-lib)
