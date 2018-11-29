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
function Get-ZDTicketAuditEventID
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
        Write-Verbose -Message 'Creating parameters from Get-ZDTicketAuditEventID'

        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/tickets/$TicketId/audits/$AuditId.json"
            Method = 'Get'
            Headers = $ZDHeaders
        }
    }
    Process
    {
        Write-Verbose -Message 'Invokeing Rest Method from Get-ZDTicketAuditEventID'

        $Result = Invoke-RestMethod @params

    }
    End
    {
        Write-Verbose -Message 'Returning results from Get-ZDTicketAuditEventID'

        return $Result
    }
}