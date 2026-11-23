param(
    [Parameter(Mandatory=$true)][ValidateSet('inspection')][string]$Kind,
    [Parameter(Mandatory=$true)][ValidatePattern('^[A-Za-z0-9_]+$')][string]$Label,
    [ValidateSet('small','full')][string]$Mode = 'small'
)
$ErrorActionPreference = 'Stop'
$workspacePath = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '../../../..')).Path
$linuxWorkspace = '/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean'
$relativeDir = 'work/backend-costs-20261112/hol-platt/c10004-traversal-cv'
$localDir = (Resolve-Path -LiteralPath (Join-Path $workspacePath $relativeDir)).Path
$linuxDir = "$linuxWorkspace/$relativeDir"
$runner = 'run_inspection.sh'
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
