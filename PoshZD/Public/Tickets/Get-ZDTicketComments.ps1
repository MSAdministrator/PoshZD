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
        Write-Verbose -Message 'Creating parameters from Get-ZDTicketComments'

        $ReturnObject = @{}

        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/tickets/$TicketId/comments.json"
            Method = 'Get'
            Headers = $ZDHeaders
            ContentType = "application/json"
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDTicketComments'

        $ReturnObject = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Get-ZDTicketComments'

        return $ReturnObject
    }
}