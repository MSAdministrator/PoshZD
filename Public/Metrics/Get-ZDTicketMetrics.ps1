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
        $ReturnObject = @{}

        if ($All)
        {
            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/ticket_metrics.json"
                Method = 'Get'
                Headers = $Headers
            }
        }

        if ($MetricID)
        {
            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/ticket_metrics/$MetricID.json"
                Method = 'Get'
                Headers = $Headers
            }
        }

        if ($TicketId)
        {
            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/tickets/$TicketId/metrics.json"
                Method = 'Get'
                Headers = $Headers
            }
        }
    }
    Process
    {
        $ReturnObject = Invoke-RestMethod @params
    }
    End
    {
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