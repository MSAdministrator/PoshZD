$here = "$(Split-Path -Parent $MyInvocation.MyCommand.Path)" -replace 'Tests','PoshZD'
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

$testTicket     = '1234'

 $testJson = @"
{
"tags":  [
                 "current_customer",
                 "closed"
             ],
"ticket":  {
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
}
"@ | ConvertFrom-Json


    InModuleScope 'PoshZD' {
        Describe 'Get-ZDTicket with only ticket id' {

            mock -CommandName Invoke-RestMethod -MockWith { return [pscustomobject]$testJson }

            it 'returns TicketObject without tags sub property' {
                $ZDTicketObject = Get-ZDTicket -TicketID $testTicket
                $ZDTicketObject.id | should be '1234'   
            }
        }

        Describe 'Get-ZDTicket with ticketId and GetTags switch' {
            mock -CommandName Invoke-RestMethod -MockWith { return [pscustomobject]$testJson }

            it 'returns TicketObject with ticket parent property' {
                $ZDTicketObject = Get-ZDTicket -TicketID $testTicket -GetTags
                $ZDTicketObject.ticket.id | should be '1234'   
                $ZDTicketObject.tags | should be 'current_customer','closed'
            }
        }
    }