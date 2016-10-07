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
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $Attachment
    )

    Begin
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/uploads.json?filename=$Attachment&token=$Token"
            Method = 'Post'
            Headers = $Headers
            ContentType = 'application/binary'
            InFile = $Attachment
        }
    }
    Process
    {
        try
        {
            $Result = Invoke-RestMethod @params
        }
        catch
        {
            Write-Warning -Message "Error uploading attachment to ZenDesk: $($Error | select -Property *)"
        }
    }
    End
    {
        return $Result
    }
}