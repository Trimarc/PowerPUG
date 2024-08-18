function Test-PPPasswordOlderThanPug {
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
        [object]$Users
    )

    #requires -Version 5

    begin {
    }

    process {
        $Users | ForEach-Object {
            $PugCreatedDate = $_.Domain | Get-PPPugCreatedDate
            if ($_.LastPasswordSet -lt $PugCreatedDate) {
                Write-Output $true
            } else {
                Write-Output $false
            }
        }
    }

    end {
    }
}
