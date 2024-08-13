function Get-PPMissingMembers {
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

    begin {
        if ($null -eq $PPDomains) {
            $PPDomains = Get-PPDomain
        }
    }

    process {
        $PPDomains | ForEach-Object {
            # $domain = $_
            $PPGroupMembership = $_ | Get-PPPugGroupSid | Expand-PPGroupMembership | Sort-Object -Unique
            $AdaGroupMembership = $_ | Get-PPAdaGroupSid | Expand-PPGroupMembership | Sort-Object -Unique

            $NotInPug = $AdaGroupMembership | Where-Object { $PPGroupMembership -notcontains $_ } 

            $NotInPug | ForEach-Object {
                Write-Output $_
            }
        }
    }

    end {

    }
}
