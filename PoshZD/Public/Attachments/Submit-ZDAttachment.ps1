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

        Write-Verbose -Message 'Beginning to submit ZenDesk Attachment'
    }
    Process
    {
        Write-Debug 'Attachment count before submitting attachment to ZenDesk'
        Write-Debug "Attachment.Count = $($Attachment.count)"

        Write-Verbose "Attachment count before submitting attachment to ZenDesk $($Attachment.count)"

        for ($i = 0; $i -lt $Attachment.Count; $i++)
        {
            $tempobj = @{}
            $params = @{}

            if (0 -eq $i)
            {
                $params = @{
                    Uri = "https://$env:ZDDomain.zendesk.com/api/v2/uploads.json?filename=$(Split-Path -Leaf $Attachment[$i])"
                    Method = 'Post'
                    Headers = $ZDHeaders
                    ContentType = 'application/binary'
                    InFile = $Attachment[$i]
                }

                try
                {
                    $AttObject = @()

                    $AttObject = Invoke-RestMethod @params

                    $tempProp = @{
                        Token = $AttObject.upload.token
                        Expires = $AttObject.upload.expires_at
                        URL = $AttObject.upload.attachments.url
                        ID = $AttObject.upload.attachments.id
                        FileName = $AttObject.upload.attachments.file_name
                        ContentType = $AttObject.upload.attachments.content_type
                        Size = $AttObject.upload.attachments.size
                    }

                    $TempObject = New-Object -TypeName PSCustomObject -Property $tempProp
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

                Write-Debug "firsttoken[$i] = $firsttoken"

                $tempobj = @{}

                $params = @{
                    Uri = "https://$env:ZDDomain.zendesk.com/api/v2/uploads.json?filename=$(Split-Path -Leaf $Attachment[$i])&token=$firsttoken"
                    Method = 'Post'
                    Headers = $ZDHeaders
                    ContentType = 'application/binary'
                    InFile = $Attachment[$i]
                }

                try
                {
                    $AttObject = @()
                    $AttObject = Invoke-RestMethod @params

                    $tempProp = @{
                        Token = $AttObject.upload.token
                        Expires = $AttObject.upload.expires_at
                        URL = $AttObject.upload.attachments.url
                        ID = $AttObject.upload.attachments.id
                        FileName = $AttObject.upload.attachments.file_name
                        ContentType = $AttObject.upload.attachments.content_type
                        Size = $AttObject.upload.attachments.size
                    }

                    $TempObject = New-Object -TypeName PSCustomObject -Property $tempProp
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
        return $Result 
    }
}
