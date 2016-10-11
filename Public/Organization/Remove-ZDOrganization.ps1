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
        $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/organizations/$OrganizationID.json"
                Method = 'DELETE'
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
            throw 'Error trying to delete organization'
        }
    }
    End
    {
        return $Result
    }
}