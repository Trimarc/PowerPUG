function Test-PPDomainPugExists {
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
        [object]$Domain
    )

    #requires -Version 5

    begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
         Add-Type -AssemblyName 'System.DirectoryServices.AccountManagement'
    }

    process {
        $Domain | ForEach-Object {
            $PugExists = $false
            $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::New('Domain',$_)
            $PugSid = Get-PPDomainPugSid -Domain $_
            try {
                $GroupPrincipal = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity($PrincipalContext,$PugSid)
                $GroupPrincipal.GetMembers() | Out-Null
                $PugExists = $true
            } catch {
            }

            Write-Output $PugExists
        }
    }

    end {
    }
}
