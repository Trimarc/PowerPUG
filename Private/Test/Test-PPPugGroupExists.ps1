function Test-PPPugGroupExists {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [object]$PugGroupSids
    )

    #requires -Version 5

    begin {
        if ($null -eq $PugGroupSid) {
            $PugGroupSids = Get-PPPugGroupSid
        }
        Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        $PugGroupSids | ForEach-Object {
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain',$_.Domain)
            $PugGroupExists = $false
            try {
                $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext,$_.Value)
                $GroupPrincipal.GetMembers() | Out-Null
                $PugGroupExists = $true
            } catch {
            }

            $Return = [PSCustomObject]@{
                Name  = $_.Domain
                Value = $PugGroupExists
            }

            Write-Output $Return
        }
    }

    end {
    }
}
