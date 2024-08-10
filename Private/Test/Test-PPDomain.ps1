function Test-PPDomain {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PugDomains
    )

    #requires -Version 5

    begin {
        if ($null -eq $PugDomains) {
            $PugDomains = Get-PPDomain
        }
    }
    
    process {
        $PugDomains | ForEach-Object {
            $PugLevel = $false
            if ($_.DomainModeLevel -ge 6) {
                $PugLevel = $true 
            }

            $Return = [PSCustomObject]@{
                Name  = $_.Name
                Value = $PugLevel
            }
            
            Write-Output $Return
        }
    }

    end {}
}
