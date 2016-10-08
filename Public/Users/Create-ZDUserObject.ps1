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
function Create-ZDUserObject
{
    [CmdletBinding()]
    Param
    (

        [string]$Email,

        [string]$Comment,

        [Parameter(Mandatory=$true)]
        [string]$Name,

        [string]$Alias,

        [switch]$ChatOnly,

        [string]$Details,

        [string]$Notes,
        
        [int]$OrganizationID,

        [string]$PhoneNumber,

        [PSTypeName('PoshZD.Attachment')]
        $Photo,

        [ValidateSet('end-user','agent','admin')]
        [string[]]$Role,

        [ValidateSet('organization','groups','assigned','requested','null')]
        [string]$TicketRestriction,

        [switch]$TwoFactorAuthentication

    )

    Begin
    {
    }
    Process
    {
        $JSONObject = @{}
        $Body = @{}

        $JSONObject.user = ''

        if ($PSBoundParameters.ContainsKey('Photo'))
        {
            $Body.comment = @{
                body = $Comment
                uploads = $Photo.token
            }
        }

        switch ($PSBoundParameters.Keys)
        {
            'Email'                  { $Body.email                   = $Email                   }
            'Name'                   { $Body.name                    = $Name                    }
            'Alias'                  { $Body.alias                   = $Alias                   }
            'ChatOnly'               { $Body.chat_only               = $ChatOnly                }
            'Details'                { $Body.assignee_id             = $AssigneeID              }
            'Notes'                  { $Body.notes                   = $Notes                   }
            'OrganizationID'         { $Body.organization_id         = $OrganizationID          }
            'PhoneNumber'            { $Body.phone                   = $PhoneNumber             }
            'Role'                   { $Body.role                    = $Role                    }
            'TicketRestriction'      { $Body.ticket_restriction      = $TicketRestriction       }
            'TwoFactorAuthentication'{ $Body.two_factor_auth_enabled = 'true'                   }
        }

        $JSONObject.user = $Body
    }
    End
    {
        Add-ObjectDetail -InputObject $JSONObject -TypeName PoshZD.Users
    }
}