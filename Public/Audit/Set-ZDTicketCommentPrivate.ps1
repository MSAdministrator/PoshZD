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
function Set-ZDTicketCommentPrivate
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param2 help description
        [Parameter(ParameterSetName = 'Single',
                   Mandatory=$true,
                   ValueFromPipeline=$true)]
        [long]$TicketId,

        [Parameter(ParameterSetName = 'Single',
                   Mandatory=$true,
                   ValueFromPipeline=$true)]
        [long]$AuditId
    )

    Begin
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/tickets/$TicketId/audits/$AuditId/make_private.json"
            Method = 'Put'
            Headers = $Headers
            ContentType = 'application/json'
        }
    }
    Process
    {
        $Result = Invoke-RestMethod @params

    }
    End
    {
        return $Result
    }
}