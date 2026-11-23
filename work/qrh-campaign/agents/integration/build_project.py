"""Serial project-only validation using read-only pinned Mathlib artifacts.

Publication assumes one compiler and no artifact readers during promotion.
Every reusable generation has a source/dependency/artifact-bound receipt.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re
import subprocess
import sys
import time
import uuid

HERE = Path(__file__).resolve().parent
WORKSPACE = HERE.parents[3]
SOURCE = WORKSPACE / 'work' / 'ternary-goldbach'
PACKAGES = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
LEAN = Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
ARTIFACTS = HERE / 'artifacts'
LOGS = HERE / 'logs'
SUFFIXES = ['.olean', '.olean.server', '.olean.private', '.ir.sig', '.ir']

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def source_path(module):
    return SOURCE.joinpath(*module.split('.')).with_suffix('.lean')

def output_path(module):
    return ARTIFACTS.joinpath(*module.split('.')).with_suffix('.olean')

def inventory(output):
    paths = [output.with_suffix(suffix) for suffix in SUFFIXES]
    return {path.name: digest(path) for path in paths if path.is_file()}

def imports(module):
    found = []
    for line in source_path(module).read_text(encoding='utf-8-sig').splitlines():
        match = re.match(r'^(?:public )?import\s+(.+)', line)
        if match:
            found.extend(name for name in match[1].split()
                         if name.startswith('TernaryGoldbach.') or name == 'LadderHints')
    return found

def write_receipt(path, value):
    temporary = path.with_name(path.name + '.' + uuid.uuid4().hex + '.tmp')
    temporary.write_text(json.dumps(value, indent=2, sort_keys=True), encoding='utf-8')
    os.replace(temporary, path)

def environment_identity(package_paths):
    return {'lean_binary_sha256': digest(LEAN),
            'lean_options': ['-j', '2', '-R', str(SOURCE)],
            'package_paths': [str(path.resolve()) for path in package_paths],
            'project_manifest_sha256': digest(SOURCE / 'lake-manifest.json')}

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('modules', nargs='+')
    parser.add_argument('--scan-only', action='store_true')
    parser.add_argument('--max-memory-mb', type=int, help='Peak memory setting passed to each Lean process')
    args = parser.parse_args()
    ordered = []
    dependencies = {}
    seen = set()

    def visit(module):
        if module in seen:
            return
        seen.add(module)
        dependencies[module] = imports(module)
        for dependency in dependencies[module]:
            visit(dependency)
        ordered.append(module)

    for module in args.modules:
        visit(module)
    print(f'Checking {len(ordered)} project modules, one Lean process at a time', flush=True)
    if args.scan_only:
        print('\n'.join(ordered))
        return 0
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    LOGS.mkdir(exist_ok=True)
    legacy_path = HERE / 'legacy-validated.json'
    legacy = json.loads(legacy_path.read_text()) if legacy_path.exists() else {}
    package_paths = [PACKAGES / 'mathlib'] + sorted(
        path for path in PACKAGES.iterdir() if path.is_dir() and path.name != 'mathlib')
    environment_key = environment_identity(package_paths)
    environment = dict(os.environ)
    environment['LEAN_PATH'] = ';'.join(
        [str(ARTIFACTS)] + [str(path / '.lake/build/lib/lean') for path in package_paths])

    for index, module in enumerate(ordered, 1):
        source = source_path(module)
        output = output_path(module)
        log = LOGS / (module + '.log')
        receipt = LOGS / (module + '.success.json')
        dependency_receipts = {
            dependency: digest(LOGS / (dependency + '.success.json'))
            for dependency in dependencies[module]}
        binding = {
            'environment': environment_key,
            'source_sha256': digest(source),
            'artifacts': inventory(output),
            'dependencies': {
                dependency: {'source_sha256': digest(source_path(dependency)),
                             'artifacts': inventory(output_path(dependency))}
                for dependency in dependencies[module]}}
        key = {'environment': environment_key, 'module': module, 'source_sha256': binding['source_sha256'],
               'dependency_receipts': dependency_receipts, 'lean': '4.35.0',
               'mathlib': '56a005855ea17e0b0958f73ec801ae140b0a1679'}
        current = json.loads(receipt.read_text()) if receipt.exists() else None
        if current and current.get('key') == key and current.get('artifacts') == binding['artifacts']:
            print(f'{index}/{len(ordered)} cached {module}', flush=True)
            continue
        approved = legacy.get(module)
        if not current and approved and approved['binding'] == binding:
            write_receipt(receipt, {'key': key, 'artifacts': binding['artifacts'],
                                   'generation': 'validated-legacy', 'evidence': approved['evidence']})
            print(f'{index}/{len(ordered)} retained verified legacy {module}', flush=True)
            continue

        output.parent.mkdir(parents=True, exist_ok=True)
        staging = output.parent / ('_partial_' + uuid.uuid4().hex)
        staging.mkdir()
        partial_output = staging / output.name
        start = time.monotonic()
        print(f'{index}/{len(ordered)} checking {module}', flush=True)
        with log.open('w', encoding='utf-8') as stream:
            limit = [f'-M{args.max_memory_mb}'] if args.max_memory_mb else []
            command = [str(LEAN), *limit, '-j', '2', '-R', str(SOURCE), '-o', str(partial_output), str(source)]
            process = subprocess.run(command,
                cwd=SOURCE, env=environment, stdout=stream, stderr=subprocess.STDOUT)
        seconds = time.monotonic() - start
        print(f'  exit={process.returncode} elapsed={seconds:.1f}s log={log}', flush=True)
        if process.returncode:
            print(log.read_text(encoding='utf-8'), flush=True)
            return process.returncode
        if digest(source) != key['source_sha256']:
            raise RuntimeError('Source changed during compilation: ' + module)
        is_module = re.search(r'(?m)^\s*module\s*(?:--.*)?$', source.read_text(encoding='utf-8-sig'))
        expected = {output.with_suffix(suffix).name for suffix in (SUFFIXES if is_module else ['.olean'])}
        produced = {path.name for path in staging.iterdir() if path.is_file()}
        if produced != expected:
            raise RuntimeError(f'Incomplete or unexpected compiler artifacts for {module}: {produced}')
        generation_inventory = inventory(partial_output)
        if receipt.exists():
            receipt.unlink()
        for suffix in SUFFIXES:
            path = output.with_suffix(suffix)
            if not path.resolve().is_relative_to(ARTIFACTS.resolve()):
                raise RuntimeError('Artifact path escaped owned root')
            if path.name not in expected and path.exists():
                path.unlink()
        for name in sorted(expected - {output.name}):
            os.replace(staging / name, output.parent / name)
        os.replace(partial_output, output)
        staging.rmdir()
        write_receipt(receipt, {'key': key, 'artifacts': generation_inventory,
                               'generation': uuid.uuid4().hex,
                               'evidence': {'exit_code': 0, 'seconds': seconds,
                                            'command': command}})
    return 0

if __name__ == '__main__':
    sys.exit(main())
