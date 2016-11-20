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
function Create-ZDSLAAutomationsFilter
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true)]
        [ValidateSet('All','Any')]
        $Scope,

        # Param2 help description
        
        [Parameter(Mandatory=$true)]
        [ValidateSet('NEW','OPEN','PENDING','SOLVED', 'CLOSED', 'assigned_at','updated_at', 'requester_updated_at', 'assignee_updated_at', 'due_date','until_due_date' )]
        [string[]]$Field,

        [Parameter(Mandatory=$false)]
        [ValidateSet('is','is_business_hours','less_than','less_than_business_hours', 'greater_than','greater_than_business_hours')]
        [string[]]$Operator,

        [Parameter(Mandatory=$false)]
        [int[]]$Value
    )

    Begin
    {
    }
    Process
    {
        Write-Verbose -Message 'Creating ZenDesk Automations Filter from Create-ZDSLAAutomationsFilter'

        $JSONObject = @{}
        $Body = @{}

        $JSONObject.filter = ''

        if ($Scope -eq 'All')
        {
            $body.all = @{}

            foreach ($f in $Field)
            {
                foreach ($o in $Operator)
                {
                    foreach ($v in $Value)
                    {
                        ($body.all).Add('field',$f)
                        ($body.all).Add('operator',$o)
                        ($body.all).Add('value',$v)
                    }
                }
            }
        }
                   

        switch ($PSBoundParameters.Keys)
        {
            'Subject'                  { $Body.subject                  = $Subject                 }
            'Description'              { $Body.description              = $Description             }
            'RequesterID'              { $Body.requester_id             = $RequesterID             }
            'SubmitterID'              { $Body.submitter_id             = $SubmitterID             }
            'AssigneeID'               { $Body.assignee_id              = $AssigneeID              }
            'AssigneeEmail'            { $Body.assignee_email           = $AssigneeEmail           }
            'GroupID'                  { $Body.group_id                 = $GroupID                 }
            'CollaboratorIDs'          { $Body.collaborator_ids         = $CollaboratorIDs         }
            'AdditionalCollaborators'  { $Body.additional_collaborators = $AdditionalCollaborators }
            'Type'                     { $Body.type                     = $Type                    }
            'Priority'                 { $Body.priority                 = $Priority                }
            'Status'                   { $Body.status                   = $Status                  }
            'Tags'                     { $Body.tags                     = $Tags                    }
            'SafeUpdate'               { $Body.safe_update              = $SafeUpdate              }
        }

        $JSONObject.ticket = $Body
    }
    End
    {
        Write-Verbose -Message 'Returning ZenDesk Automations Filter from Create-ZDSLAAutomationsFilter'

        Add-ObjectDetail -InputObject $JSONObject -TypeName PoshZD.Ticket
    }
}
