# Directory shortcuts
$betenbough = "C:\inetpub\wwwroot"
$jobcosting = "C:\jobcosting"
$accountingservice = "C:\accountingservice"
$personaltools = "C:\Users\bend\Documents\Tools"
$keymaps = "C:\Users\bend\Documents\QMKKeymaps"
$vs = "C:\Program Files\Microsoft Visual Studio\2022"
Function bet {Set-Location $betenbough}
Function jcs {Set-Location $jobcosting}
Function acs {Set-Location $accountingservice}
Function tools {Set-Location $personaltools}
Function qmk {Set-Location $keymaps}

# Open various applications
Set-Alias -Name vs -Value $vs\Professional\Common7\IDE\devenv.exe
Set-Alias -Name st -Value C:\Users\bend\AppData\Local\SourceTree\SourceTree.exe
Set-Alias -Name sb -Value C:\ServiceBusExplorer\ServiceBusExplorer.exe
Set-Alias -Name ase -Value C:\Users\bend\AppData\Local\Programs\"Microsoft Azure Storage Explorer"\StorageExplorer.exe

# Perform database migrations
Function migrate {bmigrate; jmigrate}
Function bmigrate {Start-Process powershell {C:\Utilities\DevUtilityDotNetCore\LocalMigration.ps1}}
Function jmigrate {Push-Location $jobcosting\JobCosting.Persistence; dotnet ef database update; Pop-Location}
Function addMigration ($name)
{
    Push-Location $jobcosting\JobCosting.Persistence;
    dotnet ef migrations add $name;
    Pop-Location;
}

# Open the powershell profile in notepad
Function prof {code $personaltools\Microsoft.PowerShell_profile.ps1}
Function updateprof {Copy-Item "C:\Users\bend\Documents\Tools\Microsoft.PowerShell_profile.ps1" -Destination "C:\Users\bend\Documents\WindowsPowerShell"}

# Visual Studio utilties
Set-Alias -name msbuild -Value "$vs\Professional\MSBuild\Current\Bin\msbuild.exe"
Function build ($solution) {msbuild -nologo -v:q -clp:ErrorsOnly ./$solution}
Function restore ($solution) {nuget restore -verbosity quiet ./$solution}
Function test ($solution) {dotnet test -v q --nologo --no-build --filter Tests.Unit ./$solution}
Function buildall
{
    Write-Output "Building all solutions...";
    $solutions = Get-ChildItem -Name -Recurse -Include "*.sln" -Exclude "*SQLCLR*","*winforms*";
    foreach ($solution in $solutions)
    {
        Write-Output $solution;
        build $solution;
    }
}
Function restoreall
{
    Write-Output "Restoring all solutions...";
    $solutions = Get-ChildItem -Name -Recurse -Include "*.sln" -Exclude "*SQLCLR*","*winforms*";
    foreach ($solution in $solutions)
    {
        Write-Output $solution;
        restore $solution;
    }
}
Function testall
{
    Write-Output "Testing all projects..."
    $solutions = Get-ChildItem -Name -Recurse -Include "*.sln" -Exclude "*SQLCLR*","*winforms*";
    foreach ($solution in $solutions)
    {
        Write-Output $solution;
        test $solution;
    }
}
Function bat
{
    buildall;
    testall;
}
Function resetrepo
{
    clean;
    restoreall;
    buildall;
}

# Helpful git shortcuts
Function fp {git push --force-with-lease}
Function pn {git push -u origin HEAD}
Function p {git push}
Function plog($modifier) {git log --graph --pretty='format: %an %ad %C(auto)%d %n %Creset%<(135,trunc)%s %n' $modifier}
Function log {git log --color --pretty='format:%n %an %ad %C(yellow bold)%h %C(auto)%d %n %Creset%<(149,trunc)%s'}
Function gits {git status}
Function f {git fetch}
Function commitdiff($commit) {git diff $commit~ $commit}
Function clean {git clean -xdfe *.lic}
Function rc
{
    git add *;
    git commit --no-edit;
    git rebase --continue
}

Function csb {Remove-Item ./Message.xml; Remove-Item ./Properties.xml}

# Improve the git experience in powershell
Function colorGit ($location) {
Push-Location $location
git config color.status.branch "yellow bold"
git config color.status.nobranch "magenta bold"
git config color.status.unmerged "red bold"
git config color.status.added "green bold"
git config color.status.changed "red bold"
git config color.status.untracked "red bold"
Pop-Location
}
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme atomic
colorGit $betenbough
colorGit $jobcosting
colorGit $personaltools
Set-PSReadlineOption -Colors @{ String = '#c69ee6'}
Set-PSReadlineOption -Colors @{ Parameter = '#9cd1ab'}