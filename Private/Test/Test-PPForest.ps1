function Test-PPForest {
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
        $PPForest | ForEach-Object {
            $PPFFL = $false
            if ($_.ForestModeLevel -ge 6) {
                $PPFFL = $true 
            }

            $Return = [PSCustomObject]@{
                Name  = $_.Name
                Value = $PPFFL
            }
            
            Write-Output $Return
        }
    }

    end {}
}
