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
function Get-ZDTicketMetrics
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='All')]
        [switch]$All,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='MetricId')]
        [Long]$MetricID,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='TicketId')]
        [Long]$TicketId
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Get-ZDTicketMetrics'

        $ReturnObject = @{}

        if ($All)
        {
            $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/ticket_metrics.json"
                Method = 'Get'
                Headers = $ZDHeaders
            }
        }

        if ($MetricID)
        {
            $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/ticket_metrics/$MetricID.json"
                Method = 'Get'
                Headers = $ZDHeaders
            }
        }

        if ($TicketId)
        {
            $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/tickets/$TicketId/metrics.json"
                Method = 'Get'
                Headers = $ZDHeaders
            }
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDTicketMetrics'

        $ReturnObject = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Get-ZDTicketMetrics'

        if ($All)
        {
            return $ReturnObject.ticket_metrics
        }
        else
        {
            return $ReturnObject.ticket_metric
        }
    }
}