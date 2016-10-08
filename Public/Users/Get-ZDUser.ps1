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
function Get-ZDUser
{
    [CmdletBinding()]
    Param
    (
        # Param2 help description
        [Parameter(Mandatory=$true)]
        [long]$UserID,

        [switch]$UserRelatedInformation
    )

    Begin
    {
        $filter = ''

        if ($UserRelatedInformation)
        {
            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/users/$UserID/related.json"
                Method = 'Get'
                Headers = $Headers
            }

            $filter = 'user_related'
        }
        else
        {
            $params = @{
                    Uri = "https://$Domain.zendesk.com/api/v2/users/$UserID.json"
                    Method = 'Get'
                    Headers = $Headers
                }
                    
            $filter = 'user'
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
            throw 'Error searching for user'
        }
    }
    End
    {
        Add-ObjectDetail -InputObject $Result.$filter -TypeName PoshZD.Users
    }
}