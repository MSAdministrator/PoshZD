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
        $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/organizations/$OrganizationID/related.json"
                Method = 'Get'
                Headers = $Headers
        }
        
    }
    Process
    {
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
        return $Result
    }
}