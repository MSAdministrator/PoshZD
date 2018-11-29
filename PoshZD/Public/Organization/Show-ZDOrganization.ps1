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
        Write-Verbose -Message 'Creating parameters from Show-ZDOrganization'

        $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/organizations/$OrganizationID.json"
                Method = 'Get'
                Headers = $ZDHeaders
        }
        
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Show-ZDOrganization'

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
        Write-Verbose -Message 'Returning results from Show-ZDOrganization'

        return $Result
    }
}
