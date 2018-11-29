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
function Merge-ZDTicket
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

        Write-Verbose -Message 'Creating parameters from Merge-ZDTicket'

        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/tickets/$SourceTicket/merge.json"
            Method = 'Post'
            Body = $($TicketObject | ConvertTo-Json)
            Headers = $ZDHeaders
            ContentType = 'application/json'
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Merge-ZDTicket'

        $Result = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Merge-ZDTicket'

        return $Result
    }
}