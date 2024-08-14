function Get-PPNTLMLogon {
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
        [System.DirectoryServices.AccountManagement.UserPrincipal[]]$AdaMembers
    )

    #requires -Version 5

    begin {
    }

    process {
        $AdaMembers | ForEach-Object {
            $filter = @"
*[EventData
    [Data
        [@Name='AuthenticationPackageName']
        and
        (Data='NTLM' or Data='Negotiate')
    ]
    [Data[@Name='TargetUserName']='$($_.Name)']
]
[System
    [(EventID=4624 or EventID=4625)]
]
"@
            $filter = @"
*[EventData
    [Data
        [@Name='AuthenticationPackageName']
    ]
    [Data[@Name='TargetUserName']='PKI Admin']
]
[System
    [(EventID=4624 or EventID=4625)]
]
"@
            Write-Host "Checking Security log for NTLM logons from $($_.Name)`: "
            try {
                Get-WinEvent -FilterXPath $filter -LogName Security -ErrorAction Stop |
                    Select-Object -Last 1 # -ExpandProperty Message |
                    # Out-Null
                Pause
                # Write-Host "Recent NTLM logon found for $($_.Name)" -ForegroundColor Red
            } catch {
                # Write-Host "No NTLM logons found for $($_.Name)"
            }
        }
    }

    end {
    }
}
