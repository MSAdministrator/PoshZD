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
function Merge-ZenDeskTicket
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true)]
        [int]$SourceTicket,

        # Param2 help description
        [int[]]
        $TargetTicket,

        $TargetComment,
        $SourceComment
    )

    Begin
    {
        $props = @{
            ids = $TargetTicket
            target_comment = $TargetComment
            source_comment = $SourceComment
        }

        $TicketObject = New-Object -TypeName PSCustomObject -Property $props
    }
    Process
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/tickets/$SourceTicket/merge.json"
            Method = 'Post'
            Body = $($TicketObject | ConvertTo-Json)
            Headers = $Headers
            ContentType = 'application/json'
        }

        $Result = Invoke-RestMethod @params
    }
    End
    {
        return $Result
    }
}