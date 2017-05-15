# PSScriptAnalyzer - ignore creation of a SecureString using plain text for the contents of this script file
# https://replicajunction.github.io/2016/09/19/suppressing-psscriptanalyzer-in-pester/
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
param()

$here = "$(Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent)\PoshZD\Public\Tickets"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

InModuleScope PSJira {

    $showMockData = $false

    $Domain = 'contoso'
    $Email = 'first.last@contoso.com'
    $Token = '1v9Jtflmp4ybID38f8TPaeke9u0412kqvXFBHy5F'
    $TicketId = '1234'

    $ZDURI = "https://$Domain.zendesk.com/api/v2/tickets/$TicketId.json"

    $Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Email)/token:$($Token)"));}


    $jiraServer = 'http://jiraserver.example.com'
    $authUri = "$jiraServer/rest/auth/1/session"
    $jSessionId = '76449957D8C863BE8D4F6F5507E980E8'

    $testUsername = 'powershell-test'
    $testPassword = ConvertTo-SecureString -String 'test123' -AsPlainText -Force
    $testCredential = New-Object -TypeName PSCredential -ArgumentList $testUsername,$testPassword

     $testJson = @"
{
    "url":  "https://contoso.zendesk.com/api/v2/tickets/1234.json",
    "id":  1234,
    "external_id":  null,
    "via":  {
                "channel":  "email",
                "source":  {
                               "from":  "@{address=first.last@contoso.com; name=First Last}",
                               "to":  "@{name=Contoso Inc.; address=support@contoso.com}",
                               "rel":  null
                           }
            },
    "created_at":  "2017-04-12T12:15:04Z",
    "updated_at":  "2017-04-20T20:02:52Z",
    "type":  null,
    "subject":  "TICKET SUBJECT",
    "raw_subject":  "TICKET SUBJECT",
    "description":  "Some sample description",
    "priority":  "normal",
    "status":  "pending",
    "recipient":  "support@contoso.com",
    "requester_id":  6270544467,
    "submitter_id":  6176659988,
    "assignee_id":  6176659988,
    "organization_id":  4434188408,
    "group_id":  28515838,
    "collaborator_ids":  [
                             6145641437,
                             6176659988
                         ],
    "forum_topic_id":  null,
    "problem_id":  null,
    "has_incidents":  false,
    "is_public":  true,
    "due_at":  null,
    "tags":  [
                 "agent_submitted",
                 "general_inquiry",
                 "notified_ticket.group.name",
                 "see_org_notes"
             ],
    "custom_fields":  [
                          {
                              "id":  34064287,
                              "value":  ""
                          }
                      ],
    "satisfaction_rating":  {
                                "score":  "unoffered"
                            },
    "sharing_agreement_ids":  [

                              ],
    "fields":  [
                   {
                       "id":  31931847,
                       "value":  ""
                   }
               ],
    "ticket_form_id":  249998,
    "brand_id":  757778,
    "satisfaction_probability":  null,
    "allow_channelback":  false
}
"@

    Describe "Get-ZDTicket" {

        Mock Invoke-RestMethod -Verifiable -ParameterFilter {$Uri -eq $ZDURI -and $Method -eq 'Get' -and $Header -eq $Headers} {
            if ($showMockData)
            {
                Write-Host " Mocked Invoke-WebRequest with POST method" -ForegroundColor Cyan
                Write-Host " [Method] $Method" -ForegroundColor Cyan
                Write-Host " [URI] $URI" -ForegroundColor Cyan
                Write-Host " [Header] $Headers" -ForegroundColor Cyan
            }
            $global:newSessionVar = @{}
            Write-Output $testJson
        }

        Mock Invoke-WebRequest -Verifiable -ParameterFilter {$Uri -eq $authUri -and $Method -eq 'DELETE'} {
            if ($showMockData)
            {
                Write-Host " Mocked Invoke-WebRequest with DELETE method" -ForegroundColor Cyan
                Write-Host " [Method] $Method" -ForegroundColor Cyan
                Write-Host " [URI] $URI" -ForegroundColor Cyan
            }
        }

        Mock Invoke-WebRequest {
            Write-Host " Mocked Invoke-WebRequest with no parameter filter." -ForegroundColor DarkRed
            Write-Host " [Method] $Method" -ForegroundColor DarkRed
            Write-Host " [URI] $URI" -ForegroundColor DarkRed
            throw "Unidentified call to Invoke-JiraMethod"
        }

        It "Closes a saved PSJira.Session object from module PrivateData" {

            # This probably isn't the best test for this, but it's about all I can come up with at the moment.
            # New-JiraSession has some slightly more elaborate testing, which includes a test for Get-JiraSession,
            # so if both of those pass, they should work as expected here.

            New-JiraSession -Credential $testCredential | Remove-JiraSession

            Get-JiraSession | Should BeNullOrEmpty
        }

        It "Correctly handles pipeline input from New-JiraSession" {
            { New-JiraSession -Credential $testCredential | Remove-JiraSession } | Should Not Throw
            Get-JiraSession | Should BeNullOrEmpty
            Assert-MockCalled -CommandName Invoke-WebRequest -ParameterFilter {$Uri -eq $authUri -and $Method -eq 'DELETE'} -Exactly -Times 1 -Scope It
        }

        It "Correctly handles pipeline input from Get-JiraSession" {
            New-JiraSession -Credential $testCredential
            { Get-JiraSession | Remove-JiraSession } | Should Not Throw
            Get-JiraSession | Should BeNullOrEmpty
            Assert-MockCalled -CommandName Invoke-WebRequest -ParameterFilter {$Uri -eq $authUri -and $Method -eq 'DELETE'} -Exactly -Times 1 -Scope It
        }
    }
}