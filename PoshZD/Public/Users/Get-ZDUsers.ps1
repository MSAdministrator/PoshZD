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
function Get-ZDUsers
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param2 help description
        [Parameter(ParameterSetName='Filter')]
        [ValidateSet('end-user','agent','admin')]
        [string[]]$Role,

        [Parameter(ParameterSetName='Filter')]
        $GroupID,

        [Parameter(ParameterSetName='Filter')]
        $OrganizationID
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Get-ZDUsers'

        $RoleString = @()

        if ($Role)
        {
            if ($role.Count -gt 1)
            {
                for ($i = 0; $i -le $role.count; $i++)
                {
                    $RoleString += "role[]=$r&"
                }
            }
            else
            {
                $RoleString = "role=$role"
            }
        }
        else
        {
            $RoleString = ''
        }


        if ($GroupID)
            {
                $params = @{
                    Uri = ("https://$env:ZDDomain.zendesk.com/api/v2/groups/$GroupID/users.json?$RoleString").TrimEnd('&')
                    Method = 'Get'
                    Headers = $ZDHeaders
                }
            }
            elseif ($OrganizationID)
            {
                $params = @{
                    Uri = ("https://$env:ZDDomain.zendesk.com/api/v2/organizations/$OrganizationID/users.json?$RoleString").TrimEnd('&')
                    Method = 'Get'
                    Headers = $ZDHeaders
                }
            }
            else
            {
                $params = @{
                    Uri = ("https://$env:ZDDomain.zendesk.com/api/v2/users.json?$RoleString").TrimEnd('&')
                    Method = 'Get'
                    Headers = $ZDHeaders
                }
            }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDUsers'

        try
        {
            $Result = Invoke-RestMethod @params
        }
        catch
        {
            throw 'Error searching for users'
        }
    }
    End
    {
        Write-Verbose -Message 'Returning results from Get-ZDUsers'

        return $Result
    }
}