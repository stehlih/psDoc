function New-PSDoc
{
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
        [parameter(Mandatory=$false, Position=3)] [string] $fileName = "psdoc-$($moduleName)"
    )

    begin
    {
    }

    process 
    {
        if( $_ ) 
        {
            Write-Verbose "Receiving moduleName '$_' from pipeline"

            # set default file name if parameter comes from pipeline
            $fileName = "psdoc-$($_)"
        }

        . $PSScriptRoot/psDoc.ps1 -moduleName $moduleName -outputFormat $outputFormat -outputDir $outputDir -fileName $fileName
    }

    end 
    {
    }
}


function New-PSRepositoryDoc
{
    <#
        .SYNOPSIS
        Creates a new documentation of modules in a PowerShell Repository
    
        .DESCRIPTION
        Creates a new documentation of of modules in a PowerShell Repository in the specified output format.
        Existing documentation files will be overwritten without warnings.
        If the specified output format is unsupported html output format is used.

        .PARAMETER repositoryName
        name of the PowerShell repository

        .PARAMETER moduleFilter
        filter expression for module names
    
        .PARAMETER outputFormat
        Output format of documentation (html, confluence, markdown, asciidoc)
    
        .PARAMETER outputDir
        Output directory for generated documentation
    
        .PARAMETER filePrefix
        Prefix of all generated files 
    
        .EXAMPLE
        PS> New-PSRepositoryDoc -repository MyRepository -moduleFilter "Auto.*" -verbose

    #>
    param(
        [parameter(Mandatory=$true,  Position=0)] [string] $repository,
        [parameter(Mandatory=$true,  Position=1)] [string] $moduleFilter,
        [parameter(Mandatory=$false, Position=2)] [string] $outputFormat = "html",
        [parameter(Mandatory=$false, Position=3)] [string] $outputDir    = "$(Get-Location)",
        [parameter(Mandatory=$false, Position=4)] [string] $filePrefix   = "psdoc-"
    )

    [array] $modules = Find-Module -repository $repository | Where-Object {  $_.Name -match $moduleFilter } | Select-Object -Property Name -Unique

    Write-Output "Found $($modules.Count) modules in repository '$repository'."
    
    [array] $tempInstalledModules = [System.Collections.ArrayList]@()
    
    foreach( $module in $modules)
    {
        [string] $moduleName = $module.Name
        [string] $fileName   = "$filePrefix$moduleName"
    
        Import-Module -Name $moduleName -ErrorAction SilentlyContinue
    
        if( -not (Get-Module -Name $moduleName) )
        { 
            $tempInstalledModules += $moduleName
    
            Write-Output "Temporary installation of module '$moduleName' in current user scope..."
            
            Install-Module -Name $moduleName -Scope CurrentUser -Repository $repository
        }
    
        Write-Output "Generating documentation of module '$moduleName'..."
    
        . $PSScriptRoot/psDoc.ps1 -moduleName $moduleName -outputFormat $outputFormat -outputDir $outputDir -fileName $fileName
    }
    
    foreach( $moduleName in $tempInstalledModules)
    {
        Write-Output "Remove temporary installation of module '$moduleName'..."
    
        Uninstall-Module -Name $moduleName -ErrorAction Continue -Force
    }
}
