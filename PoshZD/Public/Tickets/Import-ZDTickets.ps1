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
function Import-ZDTickets
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
        [ValidateScript({If ($_.count -le 100) {$True} Else {Throw "$_ has more than 100 ticket objects."}})]
        [PoshZD.Ticket[]]$TicketObject
    )

    Begin
    {
        $ReturnObject = @()
    }
    Process
    {
        Write-Verbose -Message 'Creating parameters from Import-ZDTickets'

        foreach ($item in $TicketObject)
        {
            $Result = @()

            $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/imports/tickets/create_many.json"
                Method = 'Post'
                Body = $($item | ConvertTo-Json)
                Headers = $ZDHeaders
                ContentType = 'application/json'
            }

            $Result = Invoke-RestMethod @params
            $ReturnObject += $Result
        }
    }
    End
    {
        Write-Verbose -Message 'Returning results from Import-ZDTickets'

        return $ReturnObject
    }
}