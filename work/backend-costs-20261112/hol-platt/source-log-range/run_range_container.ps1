param(
    [Parameter(Mandatory=$true)][ValidateSet('inspection')][string]$Kind,
    [Parameter(Mandatory=$true)][ValidatePattern('^[A-Za-z0-9_]+$')][string]$Label,
    [ValidateSet('small','full')][string]$Mode = 'small'
)
$ErrorActionPreference = 'Stop'
$workspacePath = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '../../../..')).Path
$linuxWorkspace = '/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean'
$relativeDir = 'work/backend-costs-20261112/hol-platt/source-log-range'
$localDir = (Resolve-Path -LiteralPath (Join-Path $workspacePath $relativeDir)).Path
$linuxDir = "$linuxWorkspace/$relativeDir"
$runner = 'run_range.sh'
$imageId = 'sha256:b1934ee5f1c509618f2508e6eb47ee0d3520686341fec936f3b79331f9315667'
$containerName = "tg-hol-$Kind-$Label"
$receipt = Join-Path $localDir "${Label}_container_launch.json"
$exitReceipt = Join-Path $localDir "${Label}_container_exit.json"
if ((Test-Path -LiteralPath $receipt) -or (Test-Path -LiteralPath $exitReceipt)) { throw 'Use a fresh run label.' }
$dockerArgs = @('run','--rm','--pull','never','--name',$containerName,
    '--user','0:0','--network','none','--read-only','--cap-drop','ALL',
    '--security-opt','no-new-privileges','--cpus','1','--memory','4g',
    '--memory-swap','4g','--pids-limit','64','--tmpfs','/tmp:rw,size=134217728',
    '--mount',"type=bind,source=$workspacePath,target=$linuxWorkspace,readonly",
    '--mount',"type=bind,source=$localDir,target=$linuxDir",
    '--entrypoint','/bin/sh',$imageId,"$linuxDir/$runner",$Label)
$metadataLocal = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot 'library-make-deps')).Path
$metadataLinux = "$linuxWorkspace/work/backend-costs-20261112/hol-platt/raw-analytic/dependency-build-win01/.hol/make-deps"
$metadataMount = @('--mount', "type=bind,source=$metadataLocal,target=$metadataLinux")
$helperMetadataLocal = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot 'helper-make-deps')).Path
$helperMetadataLinux = "$linuxWorkspace/work/backend-costs-20261112/hol-platt/raw-pair-round-proof/.hol/make-deps"
$metadataMount += @('--mount', "type=bind,source=$helperMetadataLocal,target=$helperMetadataLinux")
$sourceMetadataLocal = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot 'source-make-deps')).Path
$sourceMetadataLinux = "$linuxWorkspace/work/backend-costs-20261112/hol-platt/source-producer/.hol/make-deps"
$metadataMount += @('--mount', "type=bind,source=$sourceMetadataLocal,target=$sourceMetadataLinux")
$tailMetadataLocal = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot 'tail-make-deps')).Path
$tailMetadataLinux = "$linuxWorkspace/work/backend-costs-20261112/hol-platt/source-log-real/.hol/make-deps"
$metadataMount += @('--mount', "type=bind,source=$tailMetadataLocal,target=$tailMetadataLinux")
$hornerMetadataLocal = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot 'horner-make-deps')).Path
$hornerMetadataLinux = "$linuxWorkspace/work/backend-costs-20261112/hol-platt/source-log-horner/.hol/make-deps"
$metadataMount += @('--mount', "type=bind,source=$hornerMetadataLocal,target=$hornerMetadataLinux")
$imageIndex = [Array]::IndexOf($dockerArgs, $imageId)
if ($imageIndex -lt 0) { throw 'Pinned image argument missing.' }
$dockerArgs = @($dockerArgs[0..($imageIndex-1)]) + $metadataMount + @($dockerArgs[$imageIndex..($dockerArgs.Length-1)])
if ($Kind -eq 'transform') { $dockerArgs += $Mode }
$started = [DateTime]::UtcNow
@{ startedUtc=$started.ToString('o'); container=$containerName; image=$imageId; arguments=$dockerArgs } |
    ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $receipt -Encoding utf8
& docker @dockerArgs
$runStatus = $LASTEXITCODE
@{ finishedUtc=[DateTime]::UtcNow.ToString('o'); exitCode=$runStatus;
   elapsedSeconds=([DateTime]::UtcNow-$started).TotalSeconds } |
    ConvertTo-Json | Set-Content -LiteralPath $exitReceipt -Encoding utf8
exit $runStatus
