function Test-PPIsDc {
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
    )

    #requires -Version 5

    begin {
    }

    process {
    }

    end {
        if (Get-CimInstance -Class CIM_OperatingSystem | Where-Object ProductType -eq 2) {
            Write-Output $true
        } else {
            Write-Output $false
        }
    }
}
