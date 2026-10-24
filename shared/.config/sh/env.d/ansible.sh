# shellcheck shell=sh

export ANSIBLE_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ansible/galaxy_cache"
