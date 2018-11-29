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
        Write-Verbose -Message 'Creating parameters from Get-ZDSuspendedTickets'

        if ($TicketId)
        {
            $URI = "https://$env:ZDDomain.zendesk.com/api/v2/suspended_tickets/$TicketId.json"
        }

        if ($All)
        {
            $URI = "https://$env:ZDDomain.zendesk.com/api/v2/suspended_tickets.json"

        }

        $params = @{
            Uri = $URI
            Method = 'Get'
            Headers = $ZDHeaders
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDSuspendedTickets'

        $Result = Invoke-RestMethod @params

    }
    End
    {
        Write-Verbose -Message 'Returning results from Get-ZDSuspendedTickets'

        return $Result.suspended_tickets
    }
}