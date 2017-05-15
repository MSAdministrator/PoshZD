    
    $testURI        = 'https://contoso.zendesk.com'
    $testDomain     = 'contoso'
    $testTicket     = '1234'
    $testEmail      = 'first.last@contoso.com'
    $testToken      = '1q12w2eqwe3qweq323123213aeqwe'
    
    $testHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($testEmail)/token:$($testToken)"));}

    $testCommand    = 'CommandTest'
    $testJobName = 'TestJob'

    
$here = "$(Split-Path -Parent $MyInvocation.MyCommand.Path)" -replace 'Tests','PoshZD'
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

    InModuleScope 'PoshZD' {
        Describe 'Get-ZDTicket' {
            $InvokeZDCommandSplat = @{
                    TicketId   = $testTicket
                }

                Context 'default type, default api, credentials passed' {
                  #  Mock -CommandName Invoke-RestMethod -ModuleName PoshZD `
                  #      -MockWith { Throw 'Invoke-RestMethod called with incorrect parameters' }

                    Mock -CommandName Invoke-RestMethod -ModuleName PoshZD `
                        -ParameterFilter {
                            $Uri -eq "https://$testDomain.zendesk.com/api/v2/tickets/$testTicket.json" -and `
                            $Headers.Count -eq 1 -and `
                            $Headers -eq $testHeader
                        } `
                        -MockWith { 'Invoke-RestMethod Result' }
                    $Splat = $InvokeZDCommandSplat.Clone()
                    $Result = Get-ZDTicket @Splat
                    It "should return 'Invoke-RestMethod Result'" {
                        $Result | Should Be 'Invoke-RestMethod Result'
                    }
                    It "should return call expected mocks" {
                        Assert-MockCalled -CommandName Invoke-RestMethod -ModuleName PoshZD `
                            -ParameterFilter {
                                $Uri -eq "https://$testDomain.zendesk.com/api/v2/tickets/$testTicket.json" -and `
                                $Headers.Count -eq 1 -and `
                                $Headers['Authorization'] -eq $testHeader
                            } `
                            -Exactly 1
                    }
            } # Context
        }
    }