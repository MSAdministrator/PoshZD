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
function Update-ZDOrganization
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        # Param1 help description
        [PSTypeName('PoshZD.Organization')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        $OrganizationObject
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Update-ZDOrganization'

        $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/organizations/$($OrganizationObject.id).json"
                Method = 'Put'
                Body = $($TicketObject | ConvertTo-Json)
                Headers = $Headers
                ContentType = 'application/json'
            }
    }
    Process
    {
        try
        {
            Write-Verbose -Message 'Invoking Rest Method from Update-ZDOrganization'

            $Result = Invoke-RestMethod @params
        }
        catch
        {
            throw 'Error trying to update organization'
        }
    }
    End
    {
        Write-Verbose -Message 'Returning results from Update-ZDOrganization'

        return $Result
    }
}