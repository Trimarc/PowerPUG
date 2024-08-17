function Test-PPPasswordOlderThanPug {
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
        [object]$Users
    )

    #requires -Version 5

    begin {
    }

    process {
        Write-Output $Users -PipelineVariable user | ForEach-Object {
            $PugCreatedDate = $user.Domain | Get-PPPugCreatedDate
            if ($user.LastPasswordSet -lt $PugCreatedDate) {
                Write-Output $true
            } else {
                Write-Output $false
            }
        }
    }

    end {
    }
}
