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
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/suspended_tickets/destroy_many.json?ids=$($IDs -join ",")"
            Method = 'DELETE'
            Headers = $Headers
        }

        $Result = Invoke-RestMethod @params

    }
    End
    {
        return $Result
    }
}