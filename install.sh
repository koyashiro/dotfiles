#!/usr/bin/env sh

set -euf
unset CDPATH

usage() {
  cat <<EOF
Install script for koyashiro's dotfiles.

Usage:
    install.sh [OPTIONS]

Without --add, --remove, --all or --list, an interactive selector opens
(requires a terminal). Apps unchecked there are uninstalled: their links are
removed and any <path>.bak backups are restored.

Options:
    --add <app>[,<app>...]     Install the given apps (repeatable); others are left as is
    --remove <app>[,<app>...]  Uninstall the given apps (repeatable); others are left as is
    --all                      Install all apps
    --list                     List apps and whether they are installed
    --dry-run                  Show what would be done without changing anything
    -v, --verbose              Also show links that are already in place
    -h, --help                 Print help

Apps:
$(echo "${APPS}" | sed 's/ /, /g' | fold -s -w 72 | sed 's/ *$//; s/^/    /')
EOF
}

# Apps that can be installed. Each app is a set of paths relative to both
# "${DOTDIR}/shared" (link source) and "${HOME}" (link destination).
APPS='act actionlint agents alacritty ansible aws bash bash-language-server bat bun c cargo-atcoder claude delta deno direnv dive docker eslint eza fd fontconfig fzf git github-cli go hadolint herdr jq kubectl less lua markdownlint-cli2 mise mysql node nvim oxfmt oxlint peco pinact pnpm postgresql prettier readline redis ripgrep rust sh shellcheck shfmt sqlite3 stylelint stylua tig tmux typescript vim wasmer wasmtime yarn yq zsh'

app_paths() {
  case "$1" in
    act)
      echo .config/mise/conf.d/act.toml
      ;;
    actionlint)
      echo .config/mise/conf.d/actionlint.toml
      ;;
    agents)
      echo .config/agents/AGENTS.md
      ;;
    alacritty)
      echo .config/alacritty/alacritty.toml
      ;;
    ansible)
      echo .config/sh/env.d/ansible.sh
      ;;
    aws)
      echo .config/mise/conf.d/aws.toml
      echo .config/sh/env.d/aws.sh
      ;;
    bash)
      echo .bash_profile
      echo .bashrc
      ;;
    bash-language-server)
      echo .config/mise/conf.d/bash-language-server.toml
      ;;
    bat)
      echo .config/mise/conf.d/bat.toml
      ;;
    bun)
      echo .config/mise/conf.d/bun.toml
      ;;
    c)
      echo .config/mise/conf.d/c.toml
      ;;
    cargo-atcoder)
      echo .config/cargo-atcoder.toml
      ;;
    claude)
      echo .config/claude/CLAUDE.md
      echo .config/claude/commands
      echo .config/claude/settings.json
      echo .config/sh/env.d/claude.sh
      ;;
    delta)
      echo .config/mise/conf.d/delta.toml
      echo .config/git/delta.gitconfig
      ;;
    deno)
      echo .config/mise/conf.d/deno.toml
      echo .config/sh/env.d/deno.sh
      ;;
    direnv)
      echo .config/sh/env.d/direnv.sh
      echo .config/bash/rc.d/direnv.bash
      echo .config/zsh/rc.d/direnv.zsh
      ;;
    dive)
      echo .config/mise/conf.d/dive.toml
      ;;
    docker)
      echo .config/sh/env.d/docker.sh
      echo .config/sh/rc.d/docker.sh
      echo .config/zsh/rc.d/docker.zsh
      ;;
    eslint)
      echo .config/mise/conf.d/eslint.toml
      ;;
    eza)
      echo .config/mise/conf.d/eza.toml
      echo .config/sh/rc.d/eza.sh
      ;;
    fd)
      echo .config/mise/conf.d/fd.toml
      ;;
    fontconfig)
      echo .config/fontconfig/fonts.conf
      ;;
    fzf)
      echo .config/mise/conf.d/fzf.toml
      echo .config/sh/env.d/fzf.sh
      echo .config/zsh/rc.d/fzf.zsh
      ;;
    git)
      echo .config/git/config
      echo .config/git/ignore
      echo .config/git/prune-merged.sh
      echo .config/sh/rc.d/git.sh
      echo .config/zsh/rc.d/git.zsh
      ;;
    github-cli)
      echo .config/mise/conf.d/github-cli.toml
      ;;
    go)
      echo .config/mise/conf.d/go.toml
      echo .config/sh/env.d/go.sh
      ;;
    hadolint)
      echo .config/mise/conf.d/hadolint.toml
      ;;
    herdr)
      echo .config/herdr/config.toml
      ;;
    jq)
      echo .config/mise/conf.d/jq.toml
      ;;
    kubectl)
      echo .config/sh/env.d/kubectl.sh
      echo .config/sh/rc.d/kubectl.sh
      ;;
    less)
      echo .config/sh/env.d/less.sh
      ;;
    lua)
      echo .config/mise/conf.d/lua.toml
      ;;
    markdownlint-cli2)
      echo .config/mise/conf.d/markdownlint-cli2.toml
      ;;
    mise)
      echo .config/mise/conf.d/mise.toml
      echo .config/sh/env.d/mise.sh
      echo .config/bash/rc.d/mise.bash
      echo .config/zsh/rc.d/mise.zsh
      ;;
    mysql)
      echo .config/sh/env.d/mysql.sh
      ;;
    node)
      echo .config/mise/conf.d/node.toml
      echo .config/npm/npmrc
      echo .config/sh/env.d/node.sh
      ;;
    nvim)
      echo .config/nvim/ginit.vim
      echo .config/nvim/init.lua
      echo .config/nvim/lazy-lock.json
      echo .config/nvim/lua
      echo .config/sh/rc.d/nvim.sh
      ;;
    oxfmt)
      echo .config/mise/conf.d/oxfmt.toml
      ;;
    oxlint)
      echo .config/mise/conf.d/oxlint.toml
      ;;
    peco)
      echo .config/peco/config.json
      ;;
    pinact)
      echo .config/mise/conf.d/pinact.toml
      ;;
    pnpm)
      echo .config/mise/conf.d/pnpm.toml
      ;;
    postgresql)
      echo .config/sh/env.d/postgresql.sh
      ;;
    prettier)
      echo .config/mise/conf.d/prettier.toml
      ;;
    readline)
      echo .config/readline/inputrc
      echo .config/sh/env.d/readline.sh
      ;;
    redis)
      echo .config/sh/env.d/redis.sh
      ;;
    ripgrep)
      echo .config/mise/conf.d/ripgrep.toml
      echo .config/sh/rc.d/ripgrep.sh
      ;;
    rust)
      echo .config/sh/env.d/rust.sh
      echo .config/zsh/rc.d/rust.zsh
      ;;
    sh)
      echo .profile
      echo .config/sh/env.sh
      echo .config/sh/rc.sh
      ;;
    shellcheck)
      echo .config/mise/conf.d/shellcheck.toml
      ;;
    shfmt)
      echo .config/mise/conf.d/shfmt.toml
      ;;
    sqlite3)
      echo .config/sqlite3/sqliterc
      echo .config/sh/env.d/sqlite3.sh
      echo .config/sh/rc.d/sqlite3.sh
      ;;
    stylelint)
      echo .config/mise/conf.d/stylelint.toml
      ;;
    stylua)
      echo .config/mise/conf.d/stylua.toml
      ;;
    tig)
      echo .config/tig/config
      echo .config/sh/env.d/tig.sh
      ;;
    tmux)
      echo .config/tmux/tmux.conf
      echo .config/sh/rc.d/tmux.sh
      ;;
    typescript)
      echo .config/mise/conf.d/typescript.toml
      echo .config/sh/env.d/typescript.sh
      ;;
    vim)
      echo .vimrc
      echo .config/sh/rc.d/vim.sh
      ;;
    wasmer)
      echo .config/sh/env.d/wasmer.sh
      ;;
    wasmtime)
      echo .config/sh/env.d/wasmtime.sh
      ;;
    yarn)
      echo .config/mise/conf.d/yarn.toml
      ;;
    yq)
      echo .config/mise/conf.d/yq.toml
      ;;
    zsh)
      echo .zshenv
      echo .zshrc
      echo .config/zsh/.p10k.zsh
      echo .config/zsh/autoload.zsh
      echo .config/zsh/bindkey.zsh
      echo .config/zsh/setopt.zsh
      echo .config/zsh/zinit.zsh
      echo .config/zsh/zle.zsh
      echo .config/zsh/zstyle.zsh
      ;;
    *)
      return 1
      ;;
  esac
}

ESC="$(printf '\033')"
CR="$(printf '\r')"
TAB="$(printf '\t')"
NL='
'

DRY_RUN=''
VERBOSE=''
ADD_ALL=''
LIST=''
REMOVE=''
ADD=''
FAILED=''
UNINSTALLED=''
# Lines of "<app><TAB><path>" read from the state file
RECORD=''
REMOVED_APPS=''
OK_APPS=''
KEPT_RECORD=''
DRY_RUN_DIRS=''

N_INSTALLED=0
N_UP_TO_DATE=0
N_UNINSTALLED=0
N_LINKED=0
N_BACKED_UP=0
N_UNCHANGED=0
N_REMOVED=0
N_RESTORED=0

# Colors only on a terminal and when NO_COLOR is unset or empty (no-color.org).
COLOR_OUT=''
COLOR_ERR=''

setup_colors() {
  if [ -n "${NO_COLOR:-}" ]; then
    return
  fi
  if [ -t 1 ]; then
    COLOR_OUT='1'
  fi
  if [ -t 2 ]; then
    COLOR_ERR='1'
  fi
}

sgr_out() {
  if [ -n "${COLOR_OUT}" ]; then
    printf '\033[%sm' "$1"
  fi
}

sgr_err() {
  if [ -n "${COLOR_ERR}" ]; then
    printf '\033[%sm' "$1"
  fi
}

error() {
  printf "%serror:%s %s\n" "$(sgr_err '1;31')" "$(sgr_err 0)" "$*" >&2
}

warn() {
  printf "%swarning:%s %s\n" "$(sgr_err '1;33')" "$(sgr_err 0)" "$*" >&2
}

note() {
  printf "%snote:%s %s\n" "$(sgr_err '1;36')" "$(sgr_err 0)" "$*" >&2
}

status() {
  printf "%s%12s%s %s\n" "$(sgr_out "$1")" "$2" "$(sgr_out 0)" "$3"
}

pretty() {
  case "$1" in
    "${DOTDIR}"/*) echo "${1#"${DOTDIR}"/}" ;;
    "${HOME}") echo '~' ;;
    "${HOME}"/*) printf '%s/%s\n' '~' "${1#"${HOME}"/}" ;;
    *) echo "$1" ;;
  esac
}

plural() {
  if [ "$1" -eq 1 ]; then
    echo "$1 $2"
  else
    echo "$1 $2s"
  fi
}

summary_item() {
  if [ "$1" -gt 0 ]; then
    summary="${summary:+${summary}, }$2"
  fi
}

print_summary() {
  n_failed=0
  for app in ${FAILED}; do
    n_failed=$((n_failed + 1))
  done

  summary=''
  summary_item "${N_INSTALLED}" "$(plural "${N_INSTALLED}" app) installed"
  if [ "${N_INSTALLED}" -eq 0 ]; then
    summary_item "${N_UP_TO_DATE}" "$(plural "${N_UP_TO_DATE}" app) up to date"
  else
    summary_item "${N_UP_TO_DATE}" "${N_UP_TO_DATE} up to date"
  fi
  summary_item "${N_UNINSTALLED}" "${N_UNINSTALLED} uninstalled"
  summary_item "${n_failed}" "${n_failed} failed"
  apps="${summary:-nothing to do}"

  summary=''
  summary_item "${N_LINKED}" "${N_LINKED} linked"
  summary_item "${N_BACKED_UP}" "${N_BACKED_UP} backed up"
  if [ -n "${VERBOSE}" ]; then
    summary_item "${N_UNCHANGED}" "${N_UNCHANGED} unchanged"
  fi
  summary_item "${N_REMOVED}" "${N_REMOVED} removed"
  summary_item "${N_RESTORED}" "${N_RESTORED} restored"

  if [ -n "${DRY_RUN}" ]; then
    apps="(dry run) ${apps}"
  fi
  if [ -n "${summary}" ]; then
    status '1;32' Finished "${apps} (${summary})"
  else
    status '1;32' Finished "${apps}"
  fi
}

run() {
  if [ -z "${DRY_RUN}" ]; then
    "$@"
  fi
}

contains() {
  case " $1 " in
    *" $2 "*) return 0 ;;
  esac
  return 1
}

exists_or_link() {
  [ -e "$1" ] || [ -L "$1" ]
}

physical_path() {
  physical_dir="$(cd -P "$(dirname "$1")" 2>/dev/null && pwd -P)" || return 1
  echo "${physical_dir}/$(basename "$1")"
}

# The repository may have been linked through a symlinked path (e.g. an old
# ~/.dotfiles), so compare physical paths rather than link text.
is_repo_link() {
  [ -L "$1" ] || return 1
  link_target="$(readlink "$1")"
  case "${link_target}" in
    /*) ;;
    *) link_target="$(dirname "$1")/${link_target}" ;;
  esac
  [ "$(physical_path "${link_target}")" = "$2" ]
}

normalize_apps() {
  normalized=''
  for app in ${APPS} ${REMOVED_APPS}; do
    if contains "$*" "${app}"; then
      normalized="${normalized:+${normalized} }${app}"
    fi
  done
  echo "${normalized}"
}

set_envs() {
  DOTDIR="$(cd -P "$(dirname "$0")" && pwd -P)"
  STATE_DIR="${HOME}/.local/share/dotfiles"
  STATE_FILE="${STATE_DIR}/installed"
}

# Mode 0700, as the XDG Base Directory Specification recommends.
make_dirs() {
  if [ -d "$1" ] || contains "${DRY_RUN_DIRS}" "$1"; then
    return
  fi
  make_dirs "$(dirname "$1")" || return 1
  run mkdir -m 700 "$1" || return 1
  if [ -n "${DRY_RUN}" ]; then
    DRY_RUN_DIRS="${DRY_RUN_DIRS} $1"
  fi
  created_dirs="${1#"${HOME}"/} ${created_dirs:-}"
  status '1;32' Creating "$(pretty "$1")/"
}

create_xdg_base_directories_if_needed() {
  make_dirs "${HOME}/.config"
  make_dirs "${HOME}/.cache"
  make_dirs "${HOME}/.local/share"
  make_dirs "${HOME}/.local/state"
  make_dirs "${HOME}/.local/bin"
}

parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      --add | --remove)
        if [ $# -lt 2 ]; then
          error "'$1' requires an app name"
          exit 1
        fi
        case "$2" in
          *[!,\ ]*) ;;
          *)
            error "'$1' requires an app name"
            exit 1
            ;;
        esac
        if [ "$1" = --add ]; then
          ADD="${ADD} $(echo "$2" | tr ',' ' ')"
        else
          REMOVE="${REMOVE} $(echo "$2" | tr ',' ' ')"
        fi
        shift
        ;;
      --all)
        ADD_ALL='1'
        ;;
      --list)
        LIST='1'
        ;;
      --dry-run)
        DRY_RUN='1'
        ;;
      -v | --verbose)
        VERBOSE='1'
        ;;
      --help | -h)
        usage
        exit
        ;;
      *)
        error "unexpected option '$1'"
        echo >&2
        usage >&2
        exit 1
        ;;
    esac

    shift
  done

  for app in ${ADD}; do
    if ! contains "${APPS}" "${app}"; then
      error "unknown app '${app}'"
      exit 1
    fi
  done
  if [ -n "${LIST}" ] && [ -n "${ADD}${REMOVE}${ADD_ALL}" ]; then
    error "'--list' cannot be combined with --add, --remove or --all"
    exit 1
  fi
  for app in ${REMOVE}; do
    if contains "${ADD}" "${app}" || { [ -n "${ADD_ALL}" ] && contains "${APPS}" "${app}"; }; then
      error "'${app}' is given to both --add and --remove"
      exit 1
    fi
  done
}

list_apps() {
  for app in ${APPS} ${REMOVED_APPS}; do
    label="${app}"
    if contains "${REMOVED_APPS}" "${app}"; then
      label="${app} (removed)"
    fi
    if contains "${installed}" "${app}"; then
      printf '  [x] %s\n' "${label}"
    else
      printf '  %s[ ] %s%s\n' "$(sgr_out 2)" "${label}" "$(sgr_out 0)"
    fi
  done
}

# Without a state file (first run), treat apps whose links all point into the
# repository as installed.
load_installed() {
  installed=''
  if [ -f "${STATE_FILE}" ]; then
    state_file_display="$(pretty "${STATE_FILE}")"
    lineno=0
    while IFS= read -r line || [ -n "${line}" ]; do
      lineno=$((lineno + 1))
      case "${line}" in
        ?*"${TAB}"?*) ;;
        *)
          error "${state_file_display}:${lineno}: expected '<app><TAB><path>'"
          exit 1
          ;;
      esac
      app="${line%%"${TAB}"*}"
      RECORD="${RECORD}${line}${NL}"
      if ! contains "${installed}" "${app}"; then
        installed="${installed} ${app}"
      fi
      if ! contains "${APPS}" "${app}" && ! contains "${REMOVED_APPS}" "${app}"; then
        REMOVED_APPS="${REMOVED_APPS} ${app}"
      fi
    done <"${STATE_FILE}"
    installed="$(normalize_apps "${installed}")"
    return
  fi
  detected=''
  for app in ${APPS}; do
    linked=''
    for path in $(app_paths "${app}"); do
      if ! is_repo_link "${HOME}/${path}" "${DOTDIR}/shared/${path}"; then
        linked=''
        break
      fi
      linked='1'
    done
    if [ -n "${linked}" ]; then
      detected="${detected} ${app}"
      for path in $(app_paths "${app}"); do
        RECORD="${RECORD}${app}${TAB}${path}${NL}"
      done
    fi
  done
  installed="$(normalize_apps "${detected}")"
}

recorded_paths() {
  printf '%s' "${RECORD}" | while IFS="${TAB}" read -r rec_app rec_path; do
    if [ "${rec_app}" = "$1" ]; then
      echo "${rec_path}"
    fi
  done
}

# Recorded paths that the app no longer defines
stale_paths() {
  current="$(app_paths "$1" | tr '\n' ' ')"
  for path in $(recorded_paths "$1"); do
    if ! contains "${current}" "${path}"; then
      echo "${path}"
    fi
  done
}

save_installed() {
  if [ -n "${DRY_RUN}" ]; then
    return
  fi
  make_dirs "${STATE_DIR}"
  for app in $1; do
    if contains "${OK_APPS}" "${app}"; then
      for path in $(app_paths "${app}"); do
        printf '%s\t%s\n' "${app}" "${path}"
      done
      printf '%s' "${KEPT_RECORD}" | while IFS="${TAB}" read -r rec_app rec_path; do
        if [ "${rec_app}" = "${app}" ]; then
          printf '%s\t%s\n' "${app}" "${rec_path}"
        fi
      done
    else
      for path in $(recorded_paths "${app}"); do
        printf '%s\t%s\n' "${app}" "${path}"
      done
    fi
  done >"${STATE_FILE}.tmp"
  mv "${STATE_FILE}.tmp" "${STATE_FILE}"
}

check_app() {
  check_ok='1'
  bad_parents=''
  for path in $(app_paths "$1"); do
    src="${DOTDIR}/shared/${path}"
    dst="${HOME}/${path}"

    if ! exists_or_link "${src}"; then
      error "$1: source not found: $(pretty "${src}")"
      check_ok=''
      continue
    fi

    # A parent directory that resolves into the repository (e.g. an old
    # whole-directory link) would make us back up the repository's own file.
    parent="$(dirname "${dst}")"
    while ! exists_or_link "${parent}"; do
      parent="$(dirname "${parent}")"
    done
    if ! [ -d "${parent}" ] || ! parent_real="$(cd -P "${parent}" 2>/dev/null && pwd -P)"; then
      if ! contains "${bad_parents}" "${parent}"; then
        error "$1: not an accessible directory: $(pretty "${parent}")"
        bad_parents="${bad_parents} ${parent}"
      fi
      check_ok=''
      continue
    fi
    case "${parent_real}/" in
      "${DOTDIR}"/*)
        if ! contains "${bad_parents}" "${parent}"; then
          error "$1: parent directory resolves into the repository: $(pretty "${parent}") -> $(pretty "${parent_real}")"
          bad_parents="${bad_parents} ${parent}"
        fi
        check_ok=''
        continue
        ;;
    esac

    if is_repo_link "${dst}" "${src}"; then
      continue
    fi
    if exists_or_link "${dst}" && exists_or_link "${dst}.bak"; then
      error "$1: backup already exists: $(pretty "${dst}.bak")"
      check_ok=''
    fi
  done
  [ -n "${check_ok}" ]
}

is_up_to_date() {
  for path in $(app_paths "$1"); do
    if ! is_repo_link "${HOME}/${path}" "${DOTDIR}/shared/${path}"; then
      return 1
    fi
  done
  for path in $(stale_paths "$1"); do
    if is_our_link "${HOME}/${path}" "${DOTDIR}/shared/${path}"; then
      return 1
    fi
  done
}

# Also accept a dangling link whose text points at the source, for apps or
# paths that were removed from the repository.
is_our_link() {
  is_repo_link "$1" "$2" || { [ -L "$1" ] && [ "$(readlink "$1")" = "$2" ]; }
}

show_linked() {
  if [ -n "${VERBOSE}" ]; then
    status 2 Linked "$(pretty "$1") -> $(pretty "$2")"
  fi
  N_UNCHANGED=$((N_UNCHANGED + 1))
}

install_app() {
  if is_up_to_date "$1"; then
    status 2 'Up to date' "$1"
    for path in $(app_paths "$1"); do
      show_linked "${HOME}/${path}" "${DOTDIR}/shared/${path}"
    done
    N_UP_TO_DATE=$((N_UP_TO_DATE + 1))
    OK_APPS="${OK_APPS} $1"
    return
  fi

  status 1 Installing "$1"

  if ! check_app "$1"; then
    status '1;33' Skipped "$1"
    FAILED="${FAILED} $1"
    return
  fi

  linked_paths=''
  created_dirs=''
  backed_up_paths=''
  for path in $(app_paths "$1"); do
    src="${DOTDIR}/shared/${path}"
    dst="${HOME}/${path}"

    if is_repo_link "${dst}" "${src}"; then
      show_linked "${dst}" "${src}"
      continue
    fi
    if exists_or_link "${dst}"; then
      if ! run mv "${dst}" "${dst}.bak"; then
        rollback_app "$1" "could not back up $(pretty "${dst}")"
        return
      fi
      status '1;33' 'Backing up' "$(pretty "${dst}") -> $(pretty "${dst}.bak")"
      backed_up_paths="${backed_up_paths} ${path}"
    fi
    if ! make_dirs "$(dirname "${dst}")" || ! run ln -s "${src}" "${dst}"; then
      rollback_app "$1" "could not link $(pretty "${dst}")"
      return
    fi
    status '1;32' Linking "$(pretty "${dst}") -> $(pretty "${src}")"
    linked_paths="${linked_paths} ${path}"
  done
  for path in ${linked_paths}; do
    N_LINKED=$((N_LINKED + 1))
  done
  for path in ${backed_up_paths}; do
    N_BACKED_UP=$((N_BACKED_UP + 1))
  done
  for path in $(stale_paths "$1"); do
    if ! unlink_path "$1" "${path}"; then
      KEPT_RECORD="${KEPT_RECORD}$1${TAB}${path}${NL}"
    fi
  done
  N_INSTALLED=$((N_INSTALLED + 1))
  OK_APPS="${OK_APPS} $1"
}

rollback_app() {
  error "$1: $2"
  for path in ${linked_paths}; do
    if run rm "${HOME}/${path}"; then
      status '1;31' Removing "$(pretty "${HOME}/${path}")"
    fi
  done
  for path in ${backed_up_paths}; do
    if run mv "${HOME}/${path}.bak" "${HOME}/${path}"; then
      status '1;33' Restoring "$(pretty "${HOME}/${path}.bak") -> $(pretty "${HOME}/${path}")"
    fi
  done
  for dir in ${created_dirs}; do
    if run rmdir "${HOME}/${dir}" 2>/dev/null; then
      status '1;31' Removing "$(pretty "${HOME}/${dir}")/"
    fi
  done
  status '1;31' Failed "$1"
  FAILED="${FAILED} $1"
}

# unlink_path <app> <path>: remove the link to the repository and restore the
# backup; returns non-zero after reporting a failure
unlink_path() {
  src="${DOTDIR}/shared/$2"
  dst="${HOME}/$2"

  if ! is_our_link "${dst}" "${src}"; then
    if exists_or_link "${dst}"; then
      warn "$1: not a link to the repository, left as is: $(pretty "${dst}")"
    fi
    return 0
  fi

  if ! run rm "${dst}"; then
    error "$1: could not remove $(pretty "${dst}")"
    return 1
  fi
  status '1;31' Removing "$(pretty "${dst}")"
  N_REMOVED=$((N_REMOVED + 1))
  if exists_or_link "${dst}.bak"; then
    if ! run mv "${dst}.bak" "${dst}"; then
      error "$1: could not restore $(pretty "${dst}.bak")"
      return 1
    fi
    status '1;33' Restoring "$(pretty "${dst}.bak") -> $(pretty "${dst}")"
    N_RESTORED=$((N_RESTORED + 1))
  fi
}

uninstall_app() {
  status 1 Uninstalling "$1"

  for path in $(recorded_paths "$1"); do
    if ! unlink_path "$1" "${path}"; then
      status '1;31' Failed "$1"
      FAILED="${FAILED} $1"
      return
    fi
  done
  UNINSTALLED="${UNINSTALLED} $1"
  N_UNINSTALLED=$((N_UNINSTALLED + 1))
}

has_tty() {
  (exec </dev/tty) 2>/dev/null
}

tui_restore() {
  if [ -n "${tui_reader:-}" ]; then
    kill "${tui_reader}" 2>/dev/null || true
    tui_reader=''
  fi
  if [ -n "${tui_key_file:-}" ]; then
    rm -f "${tui_key_file}"
    tui_key_file=''
  fi
  if [ -n "${tui_stty:-}" ]; then
    stty "${tui_stty}" </dev/tty
    tui_stty=''
  fi
  printf '\033[?25h' >/dev/tty
}

# Signal traps do not run while the shell waits for a command substitution, so
# the key is read by a background job that `wait` can be interrupted from.
tui_read_key() {
  dd bs=1 count=1 2>/dev/null </dev/tty >"${tui_key_file}" &
  tui_reader=$!
  wait "${tui_reader}" || true
  tui_reader=''
  key="$(
    cat "${tui_key_file}"
    printf x
  )"
  key="${key%x}"
  if [ "${key}" = "${ESC}" ]; then
    # Arrow keys arrive at once; a lone Esc gets nothing within 0.1s.
    stty min 0 time 1 </dev/tty
    key="${ESC}$(dd bs=1 count=2 2>/dev/null </dev/tty)"
    stty min 1 time 0 </dev/tty
  fi
}

sgr_tty() {
  if [ -z "${NO_COLOR:-}" ]; then
    printf '\033[%sm' "$1"
  fi
}

# Fit the list into the terminal: header, "more" markers and help take 4 lines,
# and one more is kept so that the final newline does not scroll the screen.
tui_resize() {
  rows="$(stty size </dev/tty | cut -d ' ' -f 1)"
  # Some terminals report 0 rows when the size is unknown.
  if [ "${rows:-0}" -le 0 ]; then
    rows=24
  fi
  visible=$((rows - 5))
  if [ "${visible}" -gt "${count}" ]; then
    visible="${count}"
  fi
  if [ "${visible}" -lt 1 ]; then
    visible=1
  fi
}

tui_scroll() {
  if [ "${cursor}" -lt "${top}" ]; then
    top="${cursor}"
  elif [ "${cursor}" -ge $((top + visible)) ]; then
    top=$((cursor - visible + 1))
  fi
}

tui_draw() {
  if [ "${top}" -gt 0 ]; then
    printf '\r\033[2K  %s↑ more%s\n' "$(sgr_tty 2)" "$(sgr_tty 0)"
  else
    printf '\r\033[2K\n'
  fi
  i=0
  for app in ${APPS} ${REMOVED_APPS}; do
    if [ "${i}" -ge "${top}" ] && [ "${i}" -lt $((top + visible)) ]; then
      if contains "${selected}" "${app}"; then
        mark='x'
      else
        mark=' '
      fi
      label="${app}"
      if contains "${REMOVED_APPS}" "${app}"; then
        label="${app} (removed)"
      fi
      if [ "${i}" -eq "${cursor}" ]; then
        printf '\r\033[2K%s> [%s] %s%s\n' "$(sgr_tty 7)" "${mark}" "${label}" "$(sgr_tty 0)"
      else
        printf '\r\033[2K  [%s] %s\n' "${mark}" "${label}"
      fi
    fi
    i=$((i + 1))
  done
  if [ $((top + visible)) -lt "${count}" ]; then
    printf '\r\033[2K  %s↓ more%s\n' "$(sgr_tty 2)" "$(sgr_tty 0)"
  else
    printf '\r\033[2K\n'
  fi
  printf '\r\033[2K%s↑/↓ or j/k: move  Space: toggle  Enter: apply  q: quit%s\n' \
    "$(sgr_tty 2)" "$(sgr_tty 0)"
}

tui_toggle() {
  i=0
  for app in ${APPS} ${REMOVED_APPS}; do
    if [ "${i}" -eq "${cursor}" ]; then
      if contains "${selected}" "${app}"; then
        rest=''
        for s in ${selected}; do
          if [ "${s}" != "${app}" ]; then
            rest="${rest} ${s}"
          fi
        done
        selected="${rest}"
      else
        selected="${selected} ${app}"
      fi
      return
    fi
    i=$((i + 1))
  done
}

tui_select() {
  selected="$1"
  cursor=0
  top=0
  count=0
  for app in ${APPS} ${REMOVED_APPS}; do
    count=$((count + 1))
  done
  tui_resize

  tui_key_file="$(mktemp)"
  tui_stty="$(stty -g </dev/tty)"
  trap 'tui_restore' EXIT
  trap 'tui_restore; exit 130' INT
  trap 'tui_restore; exit 143' TERM
  stty -icanon -echo min 1 time 0 </dev/tty

  {
    printf '\033[?25l'
    printf 'Select apps to install:\n'
    tui_draw
  } >/dev/tty

  while :; do
    tui_read_key
    case "${key}" in
      "${ESC}[A" | "${ESC}OA" | k)
        if [ "${cursor}" -gt 0 ]; then
          cursor=$((cursor - 1))
        fi
        ;;
      "${ESC}[B" | "${ESC}OB" | j)
        if [ "${cursor}" -lt $((count - 1)) ]; then
          cursor=$((cursor + 1))
        fi
        ;;
      ' ')
        tui_toggle
        ;;
      "${NL}" | "${CR}")
        break
        ;;
      q)
        tui_restore
        trap - EXIT INT TERM
        echo 'Aborted.' >&2
        exit 1
        ;;
    esac
    tui_scroll
    {
      printf '\033[%dA' $((visible + 3))
      tui_draw
    } >/dev/tty
  done

  tui_restore
  trap - EXIT INT TERM
  selected="$(normalize_apps "${selected}")"
}

main() {
  setup_colors
  set_envs
  parse_args "$@"
  if [ -n "${DRY_RUN}" ]; then
    note 'dry run, nothing will be changed'
  fi

  load_installed
  if [ -n "${LIST}" ]; then
    list_apps
    return
  fi

  remove=''
  for app in ${REMOVE}; do
    if ! contains "${APPS}" "${app}" && ! contains "${REMOVED_APPS}" "${app}"; then
      error "unknown app '${app}'"
      exit 1
    fi
    if contains "${installed}" "${app}"; then
      remove="${remove} ${app}"
    else
      warn "${app} is not installed"
    fi
  done
  remove="$(normalize_apps "${remove}")"

  if [ -n "${ADD_ALL}${ADD}${REMOVE}" ]; then
    for app in ${REMOVED_APPS}; do
      if ! contains "${remove}" "${app}"; then
        warn "${app} was removed from install.sh but is still installed; use --remove or the selector to uninstall"
      fi
    done
  fi

  add=''
  if [ -n "${ADD_ALL}" ]; then
    add="${APPS}"
  elif [ -n "${ADD}" ]; then
    add="$(normalize_apps "${ADD}")"
  elif [ -n "${REMOVE}" ]; then
    :
  elif has_tty; then
    tui_select "${installed}"
    add="${selected}"
    for app in ${installed}; do
      if ! contains "${selected}" "${app}"; then
        remove="${remove} ${app}"
      fi
    done
  else
    error 'no terminal available; use --add, --remove, --all or --list'
    exit 1
  fi

  if [ -z "${add}${remove}" ]; then
    print_summary
    return
  fi

  create_xdg_base_directories_if_needed

  # set -e does not apply inside these calls; they check failures themselves.
  for app in ${remove}; do
    uninstall_app "${app}" || true
  done
  for app in ${add}; do
    install_app "${app}" || true
  done

  result=''
  for app in ${installed} ${add}; do
    if contains "${UNINSTALLED}" "${app}"; then
      continue
    fi
    # Keep apps that were already installed even if re-linking them failed.
    if contains "${FAILED}" "${app}" && ! contains "${installed}" "${app}"; then
      continue
    fi
    result="${result} ${app}"
  done
  save_installed "$(normalize_apps "${result}")"

  print_summary
  if [ -n "${FAILED}" ]; then
    error "failed:${FAILED}"
    exit 1
  fi
}

main "$@"
