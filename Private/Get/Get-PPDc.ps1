function Get-PPDc {
    <#
        .SYNOPSIS

        .DESCRIPTION

        .PARAMETER

        .INPUTS

        .OUTPUTS

        .EXAMPLE

        .LINK
    #>
    [CmdletBinding()]
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
        $PPDomains.Name | ForEach-Object -PipelineVariable domain {
            $DirectoryContext = [System.DirectoryServices.ActiveDirectory.DirectoryContext]::New(0,$_)
            [System.DirectoryServices.ActiveDirectory.DomainController]::FindAll($DirectoryContext) | ForEach-Object {
                Write-Output $_
            }
        }
    }

    end {
    }
}
