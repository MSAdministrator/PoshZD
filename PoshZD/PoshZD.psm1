if (!(Test-Path "$env:APPDATA\PoshZD\PoshZD-Configuration.psd1"))
{
    try
    {
        New-Item -Path "$env:APPDATA\PoshZD" -ItemType Directory
    }
    catch
    {
        Write-Error -Message 'Unable to create configuration folder'
    }

# Create a PSD1 file
@"
@{

    # CHANGE THESE SETTINGS BEFORE IMPORTING MODULE

    Domain = 'Contoso'
    Email = 'first.last@contoso.com'
    Token = 'ZD_TOKEN_STRING'
}

"@ | Out-File -FilePath "$ENV:APPDATA\PoshZD\PoshZD-Configuration.psd1"

}
# Read the file
$File = Import-LocalizedData -BaseDirectory "$ENV:APPDATA\PoshZd\" -FileName "PoshZD-Configuration.psd1"

Set-Variable -Name Domain -Value $File.Domain -Scope Global

Set-Variable -Name Headers -Value @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($File.Email)/token:$($File.Token)"));} -Scope Global


#requires -Version 2
#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -Recurse -ErrorAction SilentlyContinue
              Get-ChildItem -Path $PSScriptRoot\Public\*\*.ps1 -Recurse -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -Recurse -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Public + $Private))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
Export-ModuleMember -Function $Private.Basename
