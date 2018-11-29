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
function New-ZDTicket
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
        Write-Verbose -Message 'Creating parameters from New-ZDTicket'

        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/tickets.json"
            Method = 'Post'
            Body = $($TicketObject | ConvertTo-Json)
            Headers = $Headers
            ContentType = 'application/json'
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from New-ZDTicket'

        $Result = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from New-ZDTicket'

        return $Result
    }
}