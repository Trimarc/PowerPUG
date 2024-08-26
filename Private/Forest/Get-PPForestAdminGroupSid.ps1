function Get-PPForestAdminGroupSid {
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
        [object]$Forest
    )

    #requires -Version 5

    begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
         if ($null -eq $Forest) {
            $Forest = Get-PPForest
        }
    }

    process {
        $RootDomainSid = $Forest.RootDomain | Get-PPDomainSid
        @("$RootDomainSid-518","$RootDomainSid-519") | ForEach-Object {
            $AdaGroupSid = [System.Security.Principal.SecurityIdentifier]::New($_)
            $AdaGroupSid | Add-Member -NotePropertyName Domain -NotePropertyValue $Forest.RootDomain -Force
            Write-Output $AdaGroupSid
        }
    }

    end {
    }
}
