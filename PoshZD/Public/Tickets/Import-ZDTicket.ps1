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
        Write-Verbose -Message 'Creating parameters from Import-ZDTicket'
        
        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/imports/tickets.json"
            Method = 'Post'
            Body = $($TicketObject | ConvertTo-Json)
            Headers = $ZDHeaders
            ContentType = 'application/json'
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Import-ZDTicket'

        $Result = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Import-ZDTicket'

        return $Result
    }
}