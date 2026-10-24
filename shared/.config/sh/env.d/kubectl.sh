# shellcheck shell=sh

export KUBECONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/kube"
export KUBECACHEDIR="${XDG_CACHE_HOME:-$HOME/.cache}/kube"
