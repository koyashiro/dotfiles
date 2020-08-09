$rawui = (Get-Host).UI.RawUI
$rawui.WindowTitle = "PowerShell 7"

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
