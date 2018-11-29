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
function Get-ZDAttachment
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [int]$AttachmentID
    )

    Begin
    {
        Write-Verbose -Message 'Creating paramters for Get-ZDAttachment'

        $params = @{
                Uri = "https://$env:ZDDomain.zendesk.com/api/v2/attachments/$AttachmentID.json"
                Method = 'Get'
                Headers = $ZDHeaders
            }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method for Get-ZDAttachment'

        $Results = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning Results from Get-ZDAttachment'

        return $Results
    }
}