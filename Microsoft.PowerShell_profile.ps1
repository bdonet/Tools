# Directory shortcuts
$personaltools = "C:\Repos\Tools"
$keymaps = "C:\Repos\QMKKeymaps"
Function tools {Set-Location $personaltools}
Function qmk {Set-Location $keymaps}

# Open various applications
$vs = "C:\Program Files\Microsoft Visual Studio\2022"
Set-Alias -Name vs -Value $vs\Professional\Common7\IDE\devenv.exe
Set-Alias -Name ssms -Value C:\"Program Files (x86)"\"Microsoft SQL Server Management Studio 18"\Common7\IDE\Ssms.exe
Set-Alias -Name music -Value C:\Users\bend\AppData\Roaming\Spotify\Spotify.exe

# Open the powershell profile in notepad
Function profile {code $personaltools\Microsoft.PowerShell_profile.ps1}
Function updateprofile {Copy-Item "C:\Users\bend\Documents\Tools\Microsoft.PowerShell_profile.ps1" -Destination "C:\Users\bend\Documents\WindowsPowerShell"}

# Visual Studio utilties
Set-Alias -name msbuild -Value "$vs\Professional\MSBuild\Current\Bin\msbuild.exe"
Set-Alias -name nuget -Value "C:\Program Files (x86)\NuGet\nuget.exe"
Function build ($solution) {msbuild -nologo -v:q -clp:ErrorsOnly ./$solution}
Function restore ($solution) {nuget restore -verbosity quiet ./$solution}
Function test ($solution) {dotnet test -v q --nologo --no-build --filter Tests.Unit ./$solution}
Function buildall
{
    Write-Host "Building all solutions..." -ForegroundColor Cyan;
    $solutions = Get-ChildItem -Name -Recurse -Include "*.sln" -Exclude "*SQLCLR*","*winforms*";
    foreach ($solution in $solutions)
    {
        Write-Output $solution;
        build $solution;
    }
}
Function restoreall
{
    Write-Host "Restoring all solutions..." -ForegroundColor Cyan;
    $solutions = Get-ChildItem -Name -Recurse -Include "*.sln" -Exclude "*SQLCLR*","*winforms*";
    foreach ($solution in $solutions)
    {
        Write-Output $solution;
        restore $solution;
    }
}
Function testall
{
    Write-Host "Testing all projects... " -ForegroundColor Cyan;
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
Function createbranch($branchName) {git checkout -b $branchName; pn}
Function deletebranch($branchName) {git push origin -d $branchName}
Function p {git push}
Function plog($modifier) {git log --graph --pretty='format: %an %ad %C(auto)%d %n %Creset%<(135,trunc)%s %n' $modifier}
Function log {git log --color --pretty='format:%n %an %ad %C(yellow bold)%h %C(auto)%d %n %Creset%<(149,trunc)%s'}
Function gits {git status}
Function f {git fetch}
Function commitdiff($commit) {git diff $commit~ $commit}
Function commitfilediff($commit) {git diff $commit~ $commit --name-status}
Function clean {git clean -xdfe *.lic}
Function rc
{
    git add *;
    git commit --no-edit;
    git rebase --continue
}

Function csb {Remove-Item ./Message.xml; Remove-Item ./Properties.xml}

# NuGet package shortcuts
Function packNuGet {dotnet pack}
Function publishNuGet($feedName, $packagePath) {dotnet nuget push --interactive --source $feedName --api-key "key" $packagePath}

# Improve the git experience in powershell
Function colorGit
{
    git config color.status.branch "yellow bold"
    git config color.status.nobranch "magenta bold"
    git config color.status.unmerged "red bold"
    git config color.status.added "green bold"
    git config color.status.changed "red bold"
    git config color.status.untracked "red bold"
    git config color.grep.filename "yellow bold"
    git config color.diff.new "green bold"
    git config color.diff.old "red bold"
}
Function setupGit ($location)
{
    Push-Location $location
    colorGit
    git config commit.verbose 1
    Pop-Location
}

Import-Module posh-git
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\atomic.omp.json" | Invoke-Expression

setupGit $personaltools
setupGit $keymaps

Set-PSReadlineOption -Colors @{ String = '#c69ee6'}
Set-PSReadlineOption -Colors @{ Parameter = '#9cd1ab'}
