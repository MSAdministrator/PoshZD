$here = "$(Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent)\PoshZD"

Get-Module PoshZD | Remove-Module -Force

Import-Module "$(Split-Path $here -Parent)\PoshZD.psm1" -Force



Describe 'Set-ZDDomain Tests' {
    Context 'Set-ZDDomain Tests' {

        AfterEach{
            Remove-Variable -Name Domain
        }
        It "should set a global variable" {
            #Set-ZDDomain -Domain 'test'

            Set-ZDDomain -Domain 'test' | Should be 'test'
        }

        It "should set variable if it does not exist" {
            Mock -CommandName Test-Path -MockWith { $true }

            Set-ZDDomain -Domain 'test domain' | should be 'test domain'
        }

        It "should not change variable if already set" {
            Set-ZDDomain -Domain 'test'

            Mock -CommandName Test-Path -MockWith { $false }
            Set-ZDDomain -Domain 'test domain' | should be 'test'

        }

    }
}
