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
function Find-ZDUser
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ParameterSetName='Name')]
        $Name,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ParameterSetName='Email')]
        $Email
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Find-ZDUser'

        if ($PSBoundParameters.ContainsKey('Name'))
        {
            $params = @{
                    Uri = "https://$env:ZDDomain.zendesk.com/api/v2/users/search.json?query=$Name"
                    Method = 'Get'
                    Headers = $ZDHeaders
                    Body = ($User | ConvertTo-Json)
            }
        }
        elseif ($PSBoundParameters.ContainsKey('Email'))
        {
            $params = @{
                    Uri = "https://$env:ZDDomain.zendesk.com/api/v2/users/search.json?query=$Email"
                    Method = 'Get'
                    Headers = $ZDHeaders
                    Body = ($User | ConvertTo-Json)
            }
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Find-ZDUser'

        try
        {
            $Result = Invoke-RestMethod @params
        }
        catch
        {
            throw 'Error trying to search users'
        }
    }
    End
    {
        Write-Verbose -Message 'Returning results from Find-ZDUser'

        return $Result
    }
}