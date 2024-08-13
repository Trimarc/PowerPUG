function Get-PPPugGroupSid {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
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
            $DomainName = $_.Name
            $DomainSid = $_ | Get-PPDomainSid
            @("$DomainSid-525") | ForEach-Object {
                $PPGroupSid = [System.Security.Principal.SecurityIdentifier]::New($_)
                $PPGroupSid | Add-Member -NotePropertyName Domain -NotePropertyValue $DomainName -Force
                Write-Output $PPGroupSid
            }
        }
    }

    end {
    }
}
