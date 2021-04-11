$removeAliases = @(
  'ls',
  'cat',
  'echo',
  'cp',
  'mv',
  'rm',
  'pwd'
)

foreach ($removeAlias in $removeAliases) {
  if (Get-Alias -ErrorAction Ignore "$removeAlias") {
    Remove-Item "alias:$removeAlias"
  }
}

Set-Alias clr Clear-Host
Set-Alias g git
Set-Alias d docker
Set-Alias dc docker-compose

function ll {
  ls -alhAF $args
}

Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward

Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme powerlevel10k_classic
