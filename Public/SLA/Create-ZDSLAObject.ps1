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
function Create-ZDSLAObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true)]
        [string]$Title,

        # Param2 help description
        
        [Parameter(Mandatory=$true)]
        [string]$Description,

        [Parameter(Mandatory=$false)]
        [int]$Position,
        [Parameter(Mandatory=$false,ParameterSetName='Attachment')]
        [ValidateSet('true','false')]
        $IsPublic = 'true',
        [Parameter(Mandatory=$false,ParameterSetName='Attachment')]
        $Attachment,

        $RequesterID,
        $AssigneeID,
        $AssigneeEmail,
        $GroupID,
        [array]$CollaboratorIDs,
        [array]$AdditionalCollaborators,
        [ValidateSet('problem','incident','question','task')]
        $Type,
        [ValidateSet('urgent','high','normal','low')]
        $Priority,
        [ValidateSet('new','open','pending','hold','solved','closed')]
        $Status,
        [array]$Tags,
        
        $CustomFieldID,
        $CustomFieldValue,
        [switch]$SafeUpdate
    )

    Begin
    {
    }
    Process
    {
        Write-Verbose -Message 'Creating ZenDesk SLA Object from Create-ZDSLAObject'

        $JSONObject = @{}
        $Body = @{}

        $JSONObject.ticket = ''

        if ($Attachment)
        {
            $Body.comment = @{
                body = $Comment
                uploads = $Attachment
                public = $IsPublic
            }
        }
        elseif ($Comment)
        {
            $Body.comment = @{
                body = $Comment
                public = $IsPublic
            }
        }

        if ($CustomFieldID)
        {
            $body.custom_fields = @(
                @{
                    id = $CustomFieldID
                    value = $CustomFieldValue
                },
                @{ 
                    id = 31980718
                    value = 'on_hold'
                }
            )
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
        Write-Verbose -Message 'Returning ZenDesk SLA Object from Create-ZDSLAObject'

        Add-ObjectDetail -InputObject $JSONObject -TypeName PoshZD.Ticket
    }
}
