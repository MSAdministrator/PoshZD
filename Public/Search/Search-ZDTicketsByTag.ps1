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
function Search-ZDTicketsByTag
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [string]$Tag
    )

    Begin
    {
        
        $Query = [URI]::EscapeDataString("tags:$Tag")
        
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/search.json?query=$Query"
            Method = 'Get'
            Headers = $Headers
        }
       
    }
    Process
    {
        $Result = Invoke-RestMethod @params
    }
    End
    {
        Add-ObjectDetail -InputObject $Result.results -TypeName PoshZD.Fields -DefaultProperties id,subject,status,requester_id,created_at
    }
}