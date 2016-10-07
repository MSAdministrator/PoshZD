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
function Get-ZenDeskTicket
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
        $Ticket
    )

    Begin
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/tickets/$Ticket.json"
            Method = 'Get'
            Headers = $Headers
        }
    }
    Process
    {
        $result = Invoke-RestMethod @params
    }
    End
    {
        return $result
    }
}