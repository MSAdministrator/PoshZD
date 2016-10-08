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
        $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/attachments/$AttachmentID.json"
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
        return $Results
    }
}