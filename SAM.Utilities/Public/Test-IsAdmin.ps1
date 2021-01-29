function Test-IsAdmin {

    <#
        .SYNOPSIS
            Test if the current user is an Administrator.

        .DESCRIPTION
            Test if the current user is an Administrator.

        .EXAMPLE
            PS C:\> $isAdmin = Test-IsAdmin

            This example calls Test-IsAdmin and stores the bool value that was returned in $isAdmin.

        .INPUTS
            None

        .LINK
            https://docs.microsoft.com/en-us/dotnet/api/system.security.principal.windowsidentity?view=dotnet-plat-ext-5.0
            https://docs.microsoft.com/en-us/dotnet/api/system.security.principal.windowsidentity.getcurrent?view=dotnet-plat-ext-5.0#System_Security_Principal_WindowsIdentity_GetCurrent
    #>

    [CmdletBinding()]
    [OutputType([bool])]
    param ()

    [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

}
