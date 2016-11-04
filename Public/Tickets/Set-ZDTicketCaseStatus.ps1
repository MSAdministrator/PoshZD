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
function Set-ZDTicketCaseStatus
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [int]$Ticket,

        # Param2 help description
        [ValidateSet('in_progress','on_hold','closed','resolved')]
        [Parameter(Mandatory=$true)]
        $Status
    )

    Begin
    {
        $BodyPost = @{
            ticket = @{
                custom_fields = @{
                    id = 31980718
                    value = $Status
                }
            }
        }

        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/tickets/$Ticket.json"
            Method = 'Put'
            Body = $($BodyPost | ConvertTo-Json)
            Headers = $Headers
            ContentType = 'application/json'
        }
    }
    Process
    {
        $restresponse = Invoke-RestMethod @params
    }
    End
    {
        return $restresponse
    }
}
