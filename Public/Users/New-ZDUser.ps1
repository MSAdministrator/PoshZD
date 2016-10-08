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
        $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/users.json"
                Method = 'Post'
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
            throw 'Error trying to create user'
        }
    }
    End
    {
        return $Result
    }
}