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
function Import-ZDTicket
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [PSTypeName('PoshZD.Ticket')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        $TicketObject
    )

    Begin
    {
        
    }
    Process
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/imports/tickets.json"
            Method = 'Post'
            Body = $($TicketObject | ConvertTo-Json)
            Headers = $Headers
            ContentType = 'application/json'
        }

        $Result = Invoke-RestMethod @params
    }
    End
    {
        return $Result
    }
}