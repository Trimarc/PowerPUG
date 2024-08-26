function Test-PPUserPugMember {
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
        [object[]]$User,
        [object[]]$PugMembership
    )

    #requires -Version 5

    begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
         if ($null -eq $PugMembership) {
            $PugMembership = Get-PPDomainPugSid | Expand-PPGroupMembership
        } 
    }

    process {
        $User | ForEach-Object {
            if ($PugMembership -contains $_) {
                Write-Output $true
            } else {
                Write-Output $false
            }
        }
    }

    end {
    }
}
