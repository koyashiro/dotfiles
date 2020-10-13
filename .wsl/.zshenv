# wsl

# Windows PowerShell
alias powershell.exe=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe

# PowerShell 7
alias pwsh.exe="/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"

# cmd.exe
alias cmd.exe=/mnt/c/Windows/system32/cmd.exe

# explorer.exe
alias explorer.exe=/mnt/c/Windows/explorer.exe

# git.exe
alias git.exe="/mnt/c/Program\ Files/Git/cmd/git.exe"

# Windows $HOME
export WINHOME="$(wslpath $(powershell.exe -Command 'Write-Host "$env:USERPROFILE" -NoNewLine'))"

# VS Code
alias code="$WINHOME/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"

# wsl bin
PATH=$HOME/.wsl/bin:$PATH

export PATH
