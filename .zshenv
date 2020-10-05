# LANGUAGE
export LANGUAGE=ja_JP.UTF-8
export LANG="$LANGUAGE"
export LC_ALL="$LANGUAGE"
export LC_CTYPE="$LANGUAGE"

# Editor
export EDITOR=vim
export CVSEDITOR="$EDITOR"
export SVN_EDITOR="$EDITOR"
export GIT_EDITOR="$EDITOR"

# Pager
export PAGER=less

# Less status line
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
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
PATH="$PATH:$HOME/.bin"
PATH="$PATH:$HOME/.local/bin"

# yarn
PATH="$PATH:$HOME/.yarn/bin"

# Rust
PATH="$PATH:$HOME/.cargo/bin"

export PATH

# History file and its size
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# wsl
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    # explorer.exe
    alias explorer.exe=/mnt/c/Windows/explorer.exe

    # cmd.exe
    alias cmd.exe=/mnt/c/Windows/system32/cmd.exe

    # powershell.exe
    alias powershell.exe=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe

    # git.exe
    alias git.exe="'/mnt/c/Program Files/Git/cmd/git.exe'"

    # Windows $HOME
    export WINHOME="$(wslpath $(powershell.exe -Command 'Write-Host "$env:USERPROFILE" -NoNewLine'))"

    # VSCode
    alias code="'$WINHOME/AppData/Local/Programs/Microsoft VS Code/bin/code'"

    # checks to see if we are in a windows or linux dir
    function isWinDir {
        case $PWD/ in
            /mnt/c/* ) return $(true);;
            $HOME/winhome/* ) return $(true);;
            * ) return $(false);;
        esac
    }

    # wrap the git command to either run windows git or linux
    function git {
        if isWinDir; then
            git.exe "$@"
        else
            /usr/bin/git "$@"
        fi
    }
fi
