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
function Find-ZDOrganizationByStartingValue
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ParameterSetName='Name')]
        $StartingValue
    )

    Begin
    {
        $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/organizations/autocomplete.json?name=$StartingValue"
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
            throw 'Error trying to search organizations'
        }
    }
    End
    {
        return $Result
    }
}