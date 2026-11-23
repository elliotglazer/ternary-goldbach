"""Focused scratch checker. Run only after the shared compiler slot is handed over."""
from pathlib import Path
import os, subprocess, sys, time
HERE = Path(__file__).resolve().parent
INTEGRATION = HERE.parent / 'integration' / 'artifacts'
PACKAGES = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
LEAN = Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
OUT = HERE / 'artifacts'
LOGS = HERE / 'logs'
OUT.mkdir(exist_ok=True)
LOGS.mkdir(exist_ok=True)
env = dict(os.environ)
env['LEAN_PATH'] = ';'.join([str(OUT), str(INTEGRATION)] + [str(p / '.lake/build/lib/lean') for p in PACKAGES.iterdir() if p.is_dir()])
for name in sys.argv[1:]:
    if name not in {'ZeroSumStrip', 'ZetaLowUnconditional', 'ZeroFreeFixedGap', 'Audit'}:
        raise ValueError(name)
    source = HERE / (name + '.lean')
    target = OUT / (name + '.olean')
    log = LOGS / (name + '.log')
    start = time.monotonic()
    print('Checking ' + name, flush=True)
    with log.open('w', encoding='utf-8') as stream:
        result = subprocess.run([str(LEAN), '-j', '2', '-R', str(HERE), '-o', str(target), str(source)], cwd=HERE, env=env, stdout=stream, stderr=subprocess.STDOUT)
    print(f'{name}: exit={result.returncode}, seconds={time.monotonic()-start:.1f}, log={log}', flush=True)
    print(log.read_text(encoding='utf-8'), flush=True)
    if result.returncode:
        sys.exit(result.returncode)
