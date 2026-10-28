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
  stub_tools
  printf '%s\n' "$CASE"
}

# Sets RC; output goes to "$T.log". The curl stub in "$T.bin" keeps the mise
# installation off the network.
install() {
  RC=0
  (
    unset CLAUDE_CONFIG_DIR XDG_CONFIG_HOME
    HOME="$T" PATH="$T.bin:$PATH" sh "$INSTALL" "$@"
  ) </dev/null >"$T.log" 2>&1 || RC=$?
}

# Stubs record their calls in "$T.calls". The curl stub downloads an installer
# that copies the mise stub "$T.mise" to ~/.local/bin/mise, and the mise stub
# runs `exec` with "$T.tools" on PATH, so herdr is reachable only through
# `mise exec`. Creating "$T.curl-fail", "$T.mise-fail", "$T.mise-exec-fail" or
# "$T.herdr-fail" makes that stub fail.
stub_tools() {
  mkdir -p "$T.bin" "$T.tools"
  cat >"$T.bin/curl" <<EOF
#!/bin/sh
while [ \$# -gt 0 ]; do
  if [ "\$1" = -o ]; then
    out="\$2"
  fi
  shift
done
if [ -e "$T.curl-fail" ]; then
  exit 22
fi
cat >"\$out" <<'EOS'
dst="\${MISE_INSTALL_PATH:-\$HOME/.local/bin/mise}"
mkdir -p "\$(dirname "\$dst")"
cp "$T.mise" "\$dst"
echo 'install mise' >>"$T.calls"
EOS
EOF
  cat >"$T.mise" <<EOF
#!/bin/sh
if [ "\$3" = exec ]; then
  if [ -e "$T.mise-exec-fail" ]; then
    echo 'mise ERROR invalid config' >&2
    exit 1
  fi
  if [ "\${MISE_EXEC_AUTO_INSTALL:-}" != false ]; then
    echo 'mise exec with auto-install' >>"$T.calls"
  fi
  shift 4
  PATH="$T.tools:/usr/bin:/bin" exec "\$@"
fi
echo "mise \$*" >>"$T.calls"
if [ -e "$T.mise-fail" ]; then
  exit 1
fi
EOF
  cat >"$T.tools/herdr" <<EOF
#!/bin/sh
if [ -L "\$HOME/.config/mise/conf.d/herdr.toml" ]; then
  linked=yes
else
  linked=no
fi
echo "herdr \$* CLAUDE_CONFIG_DIR=\$CLAUDE_CONFIG_DIR linked=\$linked" >>"$T.calls"
if [ -e "$T.herdr-fail" ]; then
  exit 1
fi
EOF
  chmod +x "$T.bin/curl" "$T.mise" "$T.tools/herdr"
}

expect_calls() {
  actual="$(cat "$T.calls" 2>/dev/null || true)"
  if [ "$actual" != "$1" ]; then
    fail "calls: expected '$1', got '$actual'"
  fi
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

# Every file in shared/ (except .local, which is not managed) must be
# registered in install.sh, or it would silently never be linked. A file counts
# as linked when it is reached through a linked directory too (e.g. nvim/lua).
repo_files() {
  (
    cd "$DOTDIR/shared"
    find . -path ./.local -prune -o -type f -print
  ) | sed 's|^\./||' | sort
}

expect_resolves() {
  if [ "$(readlink -f "$T/$1")" != "$(readlink -f "$DOTDIR/shared/$1")" ]; then
    fail "$1 is not linked to the repository"
  fi
}

snapshot() {
  find "$T" -exec stat -c '%n %a %F' {} + | sort
}

begin '--all links every repository entry and records all apps'
install --all
expect_rc 0
repo_files >"$T.files"
while IFS= read -r path; do
  expect_resolves "$path"
done <"$T.files"
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
echo mine >"$T/.profile"
mkdir -p "$T/.config"
echo file >"$T/.config/sh"
install --add sh
expect_rc 1
expect_content .profile mine
expect_no_entry .profile.bak
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
mkdir -p "$T/.config/herdr" "$T/.config/mise/conf.d" "$T/.config/peco"
ln -s "$DOTDIR/shared/.config/herdr/config.toml" "$T/.config/herdr/config.toml"
ln -s "$DOTDIR/shared/.config/mise/conf.d/herdr.toml" "$T/.config/mise/conf.d/herdr.toml"
ln -s "$DOTDIR/shared/.config/peco/config.json" "$T/.config/peco/config.json"
ln -s "$DOTDIR/shared/.zshrc" "$T/.zshrc"
install --add alacritty
expect_rc 0
expect_installed 'alacritty herdr peco'

begin 'the state file records every linked path'
install --add git
expect_rc 0
expected="$(printf 'git\t%s\n' .config/git/config .config/git/ignore .config/git/prune-merged.sh \
  .config/sh/rc.d/git.sh .config/zsh/rc.d/git.zsh)"
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
mkdir -p "$T/.config/peco"
ln -s "$DOTDIR/shared/.config/peco/config.json" "$T/.config/peco/config.json"
ln -s "$DOTDIR/shared/.config/peco/old.json" "$T/.config/peco/old.json"
echo mine >"$T/.config/peco/old.json.bak"
mkdir -p "$T/.local/share/dotfiles"
printf 'peco\t.config/peco/config.json\npeco\t.config/peco/old.json\n' >"$T/.local/share/dotfiles/installed"
install --add peco
expect_rc 0
expect_content .config/peco/old.json mine
expect_no_entry .config/peco/old.json.bak
if [ "$(cat "$T/.local/share/dotfiles/installed")" != "$(printf 'peco\t.config/peco/config.json')" ]; then
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

begin 'installing adds dependencies, installs mise and then runs post_install'
install --add herdr
expect_rc 0
expect_installed 'claude herdr mise'
expect_output 'claude is added as a dependency'
expect_calls "$(printf '%s\n' 'install mise' "mise -C $T install" \
  "herdr integration install claude CLAUDE_CONFIG_DIR=$T/.config/claude linked=yes")"
if [ "$(grep -o 'Installing [a-z]*' "$T.log" | tr '\n' ' ')" != 'Installing mise Installing claude Installing herdr ' ]; then
  fail 'dependencies should be installed first'
fi

begin 'an installed dependency is not reported as added'
install --add mise
install --add jq
expect_rc 0
if grep -q 'is added as a dependency' "$T.log"; then
  fail 'an installed dependency should not be reported as added'
fi

for result in succeeds fails; do
  begin "the mise installer is removed when the installation $result"
  if [ "$result" = fails ]; then
    touch "$T.curl-fail"
  fi
  mkdir -p "$T.tmp"
  RC=0
  (
    unset CLAUDE_CONFIG_DIR XDG_CONFIG_HOME
    HOME="$T" TMPDIR="$T.tmp" PATH="$T.bin:$PATH" sh "$INSTALL" --add jq
  ) </dev/null >"$T.log" 2>&1 || RC=$?
  if [ -n "$(ls -A "$T.tmp")" ]; then
    fail 'the mise installer was left behind'
  fi
done

begin 'an existing mise is not installed again'
mkdir -p "$T/.local/bin"
cp "$T.mise" "$T/.local/bin/mise"
install --add ripgrep
expect_rc 0
expect_calls "mise -C $T install"

begin 'apps without mise config do not run mise install'
install --add tmux
expect_rc 0
expect_calls ''

begin 'mise is installed to ~/.local/bin even if MISE_INSTALL_PATH is set'
export MISE_INSTALL_PATH="$T.elsewhere"
install --add ripgrep
unset MISE_INSTALL_PATH
expect_rc 0
expect_no_entry ../"$(basename "$T").elsewhere"
expect_calls "$(printf '%s\n' 'install mise' "mise -C $T install")"

begin 'an up-to-date app runs no hooks'
install --add herdr
rm -f "$T.calls"
install --add herdr
expect_rc 0
expect_calls ''

begin 'uninstalling runs pre_uninstall before removing links'
install --add herdr
rm -f "$T.calls"
install --remove herdr
expect_rc 0
expect_installed 'claude mise'
expect_calls "herdr integration uninstall claude CLAUDE_CONFIG_DIR=$T/.config/claude linked=yes"

begin 'apps are uninstalled before their dependencies'
install --add herdr
install --remove claude,herdr
expect_rc 0
expect_installed 'mise'
if [ "$(grep -o 'Uninstalling [a-z]*' "$T.log" | tr '\n' ' ')" != 'Uninstalling herdr Uninstalling claude ' ]; then
  fail 'herdr should be uninstalled before claude'
fi

begin 'a dependency is uninstalled after the apps that need it'
install --add jq
install --remove jq,mise
expect_rc 0
if [ "$(grep -o 'Uninstalling [a-z]*' "$T.log" | tr '\n' ' ')" != 'Uninstalling jq Uninstalling mise ' ]; then
  fail 'jq should be uninstalled before mise'
fi

begin 'an app required by an installed app cannot be removed'
install --add herdr
install --remove claude
expect_rc 1
expect_output 'cannot remove claude: required by herdr'
expect_installed 'claude herdr mise'
expect_link .config/claude/CLAUDE.md

begin 'a dependency is not added against an explicit --remove'
install --add herdr --remove claude
expect_rc 1
expect_output 'cannot remove claude: required by herdr'
expect_no_entry .config/claude/CLAUDE.md

begin 'an installed app is kept when its dependency fails'
mkdir -p "$T/.config/mise/conf.d" "$T/.local/share/dotfiles"
ln -s "$DOTDIR/shared/.config/mise/conf.d/jq.toml" "$T/.config/mise/conf.d/jq.toml"
printf 'jq\t.config/mise/conf.d/jq.toml\n' >"$T/.local/share/dotfiles/installed"
echo mine >"$T/.config/mise/conf.d/mise.toml"
echo mine >"$T/.config/mise/conf.d/mise.toml.bak"
install --add jq
expect_rc 1
if grep -q 'jq: dependency' "$T.log"; then
  fail 'jq should not be reported as failed'
fi
expect_installed 'jq'
expect_link .config/mise/conf.d/jq.toml

begin 'an installed app that gets new paths is kept when its dependency fails'
mkdir -p "$T/.config/herdr" "$T/.config/mise/conf.d" "$T/.local/bin" "$T/.local/share/dotfiles"
ln -s "$DOTDIR/shared/.config/herdr/config.toml" "$T/.config/herdr/config.toml"
printf 'herdr\t.config/herdr/config.toml\n' >"$T/.local/share/dotfiles/installed"
cp "$T.mise" "$T/.local/bin/mise"
echo mine >"$T/.config/mise/conf.d/mise.toml"
echo mine >"$T/.config/mise/conf.d/mise.toml.bak"
install --add herdr
expect_rc 1
if grep -q 'herdr: dependency' "$T.log"; then
  fail 'herdr should not be reported as failed'
fi
expect_link .config/mise/conf.d/herdr.toml

begin 'an installed app that gets new paths runs no post_install'
mkdir -p "$T/.config/herdr" "$T/.local/share/dotfiles"
ln -s "$DOTDIR/shared/.config/herdr/config.toml" "$T/.config/herdr/config.toml"
printf 'herdr\t.config/herdr/config.toml\n' >"$T/.local/share/dotfiles/installed"
install --add herdr
expect_rc 0
expect_link .config/mise/conf.d/herdr.toml
expect_calls "$(printf '%s\n' 'install mise' "mise -C $T install")"

begin 'a missing tool fails post_install'
rm "$T.tools/herdr"
install --add herdr
expect_rc 1
expect_output 'herdr not found:'
expect_installed 'claude mise'
expect_no_entry .config/herdr/config.toml

begin 'a failing mise install reverts only the apps that linked mise config'
touch "$T.mise-fail"
install --add herdr,tmux
expect_rc 1
expect_output 'command failed: mise install'
expect_installed 'tmux'
expect_link .config/tmux/tmux.conf
expect_no_entry .config/mise/conf.d/mise.toml

begin 'a failing post_install reverts the app'
touch "$T.herdr-fail"
install --add herdr
expect_rc 1
expect_output 'herdr: post_install failed'
expect_output '2 apps installed, 1 failed (10 linked)'
expect_installed 'claude mise'
expect_no_entry .config/herdr/config.toml
expect_no_entry .config/mise/conf.d/herdr.toml

begin 'reverting an app restores only the backups made in the run'
mkdir -p "$T/.config/mise/conf.d" "$T/.config/herdr"
echo old >"$T/.config/mise/conf.d/herdr.toml.bak"
echo mine >"$T/.config/herdr/config.toml"
touch "$T.herdr-fail"
install --add herdr
expect_rc 1
expect_no_entry .config/mise/conf.d/herdr.toml
expect_content .config/mise/conf.d/herdr.toml.bak old
expect_output '2 apps installed, 1 failed (10 linked)'
expect_content .config/herdr/config.toml mine
expect_no_entry .config/herdr/config.toml.bak

begin 'an app whose dependency fails is skipped'
mkdir -p "$T/.config/claude"
echo mine >"$T/.config/claude/CLAUDE.md"
echo mine >"$T/.config/claude/CLAUDE.md.bak"
install --add herdr
expect_rc 1
expect_output 'herdr: dependency claude failed'
expect_output 'Skipped herdr'
expect_output '1 app installed, 2 failed (4 linked)'
expect_output 'failed: claude herdr$'
expect_installed 'mise'
expect_no_entry .config/herdr/config.toml

begin 'a failing pre_uninstall keeps the app and its dependencies'
install --add herdr
touch "$T.herdr-fail"
install --remove claude,herdr
expect_rc 1
expect_output 'herdr: pre_uninstall failed'
expect_output 'claude: required by herdr, which could not be uninstalled'
expect_output 'failed: herdr claude$'
expect_installed 'claude herdr mise'
expect_link .config/herdr/config.toml
expect_link .config/claude/CLAUDE.md

begin 'an app is reverted when a dependency fails after linking'
mkdir -p "$T/.config/mise/conf.d" "$T/.local/bin"
ln -s "$DOTDIR/shared/.config/mise/conf.d/herdr.toml" "$T/.config/mise/conf.d/herdr.toml"
cp "$T.mise" "$T/.local/bin/mise"
touch "$T.mise-fail"
install --add herdr
expect_rc 1
expect_output 'herdr: dependency claude failed'
expect_calls "mise -C $T install"
expect_no_entry .config/herdr/config.toml
if [ -s "$T/.local/share/dotfiles/installed" ]; then
  fail 'no app should be recorded'
fi

begin 'hooks follow XDG_CONFIG_HOME and a preset CLAUDE_CONFIG_DIR'
RC=0
(
  unset CLAUDE_CONFIG_DIR
  HOME="$T" XDG_CONFIG_HOME="$T/xdg" PATH="$T.bin:$PATH" sh "$INSTALL" --add herdr
) </dev/null >"$T.log" 2>&1 || RC=$?
expect_rc 0
expect_calls "$(printf '%s\n' 'install mise' "mise -C $T install" \
  "herdr integration install claude CLAUDE_CONFIG_DIR=$T/xdg/claude linked=yes")"
rm -f "$T.calls"
RC=0
(
  unset XDG_CONFIG_HOME
  HOME="$T" CLAUDE_CONFIG_DIR="$T/custom" PATH="$T.bin:$PATH" sh "$INSTALL" --remove herdr
) </dev/null >"$T.log" 2>&1 || RC=$?
expect_rc 0
expect_calls "herdr integration uninstall claude CLAUDE_CONFIG_DIR=$T/custom linked=yes"

begin 'a missing tool does not block uninstalling'
install --add herdr
rm -f "$T/.local/bin/mise"
install --remove herdr
expect_rc 0
expect_output 'mise not found, skipped'
expect_installed 'claude mise'

begin 'a broken mise is not mistaken for a missing tool'
install --add herdr
touch "$T.mise-exec-fail"
install --remove herdr
expect_rc 1
expect_output 'could not run mise: herdr integration uninstall claude'
expect_output 'mise ERROR invalid config'
expect_installed 'claude herdr mise'

begin 'a failing mise installation reverts the apps that linked mise config'
touch "$T.curl-fail"
install --add herdr
expect_rc 1
expect_output 'could not install mise'
if grep -q 'command failed: mise install' "$T.log"; then
  fail 'mise install should not run without mise'
fi
if [ -s "$T/.local/share/dotfiles/installed" ]; then
  fail 'no app should be recorded'
fi
expect_no_entry .config/mise/conf.d/mise.toml
expect_no_entry .config/mise/conf.d/claude.toml
expect_no_entry .config/herdr/config.toml

begin '--dry-run runs no hooks'
install --add herdr --dry-run
expect_rc 0
expect_calls ''
expect_output 'Running.*herdr integration install claude'

begin '--list shows which apps are installed without changes'
install --add vim
mkdir -p "$T/.local/share/dotfiles"
printf 'removed-app\t.removed\n' >>"$T/.local/share/dotfiles/installed"
before="$(snapshot)"
install --list
expect_rc 0
expect_output '\[x\] vim (shell, config)$'
expect_output '\[ \] tmux (shell, config)$'
expect_output '\[ \] aws (bin, shell)$'
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
