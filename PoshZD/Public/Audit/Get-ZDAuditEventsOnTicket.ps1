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
        Write-Verbose -Message 'Creating parameters from Get-ZDAuditEventsOnTicket'
        
        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/tickets/$TicketId/audits.json"
            Method = 'Get'
            Headers = $ZDHeaders
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDAuditEventsOnTicket'

        $Result = Invoke-RestMethod @params

    }
    End
    {
        Write-Verbose -Message 'Returning results from Get-ZDAuditEventsOnTicket'

        return $Result
    }
}