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

# profile.ps1

$link = $PROFILE
$target = "${env:USERPROFILE}\dotfiles\PowerShell\Microsoft.PowerShell_profile.ps1"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $target > $link"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas

# .hyper.js

$link = "${env:APPDATA}\Hyper\.hyper.js"
$target = "${env:USERPROFILE}\dotfiles\Hyper\.hyper.js"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $target > $link"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas
