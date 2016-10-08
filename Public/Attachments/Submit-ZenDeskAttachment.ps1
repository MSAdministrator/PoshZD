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
function Submit-ZenDeskAttachment
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        [string[]]$Attachment
    )

    Begin
    {
        $Result = @{}
    }
    Process
    {
        foreach ($item in $Attachment)
        {
            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/uploads.json?filename=$(Split-Path -Leaf $item)"
                Method = 'Post'
                Headers = $Headers
                ContentType = 'application/binary'
                InFile = $item
            }
           
            try
            {
                $AttObject = Invoke-RestMethod @params

                $Result.Token = $AttObject.upload.token
                $Result.Expires = $AttObject.upload.expires_at
                $Result.URL = $AttObject.upload.attachments.url
                $Result.ID = $AttObject.upload.attachments.id
                $Result.FileName = $AttObject.upload.attachments.file_name
                $Result.ContentType = $AttObject.upload.attachments.content_type
                $Result.Size = $AttObject.upload.attachments.size
            }
            catch
            {
                Write-Warning -Message "Error uploading attachment to ZenDesk: $($Error | select -Property *)"
            }
        }
    }
    End
    {
        Add-ObjectDetail -InputObject $Result -TypeName PoshZD.Attachment -DefaultProperties Token,FileName,Expires
    }
}