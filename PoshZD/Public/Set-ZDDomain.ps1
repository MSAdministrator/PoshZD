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
function Set-ZDDomain
{
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")]
    [OutputType('System.Management.Automation.PSVariable')]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        $Domain
    )

    Begin
    {
        #verify Email Address
        #Verify Token Pattern
    }
    Process
    {
        Write-Verbose -Message 'Creating global DOMAIN variable for your ZenDesk Domain from Set-ZDDomain'

        $env:ZDDomain = $Domain
    }
    End
    {
    }
}