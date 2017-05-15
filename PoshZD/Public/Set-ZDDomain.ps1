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

        if (Test-Path Variable:$Domain)
        {  
            Set-Variable -Name Domain -Value $Domain -Scope Global
        }
        <#else
        {
            $Response = [System.Windows.Forms.MessageBox]::Show("A Domain variable already exists.  Would you like to overwrite this variable?" , "Status" , 4)
            
            if ($Response -eq 'Yes')
            {
                Set-Variable -Name Domain -Value $Domain -Scope Global
            }
        }#>
    }
    End
    {
        Write-Verbose -Message 'Returning global DOMAIN variable for your ZenDesk Domain from Set-ZDDomain'

        return $Domain
    }
}