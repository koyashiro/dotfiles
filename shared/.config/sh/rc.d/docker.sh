# shellcheck shell=sh

alias d=docker

# Docker Compose
alias dc='docker compose'
alias dcb='docker compose build'
alias dcu='docker compose up'
alias dcud='docker compose up --detach'
alias dcd='docker compose down'
alias dcr='docker compose run --rm'
alias dce='docker compose exec'
alias dcp='docker compose pull'
alias dcl='docker compose logs'
alias dclf='docker compose logs --follow --tail 50'

pull_all_docker_image() {
  docker images | tail -n +2 | awk -v 'OFS=:' '{print $1,$2}' | xargs -P0 -L1 docker pull
}
