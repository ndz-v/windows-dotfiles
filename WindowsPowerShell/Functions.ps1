function get-key {
    Param([string]$a)
    netsh.exe wlan show profile name=$a key=clear
}

function dotfiles {
    code "$HOME\dev\windows-dotfiles"
}

function Get-ComputerInfo {
    param (
        [Parameter(
            ValueFromPipeline
        )]
        [string]$ComputerName
    )
  
    process {
        $CIMSession = New-CimSession @PSBoundParameters
        $PSDefaultParameterValues = @{
            'Get-CimInstance:CimSession' = $CIMSession
        }
        $CompInfo = Get-CimInstance -ClassName Win32_ComputerSystem
        $OSInfo = Get-CimInstance -ClassName Win32_OperatingSystem
  
        [PSCustomObject]@{
            Name   = $CompInfo.Name
            User   = $CompInfo.UserName
            Domain = $CompInfo.Domain
            Model  = $CompInfo.Model
            OS     = $OSInfo.Caption
            SP     = $OSInfo.CSDVersion
        } | Add-Member -TypeName My.Type -NotePropertyMembers ([ordered]@{
                Created = Get-Date
                Author  = $env:USERNAME
            }) -PassThru
    }
}
 
function Git-LogLive() {
    <# 
	.SYNOPSIS 
		Outputs git log information live.
	.DESCRIPTION 
		Outputs log information in a loop with a specified polling rate.
	.PARAMETER lines
		The number of log lines to output.
	.PARAMETER sleep
		The poll rate of the log in seconds (decimals okay).
	#>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false, Position = 1)]
        [string]$lines = 20,
		
        [Parameter(Mandatory = $false, Position = 2)]
        [string]$sleep = 10
    )
	
    while ($true) {
        cls
        git --no-pager log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold white)<%an>%Creset' --abbrev-commit --date=relative --all -$lines
        sleep $sleep
    }
}
