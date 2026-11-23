param(
  [string]$Toolchain = 'C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0',
  [switch]$Large
)
$ErrorActionPreference = 'Stop'
$lean = Join-Path $Toolchain 'bin/lean.exe'
$env:LEAN_PATH = $PSScriptRoot
$env:LEAN_BENCH_EXE = $lean
Push-Location $PSScriptRoot
try {
  & $lean -t0 -o Fixtures.olean Fixtures.lean
  if ($LASTEXITCODE -ne 0) { throw 'Fixture definitions failed' }
  & $lean -t0 -o PackedFixtures.olean PackedFixtures.lean
  if ($LASTEXITCODE -ne 0) { throw 'Packed fixture definitions failed' }
  & $lean -t0 -o Audit.olean Audit.lean
  if ($LASTEXITCODE -ne 0) { throw 'Accepted theorem audit failed' }
  python run_bench.py QuickActual.lean QuickActual.replay
  if ($LASTEXITCODE -ne 0) { throw 'Direct/reusable benchmark failed' }
  python run_bench.py PackedBench.lean PackedBench.replay
  if ($LASTEXITCODE -ne 0) { throw 'Packed benchmark failed' }
  if ($Large) {
    python run_bench.py LargeBench.lean LargeBench.replay
    if ($LASTEXITCODE -ne 0) { throw 'Large benchmark failed' }
  }
} finally { Pop-Location }
