Start-Process pwsh -ArgumentList "$PSScriptRoot\symlink.pa1" -Verb runas
Start-Process pwsh -ArgumentList "$PSScriptRoot\cp.ps1"
Start-Process pwsh -ArgumentList "$PSScriptRoot\registry.ps1" -Verb runas
