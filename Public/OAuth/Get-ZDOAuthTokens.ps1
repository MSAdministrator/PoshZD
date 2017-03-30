<#
.Synopsis
   Lists all active OAuth Tokens
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-ZDOAuthTokens
{
    Begin
    {
        $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/oauth/tokens.json"
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