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
function Remove-ZDSuspendedTicket
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
        Write-Verbose -Message 'Creating parameters from Remove-ZDSuspendedTicket'

        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/suspended_tickets/destroy_many.json?ids=$($IDs -join ",")"
            Method = 'DELETE'
            Headers = $ZDHeaders
        }

        Write-Verbose -Message 'Invoking Rest Method from Remove-ZDSuspendedTicket'

        $Result = Invoke-RestMethod @params

    }
    End
    {
        Write-Verbose -Message 'Returning results from Remove-ZDSuspendedTicket'

        return $Result
    }
}