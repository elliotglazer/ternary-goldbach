"""In one Lean process check the unmodified adapter, pinned input, and cached output type."""
import hashlib
import json
import os
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
PILOT = HERE.parents[1]
WORK = PILOT.parent
ROOT = WORK.parent
LEAN = Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
PACKAGES = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
CACHE = WORK / 'qrh-campaign/agents/integration/artifacts'
SOURCE = WORK / 'ternary-goldbach/TernaryGoldbach/Statement.lean'
ADAPTER = PILOT / 'FullGRH.lean'
GRH = PILOT / 'sources/grh-src-Statements.lean'
MAIN = PILOT / 'sources/grh-src-Main.lean'

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def section(path, begin, end):
    source = path.read_text(encoding='utf-8-sig')
    start = source.index(begin)
    return source[start:source.index(end, start)].strip()

def main():
    input_decl = section(GRH, 'def DirichletLZerosOnLine :', 'def PrimitiveDirichletLZerosOnLine :')
    output_decl = section(SOURCE, 'def PlattGRH :', '/-- [OeSHP]')
    export = next(line for line in MAIN.read_text(encoding='utf-8').splitlines()
                  if line.startswith('theorem LFunction_eq_zero_re :'))
    check = HERE / 'Audit.lean'
    check.write_text(ADAPTER.read_text(encoding='utf-8') + '\nnamespace PinnedAdapterAudit\n' +
        input_decl + '\n\n' + output_decl +
        '\n\nexample : PlattGRH = TernaryGoldbach.PlattGRH := rfl\n' +
        'theorem from_published_type : DirichletLZerosOnLine → TernaryGoldbach.PlattGRH :=\n' +
        '  GrhGoldbach.plattGRH_of_fullGRH\n\n' +
        '#print axioms GrhGoldbach.plattGRH_of_fullGRH\n' +
        '#print axioms from_published_type\nend PinnedAdapterAudit\n', encoding='utf-8')
    env = os.environ.copy()
    env['LEAN_PATH'] = ';'.join([str(CACHE)] +
        [str(p / '.lake/build/lib/lean') for p in PACKAGES.iterdir() if p.is_dir()])
    cmd = [str(LEAN), '-t0', '-j1', '-M4096', 'Audit.lean']
    start = time.monotonic()
    log = HERE / 'audit.log'
    with log.open('w', encoding='utf-8') as f:
        try:
            code = subprocess.run(cmd, cwd=HERE, env=env, stdin=subprocess.DEVNULL,
                stdout=f, stderr=subprocess.STDOUT, timeout=900).returncode
            timeout = False
        except subprocess.TimeoutExpired:
            code, timeout = 1, True
    files = [ADAPTER, GRH, MAIN, SOURCE, CACHE / 'TernaryGoldbach/Statement.olean', check, log]
    result = {'exit_code': code, 'wall_seconds': time.monotonic() - start, 'timeout': timeout,
              'command': cmd, 'cwd': str(HERE), 'grh_export': export,
              'sha256': {str(p.relative_to(ROOT)): digest(p) for p in files},
              'scope': 'Local conditional adapter in Lean 4.35.0. GRH Main proof was not imported.'}
    (HERE / 'receipt.json').write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(result))
    print(log.read_text(encoding='utf-8'))
    return code

if __name__ == '__main__':
    sys.exit(main())
