function GitLogLive() {
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
        Clear-Host
        git --no-pager log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold white)<%an>%Creset' --abbrev-commit --date=relative --all -$lines
        Start-Sleep $sleep
    }
}
