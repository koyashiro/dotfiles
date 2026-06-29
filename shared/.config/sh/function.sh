# shellcheck shell=sh

pull_all_docker_image() {
  docker images | tail -n +2 | awk -v 'OFS=:' '{print $1,$2}' | xargs -P0 -L1 docker pull
}
