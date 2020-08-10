if (!(Get-Module powershell-yaml)) {
  Install-Module powershell-yaml
}
Import-Module powershell-yaml

$startPath = Get-Location
$workPath = Join-Path $PSScriptRoot '..\' | Resolve-Path
Set-Location $workPath

$cpPath = Join-Path $PSScriptRoot 'cp.yaml'
if (!$(Test-Path $cpPath)) {
  Write-Error "$cpPath is not exists."
  exit 1
}

$settings = Get-Content -LiteralPath $cpPath -Encoding UTF8 -Raw | ConvertFrom-Yaml
if (!$?) {
  Write-Error "Failed to parse $cpPath."
  exit 1
}

foreach ($setting in $settings) {
  $srcPath = "Write-Output $($setting.srcPath)" | Invoke-Expression
  if (!$(Test-Path $setting.srcPath)) {
    Write-Error "$($setting.srcPath) is not exists."
    exit 1
  }

  $destPath = "Write-Output $($setting.destPath)" | Invoke-Expression
  if (Test-Path $destPath) {
    continue
  }

  Write-Output "[cp] $srcPath => $destPath"
  New-Item -Value $srcPath -Path $destPath
}

Set-Location $startPath
