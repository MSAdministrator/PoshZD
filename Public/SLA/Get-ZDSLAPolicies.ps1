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
function Get-ZDSLAPolicies
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
        [Long]$PolicyId,

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
                Uri = "https://$Domain.zendesk.com/api/v2/slas/policies"
                Method = 'Get'
                Headers = $Headers            
                ContentType = 'application/json'
            }
        }

        if ($PolicyId)
        {
            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/slas/policies/$PolicyId"
                Method = 'Get'
                Headers = $Headers
                ContentType = 'application/json'
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
            return $ReturnObject.sla_policies
        }
        else
        {
            return $ReturnObject.sla_policy
        }
    }
}