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
function Get-ZDTicketComments
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
        $TicketId
    )

    Begin
    {
        $ReturnObject = @{}

        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/tickets/$TicketId/comments.json"
            Method = 'Get'
            Headers = $Headers
        }
    }
    Process
    {
        $ReturnObject = Invoke-RestMethod @params
    }
    End
    {
        return $ReturnObject
    }
}