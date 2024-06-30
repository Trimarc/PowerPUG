function Test-PUGDomain {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]$PUGDomain
    )

    #requires -Version 5

    if ($PUGDomain.DomainModeLevel -lt 6) {
        $false
    } else {
        $true
    }
}
