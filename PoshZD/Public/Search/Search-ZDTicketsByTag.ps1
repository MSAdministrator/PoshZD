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
function Search-ZDTicketsByTag {
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [string]$Tag
    )

    Begin {
        Write-Verbose -Message 'Creating parameters from Search-ZDTicketsByTag'
        $Result = @()
        $Query = [URI]::EscapeDataString("tags:$Tag")
        $URI = "https://$env:ZDDomain.zendesk.com/api/v2/search.json?query=type%3Aticket+$Query"
        $params = @{
            Method  = 'Get'
            Headers = $ZDHeaders
            ContentType = "application/json"
        } 

        $Pages = Get-Pages -URI $URI  
    }
    Process {
        Write-Verbose -Message 'Invoking Rest Method from Search-ZDTicketsByTag'
        Foreach ($Page in $Pages){
            $Result += (Invoke-RestMethod @params -URI $page).results
        }
        
    }
    End {
        Write-Verbose -Message 'Returning results from Search-ZDTicketsByTag'
        $result | ForEach-Object {
            Add-ObjectDetail -InputObject $_ -TypeName PoshZD.Fields -DefaultProperties id, subject, status, requester_id, created_at
        }
       
    }
}