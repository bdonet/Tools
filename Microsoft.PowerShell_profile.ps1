# Directory shortcuts
$repos = "C:\Repos"
$personaltools = "$repos\Tools"
$keymaps = "$repos\QMKKeymaps"
Function tools {Set-Location $personaltools}
Function qmk {Set-Location $keymaps}

$ttucsc = "$repos\CSC"
$ttuhrms = "$repos\HRMS"
$ttugenetecapi = "$repos\GenetecDataAPI"
$ttutpscitationapp = "$repos\TPSCitationApp"
$ttukms = "$repos\odkms"
$ttuutilitybilling = "$repos\UtilitiesBillingApp"
$ttudesignrepos = "$HOME\OneDrive - Texas Tech University\Design Repos"
$ttuparser = "$repos\FormulaParser"
$ttuchemistrylogger = "$repos\ChemistryLogger"
$ttuauth = "$repos\TTUAuth"
$ttuidoffice = "$repos\IDOffice"
$ttumip = "$repos\odmip"
$tturesharper = "$HOME\AppData\Roaming\JetBrains\Shared\vAny"
$ttuswaat = "$repos\swaat"
$tturideshare = "$repos\RideShareAPI"
Function csc {Set-Location $ttucsc}
Function hrms {Set-Location $ttuhrms}
Function gapi {Set-Location $ttugenetecapi}
Function tps {Set-Location $ttutpscitationapp}
Function kms {Set-Location $ttukms}
Function billing {Set-Location $ttuutilitybilling}
Function design {Set-Location $ttudesignrepos}
Function parser {Set-Location $ttuparser}
Function chem {Set-Location $ttuchemistrylogger}
Function auth {Set-Location $ttuauth}
Function id {Set-Location $ttuidoffice}
Function mip {Set-Location $ttumip}
Function resharper {Set-Location $tturesharper}
Function swaat {Set-Location $ttuswaat}
Function rideshare {Set-Location $tturideshare}

# Open various applications
$vs = "C:\Program Files\Microsoft Visual Studio\2022\Professional"
Set-Alias -Name vs -Value $vs\Common7\IDE\devenv.exe
Set-Alias -Name vs2019 -Value "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe"
Set-Alias -Name music -Value $HOME\AppData\Roaming\Spotify\Spotify.exe

# Open the powershell profile in notepad
Function profile {code $personaltools\Microsoft.PowerShell_profile.ps1}

# Copy the profile from tools into Powershell 5 and 7 profile directories
Function updateprofile
{
    Copy-Item $personaltools\Microsoft.PowerShell_profile.ps1 -Destination "\\opsdivfs03\Personal\bedonet\Documents\WindowsPowerShell";
    Copy-Item $personaltools\Microsoft.PowerShell_profile.ps1 -Destination "\\opsdivfs03\Personal\bedonet\Documents\PowerShell";
}

# Visual Studio utilties
Set-Alias -name msbuild -Value "$vs\MSBuild\Current\Bin\msbuild.exe"
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
    cleanrepo;
    restoreall;
    buildall;
}

# Helpful git shortcuts
Function fp {git push --force-with-lease}
Function pn {git push -u origin HEAD}
Function createbranch($branchName) {git checkout -b $branchName; pn}
Function deletebranch($branchName) {git push origin -d $branchName; git branch -d $branchName}
Function p {git push}
Function plog($modifier) {git log --graph --pretty='format: %an %ad %C(auto)%d %n %Creset%<(135,trunc)%s %n' $modifier}
Function log {git log --color --pretty='format:%n %an %ad %C(yellow bold)%h %C(auto)%d %n %Creset%<(149,trunc)%s'}
Function llog {git log --color --pretty='format:%n %an %ad %C(yellow bold)%h %C(auto)%d %n %Creset%s %n %b'}
Function gits {git status}
Function f {git fetch}
Function commitdiff($commit) {git diff $commit~ $commit}
Function commitfilediff($commit) {git diff $commit~ $commit --name-status}
Function prune {git remote prune origin}
Function cleanrepo {git clean -xdfe *.lic}
Function rc
{
    git add *;
    git commit --no-edit;
    git rebase --continue
}

# Helpful file search command
Function searchChildren($pattern) {Get-ChildItem -path "." -Recurse | Select-String -Pattern $pattern}

# NuGet package shortcuts
Function nugetPack {dotnet pack}
Function nugetPublish($packagePath) {nuget push -Source "TexasTechUniversity_OperationsDivision_NugetFeed" -ApiKey "key" $packagePath}

# Improve the git experience in powershell
Import-Module posh-git
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\atomic.omp.json" | Invoke-Expression

Set-PSReadlineOption -Colors @{ String = '#c69ee6'}
Set-PSReadlineOption -Colors @{ Parameter = '#9cd1ab'}
