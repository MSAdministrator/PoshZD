<#
.Synopsis
   This shows the current statuses for background jobs running
.DESCRIPTION
   This shows the current statuses for background jobs running, will retrieve all background jobs and present their statuses.
.EXAMPLE
   Get-ZDJobStatuses - No input parameters are necessary
#>
function Get-ZDJobStatuses
{
    Begin
    {
        $params = @{
            Uri = "https://$Domain.zendesk.com/api/v2/job_statuses.json"
            Method = 'Get'
            Headers = $Headers
        }
    }
    Process
    {
        $Result = Invoke-RestMethod @params
    }
    End
    {
        Return $Result
    }
}