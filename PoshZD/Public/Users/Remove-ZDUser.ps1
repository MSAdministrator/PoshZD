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
function Remove-ZDUser
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [PSTypeName('PoshZD.Users')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ParameterSetName='GetUser')]
        $UserID
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Remove-ZDUser'

        $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/users/$UserID.json"
                Method = 'DELETE'
                Headers = $ZDHeaders
                Body = ($User | ConvertTo-Json)
                ContentType = 'application/json'
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Remove-ZDUser'

        try
        {
            $Result = Invoke-RestMethod @params
        }
        catch
        {
            throw 'Error trying to delete user'
        }
    }
    End
    {
        Write-Verbose -Message 'Returning results from Remove-ZDUser'

        return $Result
    }
}