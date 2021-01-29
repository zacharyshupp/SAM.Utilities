function ConvertTo-UNCPath {

    <#
        .SYNOPSIS
            Creates a UNC path from Local Path.

        .DESCRIPTION
            Creates a UNC path from Local Path.

        .EXAMPLE
            PS C:\> ConvertTo-UNCPath -ComputerName "Computer1" -Path "C:\Temp\Test\"

            This example shows the basic usage for ConvertTo-UNCPath. The output for this is '\\Computer1\C$\Temp\Test'.

            Output:
                \\Computer1\C$\Temp\Test

        .EXAMPLE
            PS C:\> ConvertTo-UNCPath -ComputerName "Computer1", "Computer2" -Path "C:\Temp\Test\"

            This example shows that multiple computernames can be passed.

            Output:
                \\Computer1\C$\Temp\Test
                \\Computer2\C$\Temp\Test

    #>

    [CmdletBinding()]
    [OutputType([string])]
    param (

        # Specifies the computer name to convert.
        [Parameter(Mandatory = $true,ValueFromPipelineByPropertyName = $true)]
        [String[]]
        $ComputerName,

        # Specifies the local path to convert.
        [Parameter(Mandatory = $true,ValueFromPipelineByPropertyName = $true)]
        [String]
        $Path

    )

    process {

        $ComputerName | ForEach-Object {

            $computer = $_

            $uncPath = $Path -replace (":", "$")

            If ( $uncPath.EndsWith( "\" ) ) { $uncPath = $uncPath -replace ("\\$", "") }

            "\\{0}\{1}" -f $computer, $uncPath
        }

    }

}
