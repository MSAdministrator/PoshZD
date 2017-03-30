<#
.Synopsis
   This shows the status of a background job in ZenDesk
.DESCRIPTION
   By inputting a specific job number, this will show the specific status of a job in ZenDesk.
.EXAMPLE
   Get-ZDRunningJob -jobid $job
#>
function Get-ZDRunningJob
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $JobID
    )

    Begin
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/job_statuses/$JobID.json"
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