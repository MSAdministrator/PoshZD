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
        
    }
    Process
    {
        try
        {
            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/organizations/$($OrganizationObject.id).json"
                Method = 'Put'
                Body = $($TicketObject | ConvertTo-Json)
                Headers = $Headers
                ContentType = 'application/json'
            }

            $Result = Invoke-RestMethod @params
        }
        catch
        {
            throw 'Error trying to update organization'
        }
    }
    End
    {
        return $Result
    }
}