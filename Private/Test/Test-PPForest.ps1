function Test-PPForest {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PugForest
    )

    #requires -Version 5

    begin {
        if ($null -eq $PugForest) {
            $PugForest = Get-PPForest
        }
    }
    
    process {
        $PugForest | ForEach-Object {
            $PugFFL = $false
            if ($_.ForestModeLevel -ge 6) {
                $PugFFL = $true 
            }

            $Return = [PSCustomObject]@{
                Name  = $_.Name
                Value = $PugFFL
            }
            
            Write-Output $Return
        }
    }

    end {}
}
