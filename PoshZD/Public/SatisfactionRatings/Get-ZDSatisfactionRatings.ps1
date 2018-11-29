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
function Get-ZDSatisfactionRatings
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(ParameterSetName = 'All',
                   Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        [switch]$All,

        [Parameter(ParameterSetName = 'Filter1',
                   Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        [switch]$Received,

        [Parameter(ParameterSetName = 'Filter2',
                   Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        [switch]$ReceivedWithComment,

        [Parameter(ParameterSetName = 'Filter3',
                   Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        [switch]$ReceivedWithoutComment,

        [Parameter(ParameterSetName = 'Filter4',
                   Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        [switch]$GoodWithComment,

        [Parameter(ParameterSetName = 'Filte5',
                   Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        [switch]$GoodWithoutComment,

        [Parameter(ParameterSetName = 'Filte6',
                   Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        [switch]$BadWithComment,

        [Parameter(ParameterSetName = 'Filte7',
                   Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        [switch]$BadWithoutComment
    )

    Begin
    {

        Write-Verbose -Message 'Gathering parameters from Get-ZDSatisfactionRatings'

        $URI = ''

        if ($All)
        {
            $URI = "https://$env:ZDDomain.zendesk.com/api/v2/satisfaction_ratings.json"
        }
        
        if (-not($All))
        {
            switch ($PSBoundParameters.Keys)
            {
                'Received'               { $URI = "https://$env:ZDDomain.zendesk.com/api/v2/satisfaction_ratings.json?score=received"                }
                'ReceivedWithComment'    { $URI = "https://$env:ZDDomain.zendesk.com/api/v2/satisfaction_ratings.json?score=received_with_comment"   }
                'ReceivedWithoutComment' { $URI = "https://$env:ZDDomain.zendesk.com/api/v2/satisfaction_ratings.json?score=receied_without_comment" }
                'GoodWithComment'        { $URI = "https://$env:ZDDomain.zendesk.com/api/v2/satisfaction_ratings.json?score=good_with_comment"       }
                'GoodWithoutComment'     { $URI = "https://$env:ZDDomain.zendesk.com/api/v2/satisfaction_ratings.json?score=good_without_comment"    }
                'BadWithComment'         { $URI = "https://$env:ZDDomain.zendesk.com/api/v2/satisfaction_ratings.json?score=bad_with_comment"        }
                'BadWithoutComment'      { $URI = "https://$env:ZDDomain.zendesk.com/api/v2/satisfaction_ratings.json?score=bad_without_comment"     }
            }
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDSatisfactionRatings'

        $Result = @()

        $params = @{
            Uri = $URI
            Method = 'Get'
            Headers = $ZDHeaders
        }

        $Result = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Get-ZDSatisfactionRatings'

        return $Result.satisfaction_ratings
    }
}