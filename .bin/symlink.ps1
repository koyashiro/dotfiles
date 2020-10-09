if (!(Get-Module powershell-yaml)) {
  Install-Module powershell-yaml
}
Import-Module powershell-yaml

$startPath = Get-Location
$workPath = Join-Path $PSScriptRoot '..\' | Resolve-Path
Set-Location $workPath

$symlinkPath = Join-Path $PSScriptRoot 'symlink.yaml'
if (!$(Test-Path $symlinkPath)) {
  Write-Error "$symlinkPath is not exists."
  exit 1
}

$settings = Get-Content -LiteralPath $symlinkPath -Encoding UTF8 -Raw | ConvertFrom-Yaml
if (!$?) {
  Write-Error "Failed to parse $symlinkPath."
  exit 1
}

foreach ($setting in $settings) {
  $srcPath = "Write-Output $($setting.srcPath)" | Invoke-Expression
  if (!$(Test-Path $srcPath)) {
    Write-Error "$srcPath is not exists."
    exit 1
  }

  $destPath = "Write-Output $($setting.destPath)" | Invoke-Expression
  if (Test-Path $destPath) {
    Remove-Item $destPath
  }
  $destPathParent = $destPath | Split-Path -Parent
  if (!$(Test-Path $destPathParent)) {
    New-Item -ItemType Directory $destPathParent
  }
  $destPathLeaf = $destPath | Split-Path -Leaf

  Write-Output "[symlink] $srcPath => $destPath"
  New-Item -ItemType SymbolicLink -Value $(Resolve-Path $srcPath) -Path $(Resolve-Path $destPathParent) -Name $destPathLeaf
}

Set-Location $startPath
