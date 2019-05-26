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
