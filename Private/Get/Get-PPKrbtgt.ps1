function Get-PPKrbtgt {
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
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
        if ($null -eq $Domains) {
            $Domains = Get-PPDomain
        }
    }

    process {
        $Domains | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain',$_.Name)
            $DomainSid = $_ | Get-PPDomainSid
            $KrbtgtSid = [System.Security.Principal.SecurityIdentifier]::New("$DomainSid-502")
            [System.DirectoryServices.AccountManagement.UserPrincipal]::FindByIdentity($PrincipalContext,$KrbtgtSid)
        }
    }

    end {
    }
}
