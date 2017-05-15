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
function Set-PoshZDConfiguration
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Domain to be used by PoshZD
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $Domain,

        # Email to be used by PoshZD
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        $Email,

        # Token to be used by PoshZD
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        $Token
    )

    if (!(Test-Path "$env:APPDATA\PoshZD\"))
    {
        try
        {
            New-Item -Path "$env:APPDATA\PoshZD" -ItemType Directory
        }
        catch
        {
            Write-Error -Message 'Unable to create configuration folder'
        }
    }

# Create a PSD1 file
@"
@{

    # CHANGE THESE SETTINGS BEFORE IMPORTING MODULE

    Domain = '$($Domain)'
    Email = '$($Email)'
    Token = '$($Token)'
}

"@ | Out-File -FilePath "$ENV:APPDATA\PoshZD\PoshZD-Configuration.psd1"

    # Read the file
    $File = Import-LocalizedData -BaseDirectory "$ENV:APPDATA\PoshZd\" -FileName "PoshZD-Configuration.psd1"

    Set-Variable -Name Domain -Value $File.Domain

    Set-Variable -Name Headers -Value @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($File.Email)/token:$($File.Token)"));}

    try
    {
        Remove-Module -Name PoshZD -Force

        Import-Module -Name "$(Split-Path $PSScriptRoot -Parent)\PoshZD.psm1"
    }
    catch
    {
        Write-Error -Message 'Error attempting to re-import PoshZD.  Please import the module manualy by calling Import-Module'   
    }
}
