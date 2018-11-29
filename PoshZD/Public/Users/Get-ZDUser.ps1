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
        Write-Verbose -Message 'Creating parameters from Get-ZDUser'

        $filter = ''

        if ($UserRelatedInformation)
        {
            $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/users/$UserID/related.json"
                Method = 'Get'
                Headers = $ZDHeaders
            }

            $filter = 'user_related'
        }
        else
        {
            $params = @{
                    Uri = "https://$env:ZDDomain.zendesk.com/api/v2/users/$UserID.json"
                    Method = 'Get'
                    Headers = $ZDHeaders
                }
                    
            $filter = 'user'
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDUser'

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
        Write-Verbose -Message 'Returning results from Get-ZDUser'

        Add-ObjectDetail -InputObject $Result.$filter -TypeName PoshZD.Users
    }
}