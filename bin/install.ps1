# .gitconfig

$link = "${env:USERPROFILE}\.gitconfig"
$target = "${env:USERPROFILE}\dotfiles\.gitconfig"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $target > $link"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas

# .gitconfig.user

$link = "${env:USERPROFILE}\.gitconfig.user"
$target = "${env:USERPROFILE}\dotfiles\.gitconfig.user"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $target > $link"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas

# .vimrc

$link = "${env:USERPROFILE}\_vimrc"
$target = "${env:USERPROFILE}\dotfiles\.vimrc"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $target > $link"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas

# PowerShell

$link = "${PROFILE}\Microsoft.PowerShell_profile.ps1"
$target = "${env:USERPROFILE}\dotfiles\PowerShell\Microsoft.PowerShell_profile.ps1"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $target > $link"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas

# Windows Terminal

$link = "${env:LOCALAPPDATA}\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$target = "${env:USERPROFILE}\dotfiles\WindowsTerminal\settings.json"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $target > $link"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas
