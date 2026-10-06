#!/usr/bin/env sh

set -eu

DOTDIR="$HOME"/.dotfiles
INSTALL="$DOTDIR"/install.sh
APPS="$(sed -n "s/^APPS='\(.*\)'$/\1/p" "$INSTALL")"

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

FAILURES=0
CASE=''
T=''
RC=0

fail() {
  printf '  FAIL: %s\n' "$*" >&2
  FAILURES=$((FAILURES + 1))
}

begin() {
  CASE="$1"
  T="$WORK/$(echo "$1" | tr -c 'a-zA-Z0-9\n' '-')"
  mkdir -p "$T"
  printf '%s\n' "$CASE"
}

# Sets RC; output goes to "$T.log".
install() {
  RC=0
  HOME="$T" sh "$INSTALL" "$@" </dev/null >"$T.log" 2>&1 || RC=$?
}

expect_rc() {
  if [ "$RC" -ne "$1" ]; then
    fail "exit status: expected $1, got $RC"
    sed 's/^/    | /' "$T.log" >&2
  fi
}

expect_link() {
  if ! [ -L "$T/$1" ] || [ "$(readlink "$T/$1")" != "$DOTDIR/shared/$1" ]; then
    fail "$1 is not a link to the repository"
  fi
}

expect_no_entry() {
  if [ -e "$T/$1" ] || [ -L "$T/$1" ]; then
    fail "$1 should not exist"
  fi
}

expect_content() {
  if ! [ -f "$T/$1" ] || [ -L "$T/$1" ] || [ "$(cat "$T/$1")" != "$2" ]; then
    fail "$1 should be a regular file containing '$2'"
  fi
}

expect_mode() {
  if ! mode="$(stat -c %a "$T/$1" 2>/dev/null)"; then
    fail "$1 does not exist"
  elif [ "$mode" != "$2" ]; then
    fail "$1: expected mode $2, got $mode"
  fi
}

expect_installed() {
  actual="$(cut -f 1 "$T/.local/share/dotfiles/installed" 2>/dev/null | uniq | tr '\n' ' ' || true)"
  if [ "$actual" != "$1 " ]; then
    fail "installed: expected '$1', got '$actual'"
  fi
}

expect_output() {
  if ! grep -q "$1" "$T.log"; then
    fail "output should contain '$1'"
    sed 's/^/    | /' "$T.log" >&2
  fi
}

# Every file in shared/ (except .local/bin, which is not managed) must be
# registered in install.sh, or it would silently never be linked.
repo_entries() {
  (
    cd "$DOTDIR/shared"
    find . -mindepth 1 -maxdepth 1 ! -name .config ! -name .local
    find .config -mindepth 1 -maxdepth 1 ! -type d
    find .config -mindepth 2 -maxdepth 2
  ) | sed 's|^\./||' | sort
}

snapshot() {
  find "$T" -exec stat -c '%n %a %F' {} + | sort
}

begin '--all links every repository entry and records all apps'
install --all
expect_rc 0
repo_entries >"$T.entries"
while IFS= read -r path; do
  expect_link "$path"
done <"$T.entries"
expect_installed "$APPS"

begin 'directories are created with mode 0700 and existing ones are untouched'
mkdir -m 755 "$T/.config"
install --add tmux
expect_rc 0
expect_mode .config 755
expect_mode .cache 700
expect_mode .local 700
expect_mode .local/share 700
expect_mode .local/state 700
expect_mode .local/bin 700
expect_mode .config/tmux 700

begin '--add only adds the given apps'
install --add vim
install --add tmux,zsh --add git
expect_rc 0
expect_link .vimrc
expect_link .config/tmux/tmux.conf
expect_link .zshrc
expect_link .config/git/config
expect_no_entry .config/nvim
expect_installed 'git tmux vim zsh'

begin 'existing files and foreign links are backed up to .bak'
echo mine >"$T/.vimrc"
mkdir -p "$T/.config/tmux" "$T/.config/peco"
ln -s /etc/hostname "$T/.config/tmux/tmux.conf"
ln -s /nonexistent "$T/.config/peco/config.json"
install --add vim,tmux,peco
expect_rc 0
expect_link .vimrc
expect_content .vimrc.bak mine
expect_link .config/tmux/tmux.conf
if [ "$(readlink "$T/.config/tmux/tmux.conf.bak")" != /etc/hostname ]; then
  fail 'foreign link was not backed up'
fi
expect_link .config/peco/config.json
if [ "$(readlink "$T/.config/peco/config.json.bak")" != /nonexistent ]; then
  fail 'dangling link was not backed up'
fi

begin 'an app whose backup already exists is skipped without changes'
mkdir -p "$T/.config/git"
echo mine >"$T/.config/git/config"
echo script >"$T/.config/git/prune-merged.sh"
echo old >"$T/.config/git/prune-merged.sh.bak"
install --add git,tmux
expect_rc 1
expect_content .config/git/config mine
expect_no_entry .config/git/config.bak
expect_no_entry .config/git/ignore
expect_content .config/git/prune-merged.sh script
expect_content .config/git/prune-merged.sh.bak old
expect_link .config/tmux/tmux.conf
expect_installed tmux
expect_output 'backup already exists'

begin 'an app whose parent directory resolves into the repository is skipped'
mkdir -p "$T/.config"
ln -s "$DOTDIR/shared/.config/peco" "$T/.config/peco"
install --add peco
expect_rc 1
if [ -L "$DOTDIR/shared/.config/peco/config.json" ] \
  || [ -e "$DOTDIR/shared/.config/peco/config.json.bak" ]; then
  fail 'the repository was modified'
fi
expect_output 'parent directory resolves into the repository'

begin 'an app whose parent is not a directory is skipped without changes'
echo mine >"$T/.bashrc"
mkdir -p "$T/.config"
echo file >"$T/.config/bash"
install --add bash
expect_rc 1
expect_content .bashrc mine
expect_no_entry .bash_profile
expect_output 'not an accessible directory'

begin 'running twice changes nothing the second time'
install --all
before="$(snapshot)"
install --all
expect_rc 0
if [ "$(snapshot)" != "$before" ]; then
  fail 'the second run changed the home directory'
fi
if grep -q -e Linking -e 'Backing up' -e Linked "$T.log"; then
  fail 'the second run should not link or back up anything'
fi
expect_output 'Up to date'
install --all -v
expect_rc 0
expect_output 'Linked'

begin '--dry-run changes nothing'
echo mine >"$T/.vimrc"
before="$(snapshot)"
install --all --dry-run
expect_rc 0
if [ "$(snapshot)" != "$before" ]; then
  fail '--dry-run changed the home directory'
fi
expect_output 'dry run'

begin 'without a state file, fully linked apps are treated as installed'
mkdir -p "$T/.config/tmux"
ln -s "$DOTDIR/shared/.vimrc" "$T/.vimrc"
ln -s "$DOTDIR/shared/.config/tmux/tmux.conf" "$T/.config/tmux/tmux.conf"
ln -s "$DOTDIR/shared/.zshrc" "$T/.zshrc"
install --add npm
expect_rc 0
expect_installed 'npm tmux vim'

begin 'the state file records every linked path'
install --add git
expect_rc 0
expected="$(printf 'git\t%s\n' .config/git/config .config/git/ignore .config/git/prune-merged.sh)"
if [ "$(cat "$T/.local/share/dotfiles/installed")" != "$expected" ]; then
  fail 'the state file does not list the linked paths'
fi

begin 'apps removed from install.sh are kept with a warning'
mkdir -p "$T/.local/share/dotfiles"
printf 'removed-app\t.removed\nvim\t.vimrc\n' >"$T/.local/share/dotfiles/installed"
install --add tmux
expect_rc 0
expect_installed 'tmux vim removed-app'
if ! grep -q "^removed-app$(printf '\t').removed\$" "$T/.local/share/dotfiles/installed"; then
  fail 'the recorded paths of a removed app were not kept'
fi
expect_output 'was removed from install.sh'

begin 'paths removed from an app are unlinked and their backups restored'
ln -s "$DOTDIR/shared/.vimrc" "$T/.vimrc"
ln -s "$DOTDIR/shared/.oldvimrc" "$T/.oldvimrc"
echo mine >"$T/.oldvimrc.bak"
mkdir -p "$T/.local/share/dotfiles"
printf 'vim\t.vimrc\nvim\t.oldvimrc\n' >"$T/.local/share/dotfiles/installed"
install --add vim
expect_rc 0
expect_content .oldvimrc mine
expect_no_entry .oldvimrc.bak
if [ "$(cat "$T/.local/share/dotfiles/installed")" != "$(printf 'vim\t.vimrc')" ]; then
  fail 'the removed path is still recorded'
fi

begin '--remove uninstalls apps and restores their backups'
echo mine >"$T/.vimrc"
install --add vim,tmux
install --remove vim
expect_rc 0
expect_content .vimrc mine
expect_no_entry .vimrc.bak
expect_link .config/tmux/tmux.conf
expect_installed tmux

begin '--remove warns about apps that are not installed and changes nothing'
install --add tmux
before="$(snapshot)"
install --remove vim
expect_rc 0
expect_output 'vim is not installed'
expect_output 'nothing to do'
if [ "$(snapshot)" != "$before" ]; then
  fail 'a run with nothing to do changed the home directory'
fi
expect_installed tmux

begin '--remove and --add can be combined'
install --add vim
install --remove vim --add tmux
expect_rc 0
expect_no_entry .vimrc
expect_link .config/tmux/tmux.conf
expect_installed tmux

begin 'an app given to both --add and --remove is rejected'
install --add vim --remove vim
expect_rc 1
expect_output 'both --add and --remove'
if [ -n "$(ls -A "$T")" ]; then
  fail 'the conflicting arguments changed the home directory'
fi

begin '--list shows which apps are installed without changes'
install --add vim
mkdir -p "$T/.local/share/dotfiles"
printf 'removed-app\t.removed\n' >>"$T/.local/share/dotfiles/installed"
before="$(snapshot)"
install --list
expect_rc 0
expect_output '\[x\] vim$'
expect_output '\[ \] tmux$'
expect_output '\[x\] removed-app (removed)$'
if [ "$(snapshot)" != "$before" ]; then
  fail '--list changed the home directory'
fi

begin '--list cannot be combined with changes'
for args in '--list --add vim' '--list --remove vim' '--list --all'; do
  # shellcheck disable=SC2086
  install $args
  expect_rc 1
done
if [ -n "$(ls -A "$T")" ]; then
  fail 'the rejected arguments changed the home directory'
fi

begin 'a malformed state file is rejected without changes'
mkdir -p "$T/.local/share/dotfiles"
echo vim >"$T/.local/share/dotfiles/installed"
before="$(snapshot)"
install --add tmux
expect_rc 1
expect_output 'installed:1:'
if [ "$(snapshot)" != "$before" ]; then
  fail 'a malformed state file changed the home directory'
fi

begin 'invalid arguments are rejected without changes'
for args in '--add unknown-app' '--add' '--unexpected'; do
  # shellcheck disable=SC2086
  install $args
  expect_rc 1
done
if [ -n "$(ls -A "$T")" ]; then
  fail 'invalid arguments changed the home directory'
fi

begin 'without a terminal, --add or --all is required'
if (exec </dev/tty) 2>/dev/null; then
  echo '  skipped: a terminal is available'
else
  install
  expect_rc 1
  expect_output 'no terminal available'
  if [ -n "$(ls -A "$T")" ]; then
    fail 'the error changed the home directory'
  fi
fi

if [ "$FAILURES" -gt 0 ]; then
  printf '%d assertion(s) failed\n' "$FAILURES" >&2
  exit 1
fi
echo 'all tests passed'
