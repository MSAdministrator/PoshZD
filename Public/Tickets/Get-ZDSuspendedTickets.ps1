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
function Get-ZDSuspendedTickets
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(ParameterSetName = 'All',
                   Mandatory=$true,
                   ValueFromPipeline=$true)]
        [switch]$All,

        # Param2 help description
        [Parameter(ParameterSetName = 'Single',
                   Mandatory=$true,
                   ValueFromPipeline=$true)]
        [long]$TicketId
    )

    Begin
    {
        if ($TicketId)
        {
            $URI = "https://$Domain.zendesk.com/api/v2/suspended_tickets/$TicketId.json"
        }

        if ($All)
        {
            $URI = "https://$Domain.zendesk.com/api/v2/suspended_tickets.json"

        }

        $params = @{
            Uri = $URI
            Method = 'Get'
            Headers = $Headers
        }
    }
    Process
    {
        $Result = Invoke-RestMethod @params

    }
    End
    {
        return $Result.suspended_tickets
    }
}