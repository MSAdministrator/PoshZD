<#
.Synopsis
   Sends an attachment to ZenDesk which generates a token
.DESCRIPTION
   Sends an attachment to ZenDesk which generates a token.  This function retains the token so you can easily add an attachment to a ZD Ticket Object
.EXAMPLE
   $attachmentobject = Submit-ZDAttachment -Attachment "C:\Path\To\Attachment.doc"
#>
function Submit-ZDAttachment
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
            $tempobj = @{}
            $params = @{
                Uri = "https://$Domain.zendesk.com/api/v2/uploads.json?filename=$(Split-Path -Leaf $item)&token=$firsttoken"
                Method = 'Post'
                Headers = $Headers
                ContentType = 'application/binary'
                InFile = $item
            }
           
            try
            {
                $AttObject = Invoke-RestMethod @params

                $tempobj.Token = $AttObject.upload.token
                $tempobj.Expires = $AttObject.upload.expires_at
                $tempobj.URL = $AttObject.upload.attachments.url
                $tempobj.ID = $AttObject.upload.attachments.id
                $tempobj.FileName = $AttObject.upload.attachments.file_name
                $tempobj.ContentType = $AttObject.upload.attachments.content_type
                $tempobj.Size = $AttObject.upload.attachments.size
            }
            catch
            {
                Write-Warning -Message "Error uploading attachment to ZenDesk: $($Error | select -Property *)"
            }

            $Result += $tempobj
        }
        $firsttoken = $tempobj.Token[0]
    }
    End
    {
        Add-ObjectDetail -InputObject $Result -TypeName PoshZD.Attachment -DefaultProperties Token,FileName,Expires
    }
}
