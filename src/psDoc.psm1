function New-PSDoc {
<#
    .SYNOPSIS
    Creates a new documentation of the specified powershell module

    .DESCRIPTION
    Creates a new documentation of the specified powershell module in the specified output format.
    An existing documentation file will be overwritten without warnings.
    If the specified output format is unsupported html output format is used.

    .PARAMETER moduleName
    Name of the Powershell module

    .PARAMETER outputFormat
    Output format of documentation (html, confluence, markdown, asciidoc)

    .PARAMETER outputDir
    Output directory for generated documentation

    .PARAMETER fileName
    Filename without extension for generated documentation
    If moduleName comes via pipeline these parameter is ignored and default fileName will used.

    .EXAMPLE
    PS> New-PSDoc -moduleName PowerShellGet -verbose

    .EXAMPLE
    PS> @("PowerShellGet", "psDoc") | New-PSDoc -outputDir "help" -outputFormat "asciidoc"
#>
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$true, ValueFromPipeline=$true, Position=0)] [string] $moduleName,
        [parameter(Mandatory=$false, Position=1)] [string] $outputFormat = "html",
        [parameter(Mandatory=$false, Position=2)] [string] $outputDir = "$(Get-Location)",
        [parameter(Mandatory=$false, Position=3)] [string] $fileName = "psdoc-$($moduleName)")

    begin {
    }

    process {
        if( $_ ) {
            Write-Verbose "Receiving moduleName '$_' from pipeline"

            # set default file name if parameter comes from pipeline
            $fileName = "psdoc-$($_)"
        }

        . $PSScriptRoot/psDoc.ps1 -moduleName $moduleName -outputFormat $outputFormat -outputDir $outputDir -fileName $fileName
    }

    end {
    }
}