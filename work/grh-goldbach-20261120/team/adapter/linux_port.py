"""Compile a pinned consumer directly against the GRH checkout's native Linux cache."""
import hashlib
import json
import os
import resource
import subprocess
import sys
import tempfile
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
PILOT = HERE.parents[1]
WORK = PILOT.parent
GRH = Path('/verification/lean')
BIN = Path('/verification/lean-4.33.1-linux/bin/lean')
STATEMENT = WORK / 'ternary-goldbach/TernaryGoldbach/Statement.lean'
ADAPTER = PILOT / 'FullGRH.lean'
GRH_STATEMENT = GRH / 'src/Statements.lean'
PINS = {
    STATEMENT: '3f61837d2c3a0dde3a1997f05af21c20c7fe6ee13e29891125495f6947596bf8',
    ADAPTER: 'e5e8c5691e16cc10a28123f2bfed636b35d24d058d2e5ac4444f9122fd184260',
    GRH_STATEMENT: '79ef7ca776e42abe1f46caee13ea09bd19f1e2d0b1620d8d5d200258f33b47bf',
}


def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main():
    roots = [GRH / '.lake/build/lib/lean'] + sorted(GRH.glob('.lake/packages/*/.lake/build/lib/lean'))
    names = ['Statements.olean', 'Mathlib.olean']
    providers = {name: next(root / name for root in roots if (root / name).is_file()) for name in names}
    if (GRH / 'lean-toolchain').read_text().strip() != 'leanprover/lean4:v4.33.1':
        raise ValueError('GRH checkout has a different toolchain')
    for path, sha in PINS.items():
        if digest(path) != sha:
            raise ValueError(f'Source hash mismatch: {path}')
    print('Preflight passed', flush=True)
    version = subprocess.check_output([BIN, '--version'], text=True).strip()
    if 'version 4.33.1,' not in version:
        raise ValueError(version)
    out = Path(tempfile.mkdtemp(prefix='goldbach-grh-port-'))
    (out / 'TernaryGoldbach').mkdir()
    (out / 'TernaryGoldbach/Statement.lean').write_bytes(STATEMENT.read_bytes())
    (out / 'FullGRH.lean').write_bytes(ADAPTER.read_bytes())
    (out / 'PortAudit.lean').write_text('''import Statements
import FullGRH

theorem plattGRH_of_release_statement (h : DirichletLZerosOnLine) : TernaryGoldbach.PlattGRH :=
  GrhGoldbach.plattGRH_of_fullGRH h

#print axioms plattGRH_of_release_statement
''')
    env = dict(os.environ, LEAN_PATH=':'.join(map(str, [out] + roots)))
    ordinary = sys.argv[1:] == ['--ordinary-statement']
    tuned = ordinary or sys.argv[1:] == ['--high-memory']
    suffix = '_ordinary' if ordinary else ('_8g' if tuned else '')
    result = {'lean': version, 'workdir': str(out), 'inputs': {str(p): digest(p) for p in PINS},
              'upstream_oleans': {name: str(path) for name, path in providers.items()}, 'jobs': []}
    receipt = HERE / ('linux_port' + suffix + '.json')
    def save():
        receipt.write_text(json.dumps(result, indent=2) + '\n')
    save()
    os.nice(8)
    modules = ['TernaryGoldbach/Statement'] if ordinary else ['TernaryGoldbach/Statement', 'FullGRH', 'PortAudit']
    for module in modules:
        cmd = [str(BIN), '-j1']
        if not ordinary:
            cmd.append('-t0')
        cmd.extend(['-M8192' if tuned else '-M4096', '-o', module + '.olean', module + '.lean'])
        before = resource.getrusage(resource.RUSAGE_CHILDREN)
        start = time.monotonic()
        log = HERE / ('linux_' + module.replace('/', '_') + suffix + '.log')
        with log.open('w') as f:
            try:
                rc = subprocess.run(cmd, stdout=f, stderr=subprocess.STDOUT, stdin=subprocess.DEVNULL,
                    env=env, cwd=out, timeout=600 if tuned else 180).returncode
            except subprocess.TimeoutExpired:
                rc = 124
        after = resource.getrusage(resource.RUSAGE_CHILDREN)
        row = {'module': module, 'command': cmd, 'exit_code': rc, 'wall_seconds': time.monotonic()-start,
               'cpu_seconds': after.ru_utime+after.ru_stime-before.ru_utime-before.ru_stime,
               'log': log.name, 'sha256_log': digest(log)}
        if rc == 0:
            row['sha256_olean'] = digest(out / (module+'.olean'))
        result['jobs'].append(row)
        save()
        print(json.dumps(row), flush=True)
        if rc or module == 'PortAudit':
            print(log.read_text(), flush=True)
        if rc:
            return rc
    return 0


if __name__ == '__main__':
    sys.exit(main())
