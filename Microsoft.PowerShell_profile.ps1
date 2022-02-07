# Open visual studio with same admin permissions as the shell instance
Set-Alias -Name vs -Value C:\"Program Files"\"Microsoft Visual Studio"\2022\Professional\Common7\IDE\devenv.exe

# Open Sourcetree
Set-Alias -Name st -Value C:\Users\bend\AppData\Local\SourceTree\SourceTree.exe

# Open the Service Bus Explorer
Set-Alias -Name sb -Value C:\ServiceBusExplorer\ServiceBusExplorer.exe

# Run local Betenbough DB migrations for the current branch
Set-Alias -Name migrate -Value C:\Utilities\DevUtilityDotNetCore\LocalMigration.ps1

# Run local JobCosting DB migrations for the current branch
Function jmigrate {pushd C:\jobcosting\JobCosting.Persistence; dotnet ef database update; popd}

# Change the directory to the Betenbough repo
Function bet {cd C:\inetpub\wwwroot}

# Change the directory to the Job Costing repo
Function jcs {cd C:\jobcosting}

# Change to my personal Tools repo
Function tools {cd C:\Users\bend\Documents\Tools}

# Clear the console
Set-Alias -Name c -Value clear

# Open git bash in the Betenbough directory
Function gbet {pushd C:\inetpub\wwwroot; C:\"Program Files"\Git\git-bash.exe; popd}

# Open the powershell profile in notepad
Function prof {code C:\Users\bend\Documents\Tools\Microsoft.PowerShell_profile.ps1}

# Force push to the current branch with lease using git
Function fp {git push --force-with-lease}

# Push a new branch and set it as the upstream origin
Function pushnew($branch) {git push --set-upstream origin $branch}

# Push the current branch
Function push {git push}

# Show the git log
Function plog($modifier) {git log --graph --pretty='format:%n %an %ad %C(auto)%d %n %Creset%<(135,trunc)%s' $modifier}
Function log {git log --pretty='format:%n %an %ad %C(auto)%d %n %Creset%<(149,trunc)%s'}

# Add git a lot of git power/visibility to the shell
Import-Module posh-git

# Change some colors to make git more readable
$global:GitPromptSettings.LocalWorkingStatusSymbol.ForegroundColor = [ConsoleColor]::Red
$global:GitPromptSettings.WorkingColor.ForegroundColor = [ConsoleColor]::Red
$global:GitPromptSettings.IndexColor.ForegroundColor = [ConsoleColor]::Green
Set-PSReadlineOption -Colors @{ String = '#c69ee6'}
Set-PSReadlineOption -Colors @{ Parameter = '#9cd1ab'}

# Add themes for git to the shell
Import-Module oh-my-posh
Set-PoshPrompt -Theme atomic