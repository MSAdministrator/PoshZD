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
        foreach ($item in $TicketObject)
        {
            $Result = @()

            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/imports/tickets/create_many.json"
                Method = 'Post'
                Body = $($item | ConvertTo-Json)
                Headers = $Headers
                ContentType = 'application/json'
            }

            $Result = Invoke-RestMethod @params
            $ReturnObject += $Result
        }
    }
    End
    {
        return $ReturnObject
    }
}