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
function Update-ZDUser
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        # Param1 help description
        [PSTypeName('PoshZD.Users')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ParameterSetName='UserObj')]
        $User,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ParameterSetName='GetUser')]
        $UserID
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Update-ZDUser'

        if ($PSBoundParameters.ContainsKey('User'))
        {
            $params = @{
                    Uri = "https://$env:ZDDomain.zendesk.com/api/v2/users/create_or_update.json"
                    Method = 'Post'
                    Headers = $Headers
                    Body = ($User | ConvertTo-Json)
                    ContentType = 'application/json'
                }
        }
        elseif ($PSBoundParameters.ContainsKey('UserID'))
        {
            $params = @{
                    Uri = "https://$env:ZDDomain.zendesk.com/api/v2/users/$UserID.json"
                    Method = 'Put'
                    Headers = $Headers
                    Body = ($User | ConvertTo-Json)
                    ContentType = 'application/json'
                }
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Update-ZDUser'

        try
        {
            $Result = Invoke-RestMethod @params
        }
        catch
        {
            throw 'Error trying to create user'
        }
    }
    End
    {
        Write-Verbose -Message 'Returning results from Update-ZDUser'

        return $Result
    }
}