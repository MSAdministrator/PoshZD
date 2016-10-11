<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-ZDAllTickets
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $OrgID,

        # Param2 help description
        $UserID,

        [Parameter(ParameterSetName = 'User')]
        [switch]$Requested,
        [Parameter(ParameterSetName = 'User')]
        [switch]$CCD,
        [Parameter(ParameterSetName = 'User')]
        [switch]$Assigned


    )

    Begin
    {
        if ($OrgID)
        {
            $URI = "https://$Domain.zendesk.com/api/v2/organizations/$OrgID/tickets.json"
        }

        if ($UserID)
        {
            switch ($PSBoundParameters.Keys)
            {
                'Requested' { $URI = "https://phishme.zendesk.com/api/v2/users/$UserID/tickets/requested.json" }
                'CCD'       { $URI = "https://phishme.zendesk.com/api/v2/users/$UserID/tickets/ccd.json"       }
                'Assigned'  { $URI = "https://phishme.zendesk.com/api/v2/users/$UserID/tickets/assigned.json"  }
            }
        }

        if (($null -eq $UserID) -or ($null -eq $OrgID))
        {
            $URI = "https://phishme.zendesk.com/api/v2/tickets.json"
        }

        $params = @{
            Uri = $URI
            Method = 'Get'
            Headers = $Headers
        }
    }
    Process
    {
        $restresponse = Invoke-RestMethod @params

    }
    End
    {
        return $restresponse
    }
}