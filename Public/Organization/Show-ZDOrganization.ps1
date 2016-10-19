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
function Show-ZDOrganization
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ParameterSetName='ID')]
        [long]$OrganizationID
    )

    Begin
    {
        $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/organizations/$OrganizationID.json"
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
            throw 'Error trying to search organizations by ID'
        }
    }
    End
    {
        return $Result
    }
}
