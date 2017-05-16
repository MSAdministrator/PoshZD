$here = "$(Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent)\PoshZD"


$module = 'PoshZD'

Describe "$module PowerShell Module Tests" {
    
    Context 'Module Setup' {

        It "has the root module $module.psm1" {
            "$here\$module.psm1" | Should exist
        }

        It "has the manifest file $module.psd1" {
            "$here\$module.psd1" | should exist

            "$here\$module.psd1" | Should contain "$module.psm1"
        }

        It "$module has functions" {
            "$here\Public\*.ps1" | Should exist
            "$here\Public\*\*.ps1" | Should exist
        }

        It "$module is valid PowerShell Code" {
            $psFile = Get-Content -Path "$here\$module.psm1" -ErrorAction Stop
            $errors = $null

            $null = [System.Management.Automation.PSParser]::Tokenize($psFile,[ref]$errors)
            $errors.count | Should be 0
        }
    }


    $globalFunctions = ('Set-ZDDomain',
                        'Set-ZDHeader'
                       )

    $functions = ('Get-ZDAttachment',                    
                  'Submit-ZDAttachment',                  
                  'Get-ZDAuditEventsOnTicket',            
                  'Get-ZDTicketAuditEventID',             
                  'Set-ZDTicketCommentPrivate',           
                  'Get-ZDTicketMetrics',                  
                  'New-ZDOrganizationObject',          
                  'Find-ZDOrganizationByStartingValue',   
                  'New-ZDOrganization',                   
                  'Remove-ZDOrganization',                
                  'Show-ZDOrganization',                  
                  'Show-ZDOrganizationRelatedInformation',
                  'Show-ZDOrganizations',                 
                  'Update-ZDOrganization',            
                  'Get-ZDSatisfactionRatings',            
                  'Search-ZDTicketsByTag',                
                  'New-ZDSLAAutomationsFilter',        
                  'New-ZDSLAObject',                   
                  'Get-ZDSLAPolicies',                    
                  'New-ZDTicketObject',                
                  'Get-ZDAllTickets',                     
                  'Get-ZDSuspendedTickets',               
                  'Get-ZDTicket',                         
                  'Get-ZDTicketComments',                 
                  'Get-ZDTicketFields',                   
                  'Import-ZDTicket',                      
                  'Import-ZDTickets',                     
                  'Merge-ZDTicket',                       
                  'New-ZDTicket',                         
                  'Remove-ZDSuspendedTicket',             
                  'Restore-ZDSuspendedTicket',            
                  'Search-ZDTicketFields',                
                  'Set-ZDTicketCaseStatus',               
                  'Update-ZDTicket',                      
                  'Write-ZDRedactedTicketComment',        
                  'New-ZDUserObject',                  
                  'Find-ZDUser',                          
                  'Get-ZDUser',                           
                  'Get-ZDUsers',                          
                  'New-ZDUser',                           
                  'Remove-ZDUser',                     
                  'Update-ZDUser'
                )
    #$functions = Get-ChildItem -Path $here\Public\*\*.ps1
    #Split-Path (Split-Path $functions -Parent) -Leaf | select -Unique
    $folders = ( 'Attachments',
                 'Audit',
                 'Metrics',
                 'Organization',
                 'SatisfactionRatings',
                 'Search',
                 'SLA',
                 'Tickets',
                 'Users'
               )


    foreach ($folder in $folders)
    {
        Context 'Folders Tests' {
            
            It "$folder should exist" {
                "$here\Public\$Folder" | Should Exist
            }
        }
    }

    foreach ($function in $functions)
    {
        Context 'Function Tests' {
            
            #It "$globalFunctions.ps1 should exist" {
            #    "$here\Public\$globalFunctions.ps1" | Should Exist
            #}
            It "$function.ps1 should exist" {
                "$here\Public\*\$function.ps1" | Should Exist
            }

            It "$function.ps1 should have help block" {
                "$here\Public\*\$function.ps1" | Should contain '<#'
                "$here\Public\*\$function.ps1" | Should contain '#>'
            }
            
            It "$function.ps1 should have a SYNOPSIS section in the help block" {
                "$here\Public\*\$function.ps1" | Should contain '.SYNOPSIS'
            }

            It "$function.ps1 should have a DESCRIPTION section in the help block" {
                "$here\Public\*\$function.ps1" | Should contain '.DESCRIPTION'
            }

            It "$function.ps1 should have a EXAMPLE section in the help block" {
                "$here\Public\*\$function.ps1" | Should contain '.EXAMPLE'
            }

            It "$function.ps1 should be an advanced function" {
                "$here\Public\*\$function.ps1" | Should contain 'function'
                "$here\Public\*\$function.ps1" | Should contain 'CmdLetBinding'
                "$here\Public\*\$function.ps1" | Should contain 'param'
            }

            It "$function.ps1 should contain Write-Verbose blocks" {
                "$here\Public\*\$function.ps1" | Should contain 'Write-Verbose'
            }

            It "$function.ps1 is valid PowerShell code" {
                $psFile = Get-Content -Path "$here\Public\*\$function.ps1" -ErrorAction Stop
                $errors = $null

                $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
                $errors.count | Should be 0
            }
        }#Context Function Tests


        $testLocation = "$here\Public\*\$function.Tests.ps1" -replace $module,'Tests'

        if (Test-Path $testLocation)
        {
            Context "$function has tests" {
            
                It "$function.ps1 has tests" {
                    $testLocation | Should exist
                }

                It "running $function.ps1 tests" {
                    Invoke-Pester $testLocation
                }
            }
        }
    }

    
    $FunctionTests = Get-ChildItem "$(Split-Path -Path $here -Parent)\Tests\Public\Tickets\*.ps1" 
    $FunctionTests
}