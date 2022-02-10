#Open various applications
Set-Alias -Name vs -Value C:\"Program Files"\"Microsoft Visual Studio"\2022\Professional\Common7\IDE\devenv.exe
Set-Alias -Name st -Value C:\Users\bend\AppData\Local\SourceTree\SourceTree.exe
Set-Alias -Name sb -Value C:\ServiceBusExplorer\ServiceBusExplorer.exe

# Perform database migrations
Function migrate {jmigrate; bmigrate}
Set-Alias -Name bmigrate -Value C:\Utilities\DevUtilityDotNetCore\LocalMigration.ps1
Function jmigrate {pushd C:\jobcosting\JobCosting.Persistence; dotnet ef database update; popd}

# Directory shortcuts
Set-Alias -Name betenbough -Value C:\inetpub\wwwroot
Set-Alias -Name jobcosting -Value C:\jobcosting
Set-Alias -Name personaltools -Value C:\Users\bend\Documents\Tools
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
Function gits {git status}

Function csb {rm ./Message.xml; rm ./Properties.xml}

# Improve the git experience in powershell
Function colorGit ($location) {
pushd $location
git config color.status.branch "yellow bold"
git config color.status.nobranch "magenta bold"
git config color.status.unmerged "red bold"
git config color.status.added "green bold"
git config color.status.changed "red bold"
git config color.status.untracked "red bold"
popd
}
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme atomic
colorGit C:\inetpub\wwwroot
colorGit C:\jobcosting
colorGit C:\Users\bend\Documents\Tools
Set-PSReadlineOption -Colors @{ String = '#c69ee6'}
Set-PSReadlineOption -Colors @{ Parameter = '#9cd1ab'}