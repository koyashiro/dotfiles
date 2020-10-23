# LANGUAGE
export LANGUAGE=ja_JP.UTF-8
export LANG="$LANGUAGE"
export LC_ALL="$LANGUAGE"
export LC_CTYPE="$LANGUAGE"

# Editor
export EDITOR="$(type nvim >/dev/null && echo 'nvim' || echo 'vim')"
export CVSEDITOR="$EDITOR"
export SVN_EDITOR="$EDITOR"
export GIT_EDITOR="$EDITOR"

# Pager
export PAGER=less

# Less status line
export LESS='-R -f -x4 -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# bin
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"

export PATH

# History file and its size
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# DOTDIR
export DOTDIR=$(dirname $(readlink $HOME/.zshenv))

# wsl
if [[ -f $HOME/.wsl/.zshenv ]]; then
  source $HOME/.wsl/.zshenv
fi
