# install posh-git
if (!(Get-Module posh-git)) {
  Install-Module posh-git
}

# install oh-my-posh
if (!(Get-Module oh-my-posh)) {
  Install-Module oh-my-posh
}

# exclude dotfiles
$excludes=@(
    '.git',
    '.gitattributes',
    '.gitconfig.user'
)

# dotfiles
foreach ($f in Get-ChildItem -Name .*) {
    if ($f -in $excludes) {
      continue
    }

    New-Item -ItemType SymbolicLink -Value $(Convert-Path $f) -Path $(Join-Path $HOME $f) -Force
}

# rename .vimrc -> _vimrc
if (Test-Path $HOME\.vimrc) {
    Move-Item -Force $HOME\.vimrc $HOME\_vimrc
}

# Windows Terminal
$localAppDataDir = 'win\AppData\Local'
$f = 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'
New-Item -ItemType SymbolicLink -Value $(Convert-Path $(Join-Path $localAppDataDir $f)) -Path $(Join-Path $env:LOCALAPPDATA $f) -Force

# PowerShell
$documentsDir = 'win\Documents'
$f = 'PowerShell\profile.ps1'
New-Item -ItemType SymbolicLink -Value $(Convert-Path $(Join-Path $documentsDir $f)) -Path $profile.CurrentUserAllHosts -Force
