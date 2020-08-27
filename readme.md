psDoc is a Powershell Help Document generator.

----
### Using psDoc ###

To generate documentation off of your module, simply import your module

```
Import-Module MySpecialModule
```

And generate the documentation

```
.\psDoc.ps1 -moduleName MySpecialModule
```

Or copy the repository as Powershell module into `C:\Users\<your_user>\Documents\WindowsPowerShell\Modules\psDoc` or `C:\Program Files\WindowsPowerShell\Modules\psDoc` and generate the docmentation

```
New-PSDoc -moduleName MySpecialModule -verbose
```

```
@("MySpecialModule", "MyOtherModule") | New-PSDoc -outputDir "help" -outputFormat "asciidoc"
```

To publish the module as a NuGet package open a Powershell window as adminstrator and run the following command from repository directory:

```
Publish-Module -Path . -NuGetApiKey "f896299d-98af-47ad-9be9-0cd1a8a8d213" -Repository <YourRepositoryName> -Verbose
```

The nupkg file will be stored in the repository folder of `<YourRepositoryName>`.

### License ###

[Microsoft Public License (Ms-PL)](https://opensource.org/licenses/MS-PL)
