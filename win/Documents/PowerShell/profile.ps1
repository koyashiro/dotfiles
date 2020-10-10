$rawui = (Get-Host).UI.RawUI
$rawui.WindowTitle = "PowerShell 7"

$ENV:Path = "${HOME}\bin;" + $ENV:Path

Remove-Alias ls
Remove-Alias cat
Remove-Alias echo
Remove-Alias cp
Remove-Alias mv
Remove-Alias rm
Remove-Alias pwd

Set-Alias clr Clear-Host
Set-Alias g git
Set-Alias d docker
Set-Alias dc docker-compose


function ll {
  ls -lh
}

function la {
  ls -lhA
}

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
