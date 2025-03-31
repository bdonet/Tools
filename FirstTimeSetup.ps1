PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
winget install JanDeDobbeleer.OhMyPosh -s winget
dotnet tool install --global dotnet-ef

Copy-Item .\Microsoft.PowerShell_profile.ps1 -Destination "$HOME\Documents\WindowsPowerShell"
Copy-Item .\Microsoft.PowerShell_profile.ps1 -Destination "$HOME\Documents\PowerShell"

$gitConfigFilePath = Read-Host -Prompt "Enter the full path of your git config file"
Add-Content -Path $gitConfigFilePath -Value "[commit]
	verbose = 1
[color `"diff`"]
    new = green bold
    old = red bold
[color `"grep`"]
    filename = yellow bold
[color `"status`"]
	branch = yellow bold
    nobranch = magenta bold
    unmerged = red bold
    added = green bold
    changed = red bold
    untracked = red bold"

.\Microsoft.PowerShell_profile.ps1
exit