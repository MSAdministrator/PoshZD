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
function Write-ZDRedactedTicketComment
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [long]$TicketId,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [long]$CommentId,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string]$Text
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Write-ZDRedactedTicketComment'

        $Body = @{}

        $Body.text = $Text
        
        $ReturnObject = @{}

        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/tickets/$TicketId/comments/$CommentId/redact.json"
            Method = 'Put'
            Body = $($Body | ConvertTo-Json)
            Headers = $ZDHeaders
            ContentType = 'application/json'
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Write-ZDRedactedTicketComment'

        $ReturnObject = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Write-ZDRedactedTicketComment'

        return $ReturnObject
    }
}