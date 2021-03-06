# Module manifest for module 'psDoc'
#
# Check manifest with: 
#
#   Test-ModuleManifest -path psDoc.psd1 -verbose
#
# To publish the module as a NuGet package open a Powershell window as adminstrator 
# and run the following command from repository directory::
#
#   Publish-Module -Path . -NuGetApiKey "f896299d-98af-47ad-9be9-0cd1a8a8d213" -Repository <YourRepositoryName> -Verbose
#
# The nupkg file will be stored in the repository folder of <YourRepositoryName>.

@{

# Script module or binary module file associated with this manifest.
RootModule = 'src/psDoc.psm1'

# Version number of this module.
ModuleVersion = '1.1.1'

# ID used to uniquely identify this module
GUID = 'f896299d-98af-47ad-9be9-0cd1a8a8d213'

# Author of this module
Author = 'Chase Florell'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = 'Licensed under Microsoft Public License - https://opensource.org/licenses/MS-PL'

# Description of the functionality provided by this module
Description = 'psDoc is a Powershell Help Document generator (https://github.com/ChaseFlorell/psDoc)'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = @( "New-PSDoc",
                       "New-PSRepositoryDoc" )

# Cmdlets to export from this module
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = @()

# Aliases to export from this module
AliasesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
FileList = @("src/psDoc.psm1",
             "src/psDoc.ps1",
             "src/psDoc.tests.ps1",
             "src/out-asciidoc-template.ps1", 
             "src/out-confluence-markup-template.ps1", 
             "src/out-html-template.ps1", 
             "src/out-markdown-template.ps1")

# Private data to pass to the module specified in RootModule/ModuleToProcess
# PrivateData = ''

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
