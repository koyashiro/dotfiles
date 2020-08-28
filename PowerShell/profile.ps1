$rawui = (Get-Host).UI.RawUI
$rawui.WindowTitle = "PowerShell 7"

$ENV:Path = "${HOME}\bin;" + $ENV:Path

Set-Alias clr Clear-Host
Set-Alias g git
Set-Alias d docker
Set-Alias dc docker-compose

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
