function Test-PPDomain {
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
        [Parameter(ValueFromPipeline)]
        [object]$PPDomains
    )

    #requires -Version 5

    begin {
        if ($null -eq $PPDomains) {
            $PPDomains = Get-PPDomain
        }
    }
    
    process {
        $PPDomains | ForEach-Object {
            $PPLevel = $false
            if ($_.DomainModeLevel -ge 6) {
                $PPLevel = $true 
            }

            $Return = [PSCustomObject]@{
                Name  = $_.Name
                Value = $PPLevel
            }
            
            Write-Output $Return
        }
    }

    end {}
}
