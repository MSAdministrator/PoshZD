function Get-Pages {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $URI
    )
    
    begin {
        $pages = @($URI)
    }
    
    process {
        while ($null -ne $Pages) {
          
            try {
                $params = @{
                    Method      = 'Get'
                    Headers     = $zdheaders
                    ContentType = 'Application/JSON'
                }
                $URI = (Invoke-RestMethod @params -Uri $URI).next_page  
                If ($null -ne $URI) {
                    $Pages += $URI
                }
                
            }
            catch {
                Write-Verbose "Reached the end of available pages"
                break
            }
        }
    }
    
    end {
        return $Pages
    }
}