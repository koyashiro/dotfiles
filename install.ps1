$DOTDIR = "$HOME\.dotfiles"

# XDG Base Directory
$ENV:XDG_CONFIG_HOME = "$HOME\.config"
$ENV:XDG_CACHE_HOME = "$HOME\.cache"
$ENV:XDG_DATA_HOME = "$HOME\.local\share"
[Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', $ENV:XDG_CONFIG_HOME, 'User')
[Environment]::SetEnvironmentVariable('XDG_CACHE_HOME', $ENV:XDG_CACHE_HOME, 'User')
[Environment]::SetEnvironmentVariable('XDG_DATA_HOME', $ENV:XDG_DATA_HOME, 'User')

# VIMINIT
$ENV:VIMINIT = "if has('nvim') | source $ENV:XDG_CONFIG_HOME\nvim\init.vim | else | source $ENV:XDG_CONFIG_HOME\vim\vimrc | endif"
[Environment]::SetEnvironmentVariable('VIMINIT', $ENV:VIMINIT, 'User')

# install posh-git
if (!(Get-Module posh-git)) {
  Install-Module posh-git
}

# install oh-my-posh
if (!(Get-Module oh-my-posh)) {
  Install-Module oh-my-posh
}

# XDG_CONFIG_HOME
if (!(Test-Path $ENV:XDG_CONFIG_HOME)) {
  New-Item -ItemType Directory $ENV:XDG_CONFIG_HOME
}
foreach ($f in Get-ChildItem $DOTDIR\config\*) {
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
$configDir = 'config'
$f = 'alacritty'
New-Item `
  -ItemType SymbolicLink `
  -Force `
  -Value $(Convert-Path $(Join-Path $configDir $f)) `
  -Path $(Join-Path $env:APPDATA $f)

# PowerShell 7
$documentsDir = 'win\Documents'
$f = 'PowerShell\profile.ps1'
New-Item `
  -ItemType SymbolicLink `
  -Force `
  -Value $(Convert-Path $(Join-Path $documentsDir $f)) `
  -Path $(Join-Path $([Environment]::GetFolderPath('Personal')) $f) `

# WSL
$envs = @(
  'SystemDrive/p',
  'SystemRoot/p'
  'ComSpec/p',
  'USERPROFILE/p',
  'APPDATA/p',
  'LOCALAPPDATA/p'
)
$ENV:WSLENV = "$($envs -Join ':')"
[Environment]::SetEnvironmentVariable('WSLENV', $ENV:WSLENV, 'User')
