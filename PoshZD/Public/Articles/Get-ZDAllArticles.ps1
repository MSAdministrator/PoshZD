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
function Get-ZDAllArticles
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

    )

    Begin
    {
        #Create an arraylist to hold the articles
        $articles = [Collections.Arraylist]::new()
        
        $params = @{
            Method = 'Get'
            Headers = $ZDHeaders
            ContentType = 'application/json'
        }

        Write-Verbose "Getting the total number of pages returned from the articles endpoint"
        #Get the number of pages returned
        $PageCount = Invoke-RestMethod @params -Uri "https://adminarsenal.zendesk.com/api/v2/help_center/articles?per_page=100" | Select-Object -ExpandProperty page_count
        #Add all of the pages to a collection
        $Pages = 1..$PageCount | Foreach-Object {
            "https://adminarsenal.zendesk.com/api/v2/help_center/articles?per_page=100&page=$($_)"
        }

    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDAllArticles'
        $Pages | foreach-Object{
            $articles+= (Invoke-RestMethod @params -uri $_ ).articles
        }
        return $articles

    }
    End
    {
        
    }
}
