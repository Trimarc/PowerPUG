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
        Write-Output $GroupSids -PipelineVariable sid | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain',$sid.Domain)
            $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext,$sid.Value)
            $GroupPrincipal.GetMembers($true) | ForEach-Object {
                $DomainSid = $sid.Domain | Get-PPDomainSid
                $_ | Add-Member -NotePropertyName Domain -NotePropertyValue $sid.Domain -Force
                Write-Output $_
            }
        }
    }

    end {
    }
}
