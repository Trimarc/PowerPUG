function Test-PPDcOs {
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
        [object]$PPDcs
    )

    #requires -Version 5

    begin {
        if ($null -eq $PPDcs) {
            $PPDcs = Get-PPDc
        }

        $DcOsWithPugArray = @(
            'Windows Server 2025 Standard',
            'Windows Server 2025 Datacenter',
            'Windows Server 2022 Standard',
            'Windows Server 2022 Datacenter',
            'Windows Server 2019 Standard',
            'Windows Server 2019 Datacenter',
            'Windows Server 2016 Standard',
            'Windows Server 2016 Datacenter',
            'Windows Server 2012 R2 Standard',
            'Windows Server 2012 R2 Datacenter'
        )
    }

    process {
        $PPDcs | ForEach-Object {
            $PPOs = $false
            if ($DcOsWithPugArray -contains $_.OSVersion.ToString()) {
                $PPOs = $true
            } 

            $Return = [PSCustomObject]@{
                Name      = $_.Name
                Value     = $PPOs
            }

            Write-Output $Return
        }
    }
    
    end {
    }
}
