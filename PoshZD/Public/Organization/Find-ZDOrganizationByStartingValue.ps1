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
        Write-Verbose -Message 'Creating parameters from Find-ZDOrganizationByStartingValue'

        $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/organizations/autocomplete.json?name=$StartingValue"
                Method = 'Get'
                Headers = $ZDHeaders
        }
        
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Find-ZDOrganizationByStartingValue'

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
        Write-Verbose -Message 'Returning results from Find-ZDOrganizationByStartingValue'

        return $Result
    }
}