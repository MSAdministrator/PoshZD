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
function Remove-ZDOrganization
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [PSTypeName('PoshZD.Users')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ParameterSetName='Organization')]
        $OrganizationID
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Remove-ZDOrganization'

        $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/organizations/$OrganizationID.json"
                Method = 'DELETE'
                Headers = $Headers
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Remove-ZDOrganization'

        try
        {
            $Result = Invoke-RestMethod @params
        }
        catch
        {
            throw 'Error trying to delete organization'
        }
    }
    End
    {
        Write-Verbose -Message 'Returning results from Remove-ZDOrganization'

        return $Result
    }
}