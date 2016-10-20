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
function Get-ZDTicket
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
        $TicketId,

        [switch]$GetTags
    )

    Begin
    {
        $ReturnObject = @{}

        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/tickets/$TicketId.json"
            Method = 'Get'
            Headers = $Headers
        }
    }
    Process
    {
        $ReturnObject.ticket = (Invoke-RestMethod @params).ticket
        
        if ($GetTags)
        {
            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/tickets/$TicketId/tags.json"
                Method = 'Get'
                Headers = $Headers
            }

            $ReturnObject.tags = (Invoke-RestMethod @params).tags
        }
    }
    End
    {
        return $ReturnObject
    }
}