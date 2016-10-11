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
        $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/users/$UserID.json"
                Method = 'DELETE'
                Headers = $Headers
                Body = ($User | ConvertTo-Json)
                ContentType = 'application/json'
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
            throw 'Error trying to delete user'
        }
    }
    End
    {
        return $Result
    }
}