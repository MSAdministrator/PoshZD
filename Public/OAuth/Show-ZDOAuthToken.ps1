<#
.Synopsis
   Returns truncated token based on token ID
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Show-ZDOAuthToken
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $TokenID
    )

    Begin
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/oauth/tokens/$TokenID.json"
            Method = 'Get'
            Headers = $Headers
        }
    }
    Process
    {
        $Results = Invoke-RestMethod @params
    }
    End
    {
        Return $Results
    }
}