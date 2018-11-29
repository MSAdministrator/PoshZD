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
function Update-ZDTicket
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
        $TicketObject,

        # Param2 help description
        [Parameter(Mandatory=$true)]
        [int]$TicketNumber
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Update-ZDTicket'

        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/tickets/$TicketNumber.json"
            Method = 'Put'
            Body = $($TicketObject | ConvertTo-Json -Depth 6)
            Headers = $ZDHeaders
            ContentType = 'application/json'
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Update-ZDTicket'

        $Result = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Update-ZDTicket'

        return $Result
    }
}