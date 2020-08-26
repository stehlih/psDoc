function TrimAllLines([string] $str) {
  $lines = $str -split "`n"

  for ($i = 0; $i -lt $lines.Count; $i++) {
    $lines[$i] = $lines[$i].Trim()
  }

  # Trim EOL.
  ($lines | Out-String).Trim()
}

function FixAsciiDocString([string] $in = '', [bool] $includeBreaks = $false) {
  if ($in -eq $null) { return }

  $replacements = @{
    '\' = '\\'
    '`' = '\`'
    '*' = '\*'
    '_' = '\_'
    '{' = '\{'
    '}' = '\}'
    '[' = '\['
    ']' = '\]'
    '(' = '\('
    ')' = '\)'
    '#' = '\#'
    '+' = '\+'
    '!' = '\!'
    '<' = '\<'
    '>' = '\>'
  }

  $rtn = $in.Trim()
  foreach ($key in $replacements.Keys) {
    $rtn = $rtn.Replace($key, $replacements[$key])
  }

  $rtn = TrimAllLines $rtn
  $crlf = [Environment]::NewLine
  if ($includeBreaks) {
    $rtn = $rtn.Replace($crlf, "  $crlf")
  }
  else {
    $rtn = $rtn.Replace($crlf, " ").Trim()
  }
  $rtn
}

function FixMarkdownCodeString([string] $in) {
  if ($in -eq $null) { return }
	
  TrimAllLines $in
}

@"
= $moduleName Module

"@
$progress = 0
$commandsHelp | ForEach-Object {
  Update-Progress $_.Name 'Documentation'
  $progress++
  @"
== $(FixAsciiDocString($_.Name))

"@
  $synopsis = $_.synopsis.Trim()
  $syntax = $_.syntax | out-string
  if (-not ($synopsis -ilike "$($_.Name.Trim())*")) {
    $tmp = $synopsis
    $synopsis = $syntax
    $syntax = $tmp
    @"

=== Synopsis

$(FixAsciiDocString($syntax))
"@
  }
  @"

=== Syntax

[source, powershell]
----
$($synopsis)
----
"@	

  if (!($_.alias.Length -eq 0)) {
@"

=== $($_.Name) Aliases

"@
    $_.alias | ForEach-Object {
      @"
 - $($_.Name)
"@
    }
    @"

"@
  }
	
  if ($_.parameters) {
    @"

=== Parameters

[options="autowidth"]
|===
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value
"@
    $_.parameters.parameter | ForEach-Object {
      @"
| $(FixAsciiDocString($_.Name)) | $(FixAsciiDocString($_.Aliases)) | $(FixAsciiDocString(($_.Description  | out-string).Trim())) | $(FixAsciiDocString($_.Required)) | $(FixAsciiDocString($_.PipelineInput)) | $(FixAsciiDocString($_.DefaultValue))
"@
    }
"|===
"
  }
  $inputTypes = $(FixAsciiDocString($_.inputTypes  | out-string))
  if ($inputTypes.Length -gt 0 -and -not $inputTypes.Contains('inputType')) {
    @"

=== Inputs

- $inputTypes

"@
  }
  $returnValues = $(FixAsciiDocString($_.returnValues  | out-string))
  if ($returnValues.Length -gt 0 -and -not $returnValues.StartsWith("returnValue")) {
    @"

=== Outputs

- $returnValues

"@
  }
  $notes = $(FixAsciiDocString($_.alertSet  | out-string))
  if ($notes.Trim().Length -gt 0) {
    @"

=== Note

$notes

"@
  }
  if (($_.examples | Out-String).Trim().Length -gt 0) {
    @"

=== Examples

"@
    $_.examples.example | ForEach-Object {
      @"
*$(FixAsciiDocString($_.title.Trim(('-',' '))))*
[source, powershell]
----
$(FixMarkdownCodeString($_.code | out-string ))
----
$(FixAsciiDocString($_.remarks | out-string ) $true)

"@
    }
  }
  if (($_.relatedLinks | Out-String).Trim().Length -gt 0) {
    @"

=== Links

"@
    $_.links | ForEach-Object { 
      @"
 - <<$($_.link)), $($_.name)>>
"@
    }
  }
}