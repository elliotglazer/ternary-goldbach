param([string]$OutputPath = "$PSScriptRoot/c8_interpreter_pe_readonly_20261111.json")
$ErrorActionPreference='Stop'
# Reads PE bytes only. It does not load, import, or launch inspected binaries.
function Read-PE([string]$Path) {
  [byte[]]$b=[IO.File]::ReadAllBytes($Path)
  function U16([int]$p) {[BitConverter]::ToUInt16($b,$p)}
  function U32([int]$p) {[BitConverter]::ToUInt32($b,$p)}
  function U64([int]$p) {[BitConverter]::ToUInt64($b,$p)}
  function ZString([int]$p) {
    $e=$p
    while($e -lt $b.Length -and $b[$e] -ne 0){$e++}
    [Text.Encoding]::ASCII.GetString($b,$p,$e-$p)
  }
  if((U16 0) -ne 0x5a4d){throw 'Missing MZ'}
  $pe=[int](U32 0x3c)
  if((U32 $pe) -ne 0x4550){throw 'Missing PE'}
  $n=U16 ($pe+6); $opt=$pe+24; $magic=U16 $opt
  if($magic -ne 0x20b){throw 'This bounded parser requires PE32+'}
  $sects=@();$sp=$opt+(U16 ($pe+20))
  for($i=0;$i -lt $n;$i++){
    $p=$sp+40*$i
    $sects+= [ordered]@{name=[Text.Encoding]::ASCII.GetString($b,$p,8).Trim([char]0);virtual_size=U32 ($p+8);rva=U32 ($p+12);raw_size=U32 ($p+16);raw=U32 ($p+20)}
  }
  function Offset([uint32]$rva) {
    foreach($s in $sects){
      if($rva -ge $s.rva -and $rva -lt $s.rva+[Math]::Max($s.virtual_size,$s.raw_size)){
        return [int]($s.raw+$rva-$s.rva)
      }
    }
    if($rva -lt (U32 ($opt+60))){return [int]$rva}
    throw "Unmapped RVA $rva"
  }
  $dd=$opt+112;$imports=@();$irva=U32 ($dd+8)
  if($irva){
    $ip=Offset $irva
    for($idx=0;$idx -lt 1024;$idx++){
      $p=$ip+$idx*20;$oft=U32 $p;$name=U32 ($p+12);$ft=U32 ($p+16)
      if($oft -eq 0 -and $name -eq 0 -and $ft -eq 0){break}
      $dll=ZString (Offset $name);$tp=Offset $(if($oft){$oft}else{$ft});$names=@()
      for($j=0;$j -lt 65536;$j++){
        $v=U64 ($tp+$j*8);if($v -eq 0){break}
        if(($v -shr 63) -ne 0){$names+='#'+($v -band 65535)}
        else{$names+=ZString ((Offset ([uint32]$v))+2)}
      }
      $imports+=[ordered]@{dll=$dll;symbols=$names}
    }
  }
  $entry=U32 ($opt+16);$ep=Offset $entry
  $text=[Text.Encoding]::ASCII.GetString($b)
  $pdb=@([regex]::Matches($text,'[ -~]{0,180}\.pdb') | ForEach-Object {$_.Value})
  $info=[Diagnostics.FileVersionInfo]::GetVersionInfo($Path)
  [ordered]@{path=$Path;bytes=$b.Length;sha256=(Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash;
    machine=('0x{0:X4}' -f (U16 ($pe+4)));pe_magic=('0x{0:X4}' -f $magic);subsystem=U16 ($opt+68);
    entry_rva=$entry;entry_first_32_bytes=[Convert]::ToHexString($b[$ep..($ep+31)]);
    delay_import_rva=U32 ($dd+13*8);delay_import_size=U32 ($dd+13*8+4);
    description=$info.FileDescription;file_version=$info.FileVersion;original_filename=$info.OriginalFilename;
    imports=$imports;pdb_strings=$pdb;sections=$sects}
}
$base='C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64'
$paths=@("$base/python.exe","$base/python314.dll","$base/DLLs/_hashlib.pyd")
$result=[ordered]@{scope='Static PE byte parsing only; no inspected binary execution or loading';images=@($paths | ForEach-Object {Read-PE $_})}
if(Test-Path -LiteralPath $OutputPath){throw 'Refusing to overwrite output'}
[IO.File]::WriteAllText($OutputPath,($result | ConvertTo-Json -Depth 12),[Text.UTF8Encoding]::new($false))
$result.images | ForEach-Object {
  [ordered]@{path=$_.path;sha256=$_.sha256;subsystem=$_.subsystem;dlls=@($_.imports.dll);
    noteworthy=@($_.imports | ForEach-Object {$dll=$_.dll;$_.symbols | Where-Object {$_ -match 'Py_Main|CreateProcess|ShellExecute|WinExec|AllocConsole|AttachConsole|spawn|system'} | ForEach-Object {"$dll!$_"}});
    delay_import_rva=$_.delay_import_rva;pdb_strings=$_.pdb_strings} | ConvertTo-Json -Depth 5
}
