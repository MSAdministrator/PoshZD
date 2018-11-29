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
function Restore-ZDSuspendedTicket
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
        [long[]]$TicketId
    )

    Begin
    {
        $IDs = @()

        foreach ($item in $TicketId)
        {
            $IDs += $item
        }
        
    }
    Process
    {
        Write-Verbose -Message 'Creating parameters from Restore-ZDSuspendedTicket'

        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/suspended_tickets/recover_many.json?ids=$($IDs -join ",")"
            Method = 'Put'
            Headers = $ZDHeaders
            ContentType = 'application/json'
        }

        Write-Verbose -Message 'Invoking Rest Method from Restore-ZDSuspendedTicket'

        $Result = Invoke-RestMethod @params

    }
    End
    {
        Write-Verbose -Message 'Returning results from Restore-ZDSuspendedTicket'

        return $Result.suspended_tickets
    }
}