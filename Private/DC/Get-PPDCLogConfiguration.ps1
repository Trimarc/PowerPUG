function Get-PPDCLogConfiguration {
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
        [object[]]$DC
    )

    #requires -Version 5

    begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand) on $env:COMPUTERNAME..."
         if ($null -eq $DC) {
            $DC = Get-PPDC
        }
    }

    process {
        $DC | ForEach-Object {
            try {
                $Session = New-PSSession -ComputerName $_
            } catch {
                Write-Warning "PowerPUG! could not create a remote session on $_"
            }

            Send-PPFunctionToRemote -FunctionName Get-PPDCAuditPolicy -Session $Session
            Invoke-Command -Session $Session -ScriptBlock { Get-PPDCAuditPolicy }
        }
    }

    end {
    }
}
