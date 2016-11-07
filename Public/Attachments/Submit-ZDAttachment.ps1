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
        $Result = @()
        $firsttoken = ""
    }
    Process
    {
        for ($i = 0; $i -lt $Attachment.Count; $i++)
        {
            $tempobj = @{}
            $params = @{}

            if (0 -eq $i)
            {
                $params = @{
                    Uri = "https://$Domain.zendesk.com/api/v2/uploads.json?filename=$(Split-Path -Leaf $Attachment[$i])"
                    Method = 'Post'
                    Headers = $Headers
                    ContentType = 'application/binary'
                    InFile = $Attachment[$i]
                }

                try
                {
                    $AttObject = @()

                    $AttObject = Invoke-RestMethod @params

                #    $tempProp = @{
                        $TempObject.Token = $AttObject.upload.token
                        $TempObject.Expires = $AttObject.upload.expires_at
                        $TempObject.URL = $AttObject.upload.attachments.url
                        $TempObject.ID = $AttObject.upload.attachments.id
                        $TempObject.FileName = $AttObject.upload.attachments.file_name
                        $TempObject.ContentType = $AttObject.upload.attachments.content_type
                        $TempObject.Size = $AttObject.upload.attachments.size
                 #   }

                  #  $TempObject = New-Object -TypeName PSCustomObject -Property $tempProp
                }
                catch
                {
                    Write-Warning -Message "Error uploading attachment to ZenDesk: $($Error | select -Property *)"
                }

                Write-Debug "TempObject[$i] = $($TempObject | Out-String)"

                $firsttoken = $TempObject.Token

                Write-Debug "FirstToken[$i] = $firsttoken"

                $Result += $TempObject
            }

            if ($i -gt 0)
            {

                Write-Host "firsttoken[$i] = $firsttoken"

                $tempobj = @{}

                $params = @{
                    Uri = "https://$Domain.zendesk.com/api/v2/uploads.json?filename=$(Split-Path -Leaf $Attachment[$i])&token=$firsttoken"
                    Method = 'Post'
                    Headers = $Headers
                    ContentType = 'application/binary'
                    InFile = $Attachment[$i]
                }



                try
                {
                    $AttObject = @()
                    $AttObject = Invoke-RestMethod @params

                    #$tempProp = @{
                        $TempObject.Token = $AttObject.upload.token
                        $TempObject.Expires = $AttObject.upload.expires_at
                        $TempObject.URL = $AttObject.upload.attachments.url
                        $TempObject.ID = $AttObject.upload.attachments.id
                        $TempObject.FileName = $AttObject.upload.attachments.file_name
                        $TempObject.ContentType = $AttObject.upload.attachments.content_type
                        $TempObject.Size = $AttObject.upload.attachments.size
                    #}

                    #$TempObject = New-Object -TypeName PSCustomObject -Property $tempProp
                }
                catch
                {
                    Write-Warning -Message "Error uploading attachment to ZenDesk: $($Error | select -Property *)"
                }

                Write-Debug "TempObject[$i] = $($TempObject | Out-String)"

                $Result += $TempObject
                
            }
        }
    }
    End
    {
        
        Add-ObjectDetail -InputObject $Result -TypeName PoshZD.Attachment -DefaultProperties Token,FileName,Expires
    }
}
