function Get-PPDomainAdminGroupSid {
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
        [object]$Domains
    )

    #requires -Version 5

    begin {
        if ($null -eq $Domains) {
            $Domains = Get-PPDomain
        }
    }

    process {
        Write-Output $Domains -PipelineVariable domain | ForEach-Object {
            $DomainSid = $domain | Get-PPDomainSid
            @('S-1-5-32-544',"$DomainSid-512") | ForEach-Object {
                $AdaGroupSid = [System.Security.Principal.SecurityIdentifier]::New($_)
                $AdaGroupSid | Add-Member -NotePropertyName Domain -NotePropertyValue $domain -Force
                Write-Output $AdaGroupSid
            }
        }
    }

    end {
    }
}
