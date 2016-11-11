<#
.Synopsis
   Accepts a comma-separated list of job status ids.
.DESCRIPTION
   Based on a comma separated list of job ids, Get-ZDJobsStatus will get statuses for each job and return them to the user
.EXAMPLE
   Get-ZDJobsStatus -JobIDs 8b726e606741012ffc2d782bcb7848fe,e7665094164c498781ebe4c8db6d2af5,3f3a876fb3354766b74a21066007ffee
.EXAMPLE
   Get-ZDJobsStatus -JobIDs $csv
#>
function Get-ZDJobsStatus
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $JobIDs
    )

    Begin
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/job_statuses/show_many.json?ids=$JobIDs"
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
    }
}