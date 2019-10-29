$link = "${env:USERPROFILE}\.gitconfig"
$target = "${env:USERPROFILE}\dotfiles\.gitconfig"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $target > $link"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas

$link = "${env:USERPROFILE}\.gitconfig.user"
$target = "${env:USERPROFILE}\dotfiles\.gitconfig.user"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $target > $link"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas

$link = "${env:USERPROFILE}\_vimrc"
$target = "${env:USERPROFILE}\dotfiles\.vimrc"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $target > $link"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas
