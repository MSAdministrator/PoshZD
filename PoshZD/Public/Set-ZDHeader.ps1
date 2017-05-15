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
function Set-ZDHeader
{
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")]
    [OutputType('System.Management.Automation.PSVariable')]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        $Email,

        # Param2 help description
        [Parameter(Mandatory=$true)]
        $Token
    )

    Begin
    {
        #verify Email Address
        #Verify Token Pattern
    }
    Process
    {
        Write-Verbose -Message 'Creating global HEADER variable for your ZenDesk Domain from Set-ZDHeader'

        Set-Variable -Name Headers -Value @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Email)/token:$($Token)"));} -Scope Global

    }
    End
    {
    }
}