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
    '.gitconfig.user',
    '.zsh',
    '.zshenv',
    '.zshrc'
)

# dotfiles
foreach ($f in Get-ChildItem -Name .*) {
    if ($f -in $excludes) {
      continue
    }

    New-Item -ItemType SymbolicLink -Value $HOME\dotfiles\$f -Path $HOME\$f -Force
}

# rename .vimrc -> _vimrc
if (Test-Path $HOME\.vimrc) {
    Move-Item -Force $HOME\.vimrc $HOME\_vimrc
}

# Windows Terminal
New-Item -ItemType SymbolicLink -Value $HOME\dotfiles\win\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Force

# Windows Terminal
New-Item -ItemType SymbolicLink -Value $HOME\dotfiles\win\Documents\PowerShell\profile.ps1 -Path $profile.CurrentUserAllHosts -Force
