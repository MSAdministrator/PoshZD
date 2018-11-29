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
function Show-ZDOrganizationRelatedInformation
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ParameterSetName='ID')]
        [int]$OrganizationID
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Show-ZDOrganizationRelatedInformation'

        $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/organizations/$OrganizationID/related.json"
                Method = 'Get'
                Headers = $ZDHeaders
        }
        
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Show-ZDOrganizationRelatedInformation'

        try
        {
            $Result = Invoke-RestMethod @params
        }
        catch
        {
            throw 'Error trying to search organizations for related information'
        }
    }
    End
    {
        Write-Verbose -Message 'Returning results from Show-ZDOrganizationRelatedInformation'

        return $Result
    }
}