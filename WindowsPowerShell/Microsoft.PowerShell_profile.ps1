Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Import-Module posh-git

$profile_folder = "$env:USERPROFILE\Documents\WindowsPowerShell"
Import-Module $("$profile_folder\Functions.ps1")

$LAMBDA = ([char]955)

function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    $path = Convert-Path .
    
    if ($path -eq "") {
        "$pwd $LAMBDA"
    }
    else {
        Write-Host "$(Split-Path $pwd -Leaf)" -NoNewline 
    }
    Write-VcsStatus
    Write-Host " $LAMBDA" -NoNewline

    $global:LASTEXITCODE = $realLASTEXITCODE
    $host.UI.RawUI.WindowTitle = $pwd
    return " "
}

Pop-Location

Set-Alias -Name "ll" -Value "Get-ChildItem"
