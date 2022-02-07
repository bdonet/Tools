#Open various applications
Set-Alias -Name vs -Value C:\"Program Files"\"Microsoft Visual Studio"\2022\Professional\Common7\IDE\devenv.exe
Set-Alias -Name st -Value C:\Users\bend\AppData\Local\SourceTree\SourceTree.exe
Set-Alias -Name sb -Value C:\ServiceBusExplorer\ServiceBusExplorer.exe

# Perform database migrations
Function migrate {jmigrate; bmigrate}
Set-Alias -Name bmigrate -Value C:\Utilities\DevUtilityDotNetCore\LocalMigration.ps1
Function jmigrate {pushd C:\jobcosting\JobCosting.Persistence; dotnet ef database update; popd}

# Directory shortcuts
Function bet {cd C:\inetpub\wwwroot}
Function jcs {cd C:\jobcosting}
Function tools {cd C:\Users\bend\Documents\Tools}

# Open the powershell profile in notepad
Function prof {code C:\Users\bend\Documents\Tools\Microsoft.PowerShell_profile.ps1}
Function updateprof {Copy-Item "C:\Users\bend\Documents\Tools\Microsoft.PowerShell_profile.ps1" -Destination "C:\Users\bend\Documents\WindowsPowerShell"}

# Helpful git shortcuts
Function fp {git push --force-with-lease}
Function pushnew($branch) {git push --set-upstream origin $branch}
Function push {git push}
Function plog($modifier) {git log --graph --pretty='format:%n %an %ad %C(auto)%d %n %Creset%<(135,trunc)%s' $modifier}
Function log {git log --pretty='format:%n %an %ad %C(auto)%d %n %Creset%<(149,trunc)%s'}

# Improve the git experience in powershell
Import-Module posh-git
$global:GitPromptSettings.LocalWorkingStatusSymbol.ForegroundColor = [ConsoleColor]::Red
$global:GitPromptSettings.WorkingColor.ForegroundColor = [ConsoleColor]::Red
$global:GitPromptSettings.IndexColor.ForegroundColor = [ConsoleColor]::Green
Set-PSReadlineOption -Colors @{ String = '#c69ee6'}
Set-PSReadlineOption -Colors @{ Parameter = '#9cd1ab'}
Import-Module oh-my-posh
Set-PoshPrompt -Theme atomic