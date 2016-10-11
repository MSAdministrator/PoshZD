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
       
        Set-Variable -Name Domain -Value $Domain -Scope Global

    }
    End
    {
    }
}