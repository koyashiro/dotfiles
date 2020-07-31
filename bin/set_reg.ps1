# Windows Terminal
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\WindowsTerminal" /t REG_SZ /d "Open Windows Terminal here" /f
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\WindowsTerminal" /v "Icon" /t REG_SZ /d "${env:USERPROFILE}\icons\terminal.ico" /f
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\WindowsTerminal\command" /t REG_SZ /d "${env:LOCALAPPDATA}\Microsoft\WindowsApps\wt.exe" /f
