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
function Get-ZDAuditEventsOnTicket
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param2 help description
        [Parameter(ParameterSetName = 'Single',
                   Mandatory=$true,
                   ValueFromPipeline=$true)]
        [long]$TicketId
    )

    Begin
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/tickets/$TicketId/audits.json"
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
        return $Result
    }
}