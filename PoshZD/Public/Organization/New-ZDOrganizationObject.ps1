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
function New-ZDOrganizationObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        # Param1 help description
        
        [int]
        $Id,

        # Param2 help description
        [int]
        $ExternalId,

        [string]$Url,

        [Parameter(Mandatory=$true)]
        [string]$Name,

        [string]$DomainName,

        [string]$Details,

        [string]$Notes,

        [string]$GroupId
    )

    Begin
    {
        Write-Verbose -Message 'Setting up ZD Organization Object'

        $JSONObject = @{}
        $Body = @{}

        $JSONObject.organization = ''
    }
    Process
    {
        Write-Verbose -Message 'Entering switch to create ZD Organization Object'

        switch ($PSBoundParameters.keys)
        {
            'ID'         { $Body.ID          = $ID         }
            'ExternalID' { $Body.external_id = $ExternalID }
            'Url'        { $Body.url         = $Url        }
            'Name'       { $Body.name        = $Name       }
            'DomainName' { $Body.domain_name = $DomainName }
            'Details'    { $Body.details     = $Details    }
            'Notes'      { $Body.notes       = $Notes      }
            'GroupId'    { $Body.group_id    = $GroupId    }
        }

        $JSONObject.ticket = $Body
    }
    End
    {
        Write-Verbose -Message 'Returning ZD Organization Object'

        Add-ObjectDetail -InputObject $JSONObject -TypeName PoshZD.Organization
    }
}