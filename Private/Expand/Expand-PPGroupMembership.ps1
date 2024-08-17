function Expand-PPGroupMembership {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER Parameter

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    # TODO Update to handle users with non-standard PGID
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        $GroupSids
    )

    #requires -Version 5

    begin {
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        $GroupSids | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain',$_.Domain)
            $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext,$_.Value)
            $GroupPrincipal.GetMembers($true) | ForEach-Object {
                Write-Host $_
                $DomainSid = $_.Domain | Get-PPDomainSid
                $IsPugMember = $_.IsMemberOf($PrincipalContext,'Sid',"$DomainSid-525")
                $_ | Add-Member -NotePropertyName IsPugMember -NotePropertyValue $IsPugMember -Force
                Write-Output $_
            }
        }
    }

    end {
    }
}
