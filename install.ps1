$DOTDIR = "$HOME\.dotfiles"

$ENV:XDG_CONFIG_HOME = "$HOME\.config"

# install posh-git
if (!(Get-Module posh-git)) {
  Install-Module posh-git
}

# install oh-my-posh
if (!(Get-Module oh-my-posh)) {
  Install-Module oh-my-posh
}

# exclude dotfiles
$excludes = @(
  '.config',
  '.git',
  '.gitattributes',
  '.gitconfig',
  '.local',
  '.editorconfig',
  '.prettierrc'
)

# dotfiles
foreach ($f in Get-ChildItem -Name $DOTDIR\.*) {
  if ($f -in $excludes) {
    continue
  }

  New-Item -ItemType SymbolicLink -Value $(Convert-Path $f) -Path $(Join-Path $HOME $f) -Force
}

# XDG_CONFIG_HOME
if (!(Test-Path $ENV:XDG_CONFIG_HOME)) {
  New-Item -ItemType Directory $ENV:XDG_CONFIG_HOME
}
foreach ($f in Get-ChildItem $DOTDIR\.config\*) {
  New-Item -ItemType SymbolicLink -Value $f -Path $(Join-Path $ENV:XDG_CONFIG_HOME $([System.IO.Path]::GetFileName($f))) -Force
}

# Windows Terminal
$localAppDataDir = 'win\AppData\Local'
$f = 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'
New-Item `
  -ItemType SymbolicLink `
  -Force `
  -Value $(Convert-Path $(Join-Path $localAppDataDir $f)) `
  -Path $(Join-Path $env:LOCALAPPDATA $f)

# Windows Package Manager
$localAppDataDir = 'win\AppData\Local'
$f = 'Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json'
New-Item `
  -ItemType SymbolicLink `
  -Force `
  -Value $(Convert-Path $(Join-Path $localAppDataDir $f)) `
  -Path $(Join-Path $env:LOCALAPPDATA $f)

# Alacritty
$configDir = '.config'
$f = 'alacritty'
New-Item `
  -ItemType SymbolicLink `
  -Force `
  -Value $(Convert-Path $(Join-Path $configDir $f)) `
  -Path $(Join-Path $env:APPDATA $f)

# Inkdrop
$configDir = '.config'
$f = 'inkdrop'
New-Item `
  -ItemType SymbolicLink `
  -Force `
  -Value $(Convert-Path $(Join-Path $configDir $f | Join-Path -ChildPath 'keymap.cson')) `
  -Path $(Join-Path $env:APPDATA $f | Join-Path -ChildPath 'keymap.cson')

# Windows PowerShell
$documentsDir = 'win\Documents'
$f = 'WindowsPowerShell\profile.ps1'
New-Item `
  -ItemType SymbolicLink `
  -Force `
  -Value $(Convert-Path $(Join-Path $documentsDir $f)) `
  -Path $(Join-Path $([Environment]::GetFolderPath('Personal')) $f) `

# PowerShell 7
$documentsDir = 'win\Documents'
$f = 'PowerShell\profile.ps1'
New-Item `
  -ItemType SymbolicLink `
  -Force `
  -Value $(Convert-Path $(Join-Path $documentsDir $f)) `
  -Path $(Join-Path $([Environment]::GetFolderPath('Personal')) $f) `
