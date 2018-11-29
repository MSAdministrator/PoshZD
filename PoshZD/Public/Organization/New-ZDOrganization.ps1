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
function New-ZDOrganization
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
        Write-Verbose -Message 'Creating parameters from New-ZDOrganization'

        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/organizations.json"
            Method = 'Post'
            Body = $($TicketObject | ConvertTo-Json)
            Headers = $ZDHeaders
            ContentType = 'application/json'
        }
        
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from New-ZDOrganization'

        $Result = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from New-ZDOrganization'

        return $Result
    }
}