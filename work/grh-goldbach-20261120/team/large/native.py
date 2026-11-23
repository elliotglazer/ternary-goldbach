"""Build the original large-range analytic proof serially on the GRH Linux toolchain."""

import argparse
import fcntl
import hashlib
import json
import os
from pathlib import Path
import resource
import subprocess
import time
from version_headers import ADAPTERS, with_version_imports


HERE = Path(__file__).resolve().parent
PILOT = HERE.parents[1]
GOLDBACH = PILOT.parent / 'ternary-goldbach'
GRH = Path('/verification/lean')
LEAN = Path('/verification/lean-4.33.1-linux/bin/lean')
DEFAULT_OUT = Path('/tmp/goldbach-large-23b2d68-4.33.1')
EXPECTED_MATHLIB = '0df444a360eaa60ab8c11dca51a86af692955474'
GRH_FILES = {
    'Main': '017645ca448f2fd1f6fd5c4c2cb2c6e96e472725be13f6e180ca6e1574360939',
    'Statements': '79ef7ca776e42abe1f46caee13ea09bd19f1e2d0b1620d8d5d200258f33b47bf',
}


def digest(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def atomic_json(path, data):
    partial = path.with_suffix('.tmp')
    partial.write_text(json.dumps(data, indent=2) + '\n')
    partial.replace(path)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, default=DEFAULT_OUT)
    parser.add_argument('--limit', type=int, help='Stop after this many newly built modules.')
    parser.add_argument('--timeout', type=int, default=3600, help='Maximum seconds per module.')
    parser.add_argument('--memory-mb', type=int, default=8192)
    parser.add_argument('--closed', action='store_true', help='Also import the actual release Main and prove the closed corollary.')
    parser.add_argument('--elementary', action='store_true', help='Audit the exact circle identity, nonprime bound and final positivity input.')
    parser.add_argument('--replay', action='store_true', help='After the ordinary axiom audit, recheck all imports in a separate terminal job.')
    parser.add_argument('--replay-timeout', type=int, default=172800, help='Maximum seconds for the optional full-import replay.')
    args = parser.parse_args()
    if args.elementary and args.closed:
        parser.error('--elementary and --closed are separate audit targets')
    plan = json.loads((HERE / 'sources.json').read_text())
    out = args.out.resolve()
    out.mkdir(parents=True, exist_ok=True)
    lock = (out / '.lock').open('a')
    fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    os.nice(10)
    version = subprocess.check_output([LEAN, '--version'], text=True).strip()
    if 'version 4.33.1,' not in version:
        raise ValueError(version)
    packages = GRH / '.lake/packages'
    mathlib_commit = subprocess.check_output(['git', '-C', str(packages/'mathlib'), 'rev-parse', 'HEAD'], text=True).strip()
    if mathlib_commit != EXPECTED_MATHLIB:
        raise ValueError(f'Expected release Mathlib {EXPECTED_MATHLIB}, found {mathlib_commit}')
    roots = [out, GRH / '.lake/build/lib/lean', *sorted(packages.glob('*/.lake/build/lib/lean'))]
    env = dict(os.environ, LEAN_PATH=os.pathsep.join(map(str, roots)))
    receipt = out / 'receipt.json'
    key = {'compiler': version, 'mathlib': mathlib_commit, 'goldbach_commit': plan['commit'],
           'goldbach_large': plan['large_module_sha256']}
    state = json.loads(receipt.read_text()) if receipt.exists() else {'pins': key, 'passed': {}}
    if state['pins'] != key:
        raise ValueError('Existing cache pins differ. Use a fresh --out directory.')
    if args.closed:
        for name, expected in GRH_FILES.items():
            if digest(GRH/'src'/f'{name}.lean') != expected:
                raise ValueError(f'GRH release source differs: {name}')

    adapter_receipt = HERE.parent/'adapter/linux_port_8g.json'
    shared = json.loads(adapter_receipt.read_text()) if adapter_receipt.exists() else {}
    shared_jobs = {r['module'].replace('/', '.'):r for r in shared.get('jobs', []) if r['exit_code'] == 0}
    prereq = plan['elementary_project_prerequisites'] if args.elementary else plan['project_prerequisites_in_build_order']
    modules = [*ADAPTERS, *prereq, 'GoldbachElementary' if args.elementary else 'GoldbachLarge']
    if args.closed:
        modules.extend(['FullGRH', 'GoldbachLargeOfDirichletGRH', 'GoldbachLargeGRH'])
    audit_targets = (['TernaryGoldbach.Helfgott.'+decl for decl in ('circle_identity_input', 'nonprime_input', 'final_inequality_crude')]
                     if args.elementary else ['GrhGoldbach.ternary_goldbach_large' if args.closed else 'TernaryGoldbach.ternary_goldbach_large_of_hypotheses'])
    scope = 'Elementary' if args.elementary else 'Closed' if args.closed else 'Conditional'
    audit_mod = 'Audit'+scope
    audit_src = (f'import {modules[-1]}\n\n' + ''.join(f'#print axioms {target}\n' for target in audit_targets)).encode()
    modules.append(audit_mod)
    replay_mod = 'Replay'+scope
    if args.replay:
        modules.append(replay_mod)

    def save(status, **detail):
        atomic_json(receipt, state)
        if status in ('reused','passed','complete'):
            atomic_json(HERE/'native-passed.json', state)
        atomic_json(HERE/'native-progress.json', {'pins':key, 'workdir':str(out), 'status':status,
                    'updated_epoch':time.time(), 'passed_modules':len(state['passed']), **detail})

    new = 0
    for mod in modules:
        rel = Path(*mod.split('.'))
        lean_file = rel.with_suffix('.lean')
        olean = out / rel.with_suffix('.olean')
        if mod in (audit_mod, replay_mod):
            raw = audit_src
        elif mod in ['FullGRH', 'GoldbachLarge', 'GoldbachLargeOfDirichletGRH', 'GoldbachLargeGRH',
                     'GoldbachElementary', *ADAPTERS]:
            src = (PILOT if mod == 'FullGRH' else HERE) / lean_file
            raw = src.read_bytes().replace(b'\r\n', b'\n')
        else:
            raw = (GOLDBACH / lean_file).read_bytes().replace(b'\r\n', b'\n')
        sha = hashlib.sha256(raw).hexdigest()
        expected = plan['project_prerequisite_sha256'].get(mod)
        if mod == 'GoldbachLarge':
            expected = plan['large_module_sha256']
        if mod == 'GoldbachElementary':
            expected = plan['elementary_module_sha256']
        if expected and expected != sha:
            raise ValueError(f'Pinned source differs: {mod}')
        adapted = with_version_imports(raw, mod) if mod in plan['project_prerequisite_sha256'] else raw
        compiled_sha = hashlib.sha256(adapted).hexdigest()
        if mod == 'GoldbachLargeGRH':
            if not (roots[1]/'Main.olean').is_file():
                save('waiting_for_grh_main', module=mod)
                return 3
            grh_inputs = {name:{'source':expected, 'olean':digest(roots[1]/f'{name}.olean')}
                          for name,expected in GRH_FILES.items()}
            if 'grh_inputs' in state and state['grh_inputs'] != grh_inputs:
                raise ValueError('The GRH proof inputs changed. Use a fresh --out directory.')
            state['grh_inputs'] = grh_inputs
        prior = state['passed'].get(mod, {})
        if (prior.get('source') == sha and prior.get('compiled_source', sha) == compiled_sha
                and olean.is_file() and prior['olean'] == digest(olean)):
            continue
        if prior:
            raise ValueError(f'Previously compiled {mod} changed. Use a fresh --out directory.')
        if args.limit is not None and new >= args.limit:
            save('limit', next_module=mod)
            return 0
        olean.parent.mkdir(parents=True, exist_ok=True)
        if mod in ('TernaryGoldbach.Statement', 'FullGRH') and mod in shared_jobs and shared.get('lean') == version:
            seed = Path(shared['workdir']) / rel.with_suffix('.olean')
            if seed.is_file() and digest(seed) == shared_jobs[mod]['sha256_olean']:
                source = seed.with_suffix('.lean')
                if source.read_bytes().replace(b'\r\n', b'\n') != raw:
                    raise ValueError(f'Seed source differs: {mod}')
                olean.write_bytes(seed.read_bytes())
                state['passed'][mod] = {'source':sha, 'olean':digest(olean), 'shared_receipt':str(adapter_receipt)}
                save('reused', module=mod)
                continue
        (out / lean_file).write_bytes(adapted)
        log = out / rel.with_suffix('.log')
        # A zero trust level rechecks every import. Keep this extra run optional.
        replay = ['-t0'] if mod == replay_mod else []
        cmd = [str(LEAN), '-j1', *replay, f'-M{args.memory_mb}', '-o', str(rel.with_suffix('.olean')), str(lean_file)]
        save('running', module=mod, command=cmd)
        before = resource.getrusage(resource.RUSAGE_CHILDREN)
        start = time.monotonic()
        with log.open('w') as f:
            try:
                code = subprocess.run(cmd, cwd=out, env=env, stdout=f, stderr=subprocess.STDOUT,
                                      stdin=subprocess.DEVNULL, timeout=args.replay_timeout if replay else args.timeout).returncode
            except subprocess.TimeoutExpired:
                code = 124
        after = resource.getrusage(resource.RUSAGE_CHILDREN)
        result = {'module':mod, 'code':code, 'recheck_all_imports':bool(replay), 'wall_seconds':round(time.monotonic()-start,3),
                  'cpu_seconds':round(after.ru_utime+after.ru_stime-before.ru_utime-before.ru_stime,3), 'log':str(log)}
        if code:
            save('failed', **result)
            print(json.dumps(result), flush=True)
            print(log.read_text(errors='replace')[-10000:], flush=True)
            return code
        if mod in (audit_mod, replay_mod):
            audit = log.read_text()
            result['axioms'] = {}
            for target in audit_targets:
                names = audit.split(f"'{target}' depends on axioms: [",1)[1].split(']',1)[0].split(',')
                axioms = {a.strip() for a in names}
                if not axioms <= {'propext','Classical.choice','Quot.sound'}:
                    raise ValueError(f'Unapproved axioms: {axioms}')
                result['axioms'][target] = sorted(axioms)
        state['passed'][mod] = {'source':sha, 'compiled_source':compiled_sha, 'olean':digest(olean), **result}
        new += 1
        save('passed', **result)
        print(json.dumps(result), flush=True)
    save('complete', targets=audit_targets, audit=state['passed'][audit_mod],
         full_import_replay=state['passed'].get(replay_mod))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
