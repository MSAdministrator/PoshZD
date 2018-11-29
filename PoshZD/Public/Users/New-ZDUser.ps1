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
function New-ZDUser
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [PSTypeName('PoshZD.Users')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true)]
        $User
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from New-ZDUser'

        $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/users.json"
                Method = 'Post'
                Headers = $Headers
                Body = ($User | ConvertTo-Json)
                ContentType = 'application/json'
            }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from New-ZDUser'

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
        Write-Verbose -Message 'Returning results from New-ZDUser'

        return $Result
    }
}