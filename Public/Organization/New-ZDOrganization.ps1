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
        
    }
    Process
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/organizations.json"
            Method = 'Post'
            Body = $($TicketObject | ConvertTo-Json)
            Headers = $Headers
            ContentType = 'application/json'
        }

        $Result = Invoke-RestMethod @params
    }
    End
    {
        return $Result
    }
}