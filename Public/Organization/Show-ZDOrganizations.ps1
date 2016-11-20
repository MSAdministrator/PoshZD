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
        Write-Verbose -Message 'Creating parameters from Show-ZDOrganizations'

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
        Write-Verbose -Message 'Invoking Rest Method from Show-ZDOrganizations'

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
        Write-Verbose -Message 'Returning results from Show-ZDOrganizations'

        Add-ObjectDetail -InputObject $Result -TypeName PoshZD.Organization
    }
}