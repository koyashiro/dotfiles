# shellcheck shell=sh

if command -v docker >/dev/null 2>&1; then
  export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
fi
