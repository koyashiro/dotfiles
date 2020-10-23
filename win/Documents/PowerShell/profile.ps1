$ENV:Path = "$HOME\bin;${ENV:Path}"

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

if (Get-Command -ErrorAction Ignore nvim) {
  function vim {
    nvim $args
  }
}

function ll {
  ls -alhAF $args
}

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
