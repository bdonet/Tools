PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
winget install JanDeDobbeleer.OhMyPosh -s winget
dotnet tool install --global dotnet-ef

Copy-Item .\Microsoft.PowerShell_profile.ps1 -Destination "$HOME\Documents\WindowsPowerShell"
Copy-Item .\Microsoft.PowerShell_profile.ps1 -Destination "$HOME\Documents\PowerShell"

.\Microsoft.PowerShell_profile.ps1
exit