function Test-PPForestFL {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$Forest
    )

    #requires -Version 5

    begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
     }
    
    process {
        $Forest | ForEach-Object {
            if ($_.ForestModeLevel -ge 6) {
                Write-Output $true 
            } else {
                Write-Output $false
            }
        }
    }

    end {
        Write-Verbose "Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    }
}
