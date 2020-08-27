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

### License ###

[Microsoft Public License (Ms-PL)](https://opensource.org/licenses/MS-PL)
