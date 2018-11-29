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
        Write-Verbose -Message 'Creating parameters from Get-ZDSLAPolicies'

        $ReturnObject = @{}

        if ($All)
        {
            $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/slas/policies"
                Method = 'Get'
                Headers = $ZDHeaders            
                ContentType = 'application/json'
            }
        }

        if ($PolicyId)
        {
            $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/slas/policies/$PolicyId"
                Method = 'Get'
                Headers = $ZDHeaders
                ContentType = 'application/json'
            }
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDSLAPolicies'

        $ReturnObject = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Get-ZDSLAPolicies'

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