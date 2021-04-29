Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

$scripts_folder = "$HOME\Documents\WindowsPowerShell\Scripts\"
Import-Module "$scripts_folder\GitLogLive.ps1", "$scripts_folder\Get-ComputerInfo.ps1"
Import-Module posh-git

$is_conemu = $env:ConEmuANSI

if ($is_conemu -eq "ON") {
    Import-Module oh-my-posh
    Set-PoshPrompt robbyrussel
}
else {
    function global:prompt {
        $realLASTEXITCODE = $LASTEXITCODE
        Write-Host "$(Split-Path $pwd -Leaf) >" -NoNewline
        "$(Write-VcsStatus) "
        $global:LASTEXITCODE = $realLASTEXITCODE 
        return " "
    }
}
$host.UI.RawUI.WindowTitle = $pwd

Pop-Location
Set-Alias -Name "ll" -Value "Get-ChildItem"
function Show-Wlan { Param([string]$a)netsh.exe wlan show profile name=$a key=clear }
function dotfiles { code "$HOME\dev\windows-dotfiles" }
function admin { powershell -NoLogo -new_console:a }

# Pipe to wsl to use some linux goodies

# German
function de {
    param (
        [string]$text
    )
    wsl trans :de $text
}

# Egnlish
function en {
    param (
        [string]$text
    )
    wsl trans :en $text
}

# Serbian
function sr {
    param (
        [string]$text
    )
    wsl trans :sr $text
}


# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
