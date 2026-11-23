param([string]$Receipt = "$PSScriptRoot/../integration/c8_interpreter_pe_readonly_20261111.json",
      [string]$Output = "$PSScriptRoot/review_c8_pe_bytes_20261111.json")
$ErrorActionPreference = 'Stop'
# Independent file-byte parser only. No image load, process launch/query, or fixture.
if (Test-Path -LiteralPath $Output) { throw 'Refusing overwrite' }
$saved = Get-Content -LiteralPath $Receipt -Raw | ConvertFrom-Json
$rows = @()
foreach ($item in $saved.images) {
  [byte[]]$bytes = [IO.File]::ReadAllBytes($item.path)
  function At([long]$p, [long]$n) {
    if ($p -lt 0 -or $n -lt 0 -or $p+$n -gt $bytes.Length) { throw 'File range' }
  }
  function Word([long]$p) { At $p 2; [BitConverter]::ToUInt16($bytes,[int]$p) }
  function Dword([long]$p) { At $p 4; [BitConverter]::ToUInt32($bytes,[int]$p) }
  function Qword([long]$p) { At $p 8; [BitConverter]::ToUInt64($bytes,[int]$p) }
  if ((Word 0) -ne 0x5a4d) { throw 'DOS signature' }
  $header = Dword 0x3c
  if ((Dword $header) -ne 0x4550) { throw 'PE signature' }
  $opt = $header + 24
  if ((Word $opt) -ne 0x20b -or (Dword ($opt+108)) -lt 14) { throw 'Optional header/directories' }
  $sectionCount = Word ($header+6)
  $sectionStart = $opt + (Word ($header+20))
  $sections = @()
  for ($i=0; $i -lt $sectionCount; $i++) {
    $pos = $sectionStart + 40*$i
    At $pos 40
    $sections += ,@([long](Dword ($pos+12)),[long](Dword ($pos+16)),[long](Dword ($pos+20)))
  }
  function Map([long]$rva, [long]$n) {
    if ($rva -lt (Dword ($opt+60))) { At $rva $n; return $rva }
    foreach ($section in $sections) {
      $d = $rva-$section[0]
      if ($d -ge 0 -and $d+$n -le $section[1]) {
        $p = $section[2]+$d; At $p $n; return $p
      }
    }
    throw 'RVA has no complete file-backed span'
  }
  function CStringRva([long]$rva) {
    $chars = [Collections.Generic.List[byte]]::new()
    for ($i=0; $i -lt 65536; $i++) {
      $p = Map ($rva+$i) 1
      if ($bytes[$p] -eq 0) { return [Text.Encoding]::ASCII.GetString($chars.ToArray()) }
      $chars.Add($bytes[$p])
    }
    throw 'Missing string terminator'
  }
  $importRva = Dword ($opt+120)
  $importSize = Dword ($opt+124)
  $imports = @(); $ended = ($importRva -eq 0)
  for ($i=0; -not $ended -and 20*($i+1) -le $importSize; $i++) {
    $p = Map ($importRva+20*$i) 20
    $orig = Dword $p; $name = Dword ($p+12); $iat = Dword ($p+16)
    if ((Dword $p) -eq 0 -and (Dword ($p+4)) -eq 0 -and (Dword ($p+8)) -eq 0 -and $name -eq 0 -and $iat -eq 0) {
      $ended = $true; break
    }
    $thunk = if ($orig -ne 0) { $orig } else { $iat }
    $symbols = @(); $thunkEnded = $false
    for ($j=0; $j -lt 65536; $j++) {
      [uint64]$v = Qword (Map ($thunk+8*$j) 8)
      if ($v -eq 0) { $thunkEnded = $true; break }
      if (($v -shr 63) -eq 1) { $symbols += '#'+($v -band 65535) }
      else {
        if ($v -gt [uint32]::MaxValue) { throw 'Invalid name thunk RVA' }
        $symbols += CStringRva ($v+2)
      }
    }
    if (-not $thunkEnded) { throw 'Unterminated thunk table' }
    $imports += [ordered]@{dll=(CStringRva $name);symbols=@($symbols)}
  }
  if (-not $ended) { throw 'Unterminated import directory' }
  $hash = (Get-FileHash -LiteralPath $item.path -Algorithm SHA256).Hash
  if ($hash -cne $item.sha256 -or $bytes.Length -ne $item.bytes) { throw 'Binary changed' }
  if ((Word ($header+4)) -ne 0x8664 -or (Word ($opt+68)) -ne $item.subsystem) { throw 'Machine/subsystem mismatch' }
  if ((Dword ($opt+112+13*8)) -ne $item.delay_import_rva -or
      (Dword ($opt+116+13*8)) -ne $item.delay_import_size) { throw 'Delay directory mismatch' }
  if (($imports | ConvertTo-Json -Depth 6 -Compress) -cne
      ($item.imports | ConvertTo-Json -Depth 6 -Compress)) { throw 'Import directory mismatch' }
  $rows += [ordered]@{path=$item.path;sha256=$hash;import_dlls=$imports.Count;
    import_symbols=(@($imports | ForEach-Object {$_.symbols})).Count;
    import_directory_terminated=$ended;all_name_spans_file_backed=$true;match=$true}
}
$result=[ordered]@{scope='Static file bytes only; no inspected image execution/loading or process query';
  author_receipt_sha256=(Get-FileHash -LiteralPath $Receipt -Algorithm SHA256).Hash;
  images=$rows;status='PASS'}
[IO.File]::WriteAllText($Output,($result | ConvertTo-Json -Depth 6),[Text.UTF8Encoding]::new($false))
$result | ConvertTo-Json -Depth 6
