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
function Show-ZDOrganizations
{
    [CmdletBinding()]
    Param
    (
        # Param2 help description
        [Parameter(Mandatory=$false)]
        [long]$UserID
    )

    Begin
    {
        if ($UserID)
        {
            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/users/$UserID/organizations.json"
                Method = 'Get'
                Headers = $Headers
            }
        }
        else
        {
            $params = @{
                    Uri = "https://$Domain.zendesk.com/api/v2/organizations.json"
                    Method = 'Get'
                    Headers = $Headers
                }
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
            throw 'Error listing organization'
        }
    }
    End
    {
        Add-ObjectDetail -InputObject $Result -TypeName PoshZD.Organization
    }
}