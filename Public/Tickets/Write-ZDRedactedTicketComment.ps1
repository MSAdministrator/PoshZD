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
        $Body = @{}

        $Body.text = $Text
        
        $ReturnObject = @{}

        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/tickets/$TicketId/comments/$CommentId/redact.json"
            Method = 'Put'
            Body = $($Body | ConvertTo-Json)
            Headers = $Headers
            ContentType = 'application/json'
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