function Get-PPMissingMembers {
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

    begin {
        if ($null -eq $Domains) {
            $Domains = Get-PPDomain
        }
    }

    process {
        $Domains | ForEach-Object {
            # $domain = $_
            # $GroupMembership = $_ | Get-PPPugGroupSid | Expand-PPGroupMembership | Sort-Object -Unique
            # $AdaGroupMembership = $_ | Get-PPAdaGroupSid | Expand-PPGroupMembership | Sort-Object -Unique

            # $NotInPug = $AdaGroupMembership | Where-Object { $GroupMembership -notcontains $_ } 

            # $NotInPug | ForEach-Object {
            #     Write-Output $_
            # }
        }
    }

    end {

    }
}
