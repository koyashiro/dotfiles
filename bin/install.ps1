$link = "${env:USERPROFILE}\.gitconfig"
$target = "${env:USERPROFILE}\dotfiles\.gitconfig"

if (Test-Path $link) {
  Write-Host "remove > $link"
  Remove-Item $link
}

Write-Host "mklink $link > $target"
powershell.exe -Command Start-Process -FilePath "cmd" -ArgumentList "/c", "mklink", $link, $target -Verb Runas
