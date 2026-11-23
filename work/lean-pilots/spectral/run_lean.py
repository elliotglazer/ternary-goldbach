"""Owned narrow Lean pilot; dependency caches are read-only."""
from pathlib import Path
import hashlib, json, os, subprocess, sys, time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
LEAN = Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
PACKAGES = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
CACHE = ROOT / 'work/qrh-campaign/agents/integration/artifacts'
name = sys.argv[1]
assert name.isidentifier()
source = HERE / (name + '.lean')
out = HERE / (name + '.olean')
env = dict(os.environ)
env['LEAN_PATH'] = ';'.join([str(HERE), str(HERE.parent / 'spectral-abel'),
    str(HERE.parent / 'spectral-reality'), str(HERE.parent / 'spectral-completion'), str(CACHE)] +
    [str(p / '.lake/build/lib/lean') for p in PACKAGES.iterdir() if p.is_dir()])
stamp = time.strftime('%Y%m%d_%H%M%S')
log = HERE / (name + '_' + stamp + '.log')
start = time.monotonic()
source_hash = hashlib.sha256(source.read_bytes()).hexdigest()
cmd = [str(LEAN), '-t0', '-j', '2', '-R', str(HERE), '-o', str(out), str(source)]
with log.open('x', encoding='utf-8') as f:
    process = subprocess.run(cmd, cwd=HERE, env=env, stdout=f, stderr=subprocess.STDOUT)
receipt = dict(command=cmd, exit_code=process.returncode,
    seconds=time.monotonic()-start, source_sha256=source_hash,
    source_unchanged=source_hash == hashlib.sha256(source.read_bytes()).hexdigest(),
    log=str(log), dependency_build=False)
if process.returncode == 0:
    receipt['olean_sha256'] = hashlib.sha256(out.read_bytes()).hexdigest()
with log.with_suffix('.json').open('x', encoding='utf-8') as f:
    json.dump(receipt, f, indent=2)
print(log.read_text(encoding='utf-8'))
print(json.dumps(receipt))
sys.exit(process.returncode)
