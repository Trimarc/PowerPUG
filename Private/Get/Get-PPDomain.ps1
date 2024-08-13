function Get-PPDomain {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PPForest
    )

    #requires -Version 5

    begin {
        if ($null -eq $PPForest) {
            $PPForest = Get-PPForest
        }
    }

    process {
        $PPForest.Domains | ForEach-Object {
            Write-Output $_
        }
    }

    end {
    }
}
