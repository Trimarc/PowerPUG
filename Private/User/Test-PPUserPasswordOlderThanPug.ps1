function Test-PPUserPasswordOlderThanPug {
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
        [object]$User
    )

    #requires -Version 5

    begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
     }

    process {
        $User | ForEach-Object {
            $PugCreatedDate = $_.Domain | Get-PPDomainPugCreatedDate
            if ($_.LastPasswordSet -lt $PugCreatedDate) {
                Write-Output $true
            } else {
                Write-Output $false
            }
        }
    }

    end {
        Write-Verbose "Finishing $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."    }
}
