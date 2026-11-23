"""Unexecuted diagnostic variant runner; NOT provider validation/publication.

Coordinator only: python probe_leaf_imports.py --variant original-imports --run
Variants: original-imports, narrow-imports, narrow-full. One attempt per launch.
Uses only the pinned first-leaf monitor's WindowsMonitor and receipt utilities;
its main is never called. Every attempt gets an exclusive quarantine. No Lake,
dependency compilation, source changes, artifact reuse, or accepted output.
"""
from pathlib import Path
from datetime import datetime, timezone
import argparse
import hashlib
import json
import os
import subprocess
import sys
import time
import traceback
import types
import uuid

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
ORIGINAL_ROOT = ROOT / 'work/openai-math/lean'
MODULE = 'OAI.NumberTheory.DirichletL.Arithmetic.EisensteinCoordinates'
RELATIVE_SOURCE = Path(*MODULE.split('.')).with_suffix('.lean')
ORIGINAL = ORIGINAL_ROOT / RELATIVE_SOURCE
STAGING = HERE / 'memory-probe/staging.json'
MONITOR = HERE / 'probe_first_leaf.py'
MONITOR_PIN = '32c72e2b278bd34742eb4d75a4308f7d1fbfc985f90e980196ad06375610a807'
STAGING_PIN = 'fdcb7789127f93226eb23fdcd1e96d8d07d9bacfcdb929be8694b971eb39edf9'
ORIGINAL_PIN = 'a97237026d0add0b1e1f6a3a025a253a9e6dd17c0e06929f779772727f02260b'
BODY_PIN = '6a659f2c2a18dbb4197b99f8811ebecc2aa4bbe204bc21433213398d960a1ab6'
PINS = {
    'original-imports': 'c91875463748e56248d08cb61560d4e9b59e8f89dad0b44ec9c9a73995fae1d3',
    'narrow-imports': '6ec94466c931d165e4bce8ece24bcc2f9bda6c3923a431ff01e5595994ac6c2a',
    'narrow-full': '7a9e677b2abd33b80be2278b202895e94a11c71a49b81da72314fd8e1d05091b',
}
QUARANTINE = HERE / 'leaf-import-quarantine'


def digest(data):
    return hashlib.sha256(data).hexdigest()


def load_monitor():
    # Execute exactly the bytes checked, not a later read or a cached .pyc.
    data = MONITOR.read_bytes()
    if digest(data) != MONITOR_PIN:
        raise RuntimeError('Pinned monitor changed; re-review required.')
    module = types.ModuleType('_pinned_leaf_monitor')
    module.__file__ = str(MONITOR)
    exec(compile(data, str(MONITOR), 'exec'), module.__dict__)
    return module


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--variant', required=True, choices=tuple(PINS))
    parser.add_argument('--run', action='store_true')
    args = parser.parse_args()
    if not args.run:
        parser.error('No launch without --run.')
    if os.name != 'nt':
        parser.error('Windows monitor required; no unmonitored fallback.')
    if QUARANTINE.exists() and QUARANTINE.resolve() != QUARANTINE.absolute():
        raise RuntimeError('Redirected quarantine parent; no writes.')
    QUARANTINE.mkdir(exist_ok=True)
    attempt = QUARANTINE / (datetime.now(timezone.utc).strftime('%m%dT%H%M%S_') + args.variant + '_' + uuid.uuid4().hex[:8])
    attempt.mkdir(exist_ok=False)
    artifacts = attempt / 'artifacts'
    artifacts.mkdir(exist_ok=False)
    source_root = HERE / 'memory-probe' / args.variant / 'src'
    source = source_root / RELATIVE_SOURCE
    output = artifacts / RELATIVE_SOURCE.with_suffix('.olean')
    output.parent.mkdir(parents=True, exist_ok=False)
    result = dict(kind='diagnostic_leaf_import_variant', variant=args.variant,
                  header_only=args.variant != 'narrow-full', module=MODULE,
                  provider_validated=False, reusable_accepted_artifact=False,
                  publication='none; never add this attempt to another LEAN_PATH',
                  axiom_audit_performed=False, dependencies_rehashed=False,
                  status='preflight_failed', original_provider_root=str(ORIGINAL_ROOT),
                  staged_source_root=str(source_root), started_utc=datetime.now(timezone.utc).isoformat(),
                  python_executable=sys.executable, python_version=sys.version,
                  wrapper_sha256=digest(Path(__file__).read_bytes()),
                  monitor_sha256_expected=MONITOR_PIN, staging_sha256_expected=STAGING_PIN)
    monitor_module = monitor = process = None
    started = time.monotonic()
    launched = finished = None
    count = peak_private = peak_ws = peak_pagefile = 0
    expected = {}
    try:
        monitor_module = m = load_monitor()
        if (m.PRIVATE_BYTES, m.WALL_SECONDS, m.SAMPLE_SECONDS) != (4 * 1024**3, 600.0, 0.25):
            raise RuntimeError('Unexpected monitor limits.')
        options = ['-t0', '-j', '1', '-M4096', '-DautoImplicit=false', '-R', str(source_root)]
        command = [str(m.LEAN), *options, '-o', str(output), str(source)]
        expected = {source: PINS[args.variant], ORIGINAL: ORIGINAL_PIN,
                    STAGING: STAGING_PIN, MONITOR: MONITOR_PIN, m.LEAN: m.COMPILER_PIN,
                    ORIGINAL_ROOT/'lakefile.lean': m.LAKEFILE_PIN,
                    ORIGINAL_ROOT/'lake-manifest.json': m.MANIFEST_PIN}
        result['expected_input_hashes'] = {str(p): h for p, h in expected.items()}
        result['input_hashes_before'] = {str(p): m.sha(p) for p in expected}
        if any(result['input_hashes_before'][str(p)] != h for p, h in expected.items()):
            raise RuntimeError('Pinned input changed.')
        original_body = b'namespace OAI' + ORIGINAL.read_bytes().split(b'namespace OAI', 1)[1]
        if digest(original_body) != BODY_PIN:
            raise RuntimeError('Original body pin mismatch.')
        if args.variant == 'narrow-full':
            candidate_body = b'namespace OAI' + source.read_bytes().split(b'namespace OAI', 1)[1]
            if candidate_body != original_body:
                raise RuntimeError('Full candidate body changed.')
        result['original_body_sha256'] = BODY_PIN
        result['body_equal'] = True if args.variant == 'narrow-full' else None
        staging = json.loads(STAGING.read_text(encoding='utf-8'))
        entry = staging['variants'][args.variant]
        if (Path(entry['source']) != source or Path(entry['source_root']) != source_root
                or entry['sha256'] != PINS[args.variant]):
            raise RuntimeError('Staging path/pin mismatch.')
        graph_path = ROOT/'work/qrh-campaign/agents/integration/qrh-import-graph.json'
        if json.loads(graph_path.read_text(encoding='utf-8-sig')).get(MODULE) != []:
            raise RuntimeError('First leaf has custom dependencies.')
        result['saved_import_graph_sha256'] = m.sha(graph_path)
        package_roots = [m.PACKAGES/'mathlib'] + sorted(
            (p for p in m.PACKAGES.iterdir() if p.is_dir() and p.name != 'mathlib'),
            key=lambda p: p.name.lower())
        package_paths = [p/'.lake/build/lib/lean' for p in package_roots]
        if not (package_paths[0]/'Mathlib.olean').is_file():
            raise RuntimeError('Missing prebuilt Mathlib; no dependency build permitted.')
        package_paths = [p for p in package_paths if p.is_dir()]
        result['prebuilt_package_metadata'] = {
            str(p): {str(f.relative_to(p)): m.sha(f)
                     for f in [p/'lean-toolchain', p/'lake-manifest.json'] if f.is_file()}
            for p in package_roots}
        environment = dict(os.environ)
        # Replace, never extend, inherited search paths. No earlier attempt is included.
        environment['LEAN_PATH'] = ';'.join(map(str, [artifacts, *package_paths]))
        removed = [k for k in ('LEAN_SYSROOT', 'LEAN_OPTS', 'LEAN_OPTIONS') if k in environment]
        for key in removed:
            del environment[key]
        result.update(command=command, cwd=str(source_root), options=options,
                      options_sha256=digest(m.encode(options)), lean_path=environment['LEAN_PATH'],
                      removed_environment_keys=removed,
                      package_options_source=str(ORIGINAL_ROOT/'lakefile.lean'),
                      package_options='autoImplicit=false; original provider metadata, no Lake evaluation',
                      limits=dict(lean_workers=1, job_active_processes=1, lean_memory_megabytes=4096,
                                  observed_private_bytes=m.PRIVATE_BYTES, process_wall_seconds=m.WALL_SECONDS,
                                  sample_interval_seconds=m.SAMPLE_SECONDS, hard_memory_cap=False))
        m.exclusive_json(attempt/'request.json', result)
        monitor = m.WindowsMonitor()
        with (attempt/'lean.log').open('xb') as log, (attempt/'telemetry.jsonl').open('xb') as telemetry:
            launched = time.monotonic()
            result['status'] = 'launch_failed'
            process = subprocess.Popen(command, cwd=source_root, env=environment,
                                       stdin=subprocess.DEVNULL, stdout=log, stderr=subprocess.STDOUT,
                                       creationflags=subprocess.CREATE_NO_WINDOW)
            result.update(pid=process.pid, status='job_assignment_failed')
            monitor.assign(process)
            result['status'] = 'running'
            while process.poll() is None:
                elapsed = time.monotonic()-launched
                if elapsed >= m.WALL_SECONDS:
                    result['status'] = 'wall_limit_stop'
                    monitor.terminate()
                    break
                try:
                    sample = dict(monitor.sample(process), process_wall_seconds=elapsed, utc=m.utc())
                except OSError:
                    if process.poll() is not None:
                        break
                    raise
                telemetry.write(json.dumps(sample, sort_keys=True).encode()+b'\n')
                telemetry.flush()
                count += 1
                peak_private = max(peak_private, sample['private_bytes'])
                peak_ws = max(peak_ws, sample['os_peak_working_set_bytes'])
                peak_pagefile = max(peak_pagefile, sample['os_peak_pagefile_bytes'])
                if sample['private_bytes'] >= m.PRIVATE_BYTES:
                    result['status'] = 'observed_private_limit_stop'
                    monitor.terminate()
                    break
                time.sleep(min(m.SAMPLE_SECONDS, max(0, m.WALL_SECONDS-(time.monotonic()-launched))))
            process.wait(timeout=5)
            finished = time.monotonic()
            if result['status'] == 'running':
                result['status'] = 'diagnostic_exit_zero' if process.returncode == 0 else 'diagnostic_exit_nonzero'
    except BaseException as error:
        if isinstance(error, KeyboardInterrupt):
            result['status'] = 'operator_interrupt'
        elif result['status'] == 'running':
            result['status'] = 'monitor_or_runtime_failure'
        result['exception'] = ''.join(traceback.format_exception(type(error), error, error.__traceback__))
    finally:
        if process is not None and process.poll() is None:
            try:
                if monitor is not None:
                    monitor.terminate()
            except OSError as error:
                result['job_termination_error'] = repr(error)
            if process.poll() is None:
                try:
                    process.kill()
                except OSError as error:
                    result['process_termination_error'] = repr(error)
            try:
                process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                result['cleanup_failed'] = True
        if process is not None:
            result['exit_code'] = process.poll()
            finished = finished or time.monotonic()
            if monitor is not None:
                try:
                    result.update(monitor.cpu(process))
                except OSError as error:
                    result['final_cpu_error'] = repr(error)
                    if result['status'] == 'diagnostic_exit_zero':
                        result['status'] = 'diagnostic_measurement_incomplete'
        if monitor is not None:
            monitor.close()
        result.update(finished_utc=datetime.now(timezone.utc).isoformat(),
                      overall_wall_seconds=time.monotonic()-started,
                      process_wall_seconds=None if launched is None else (finished or time.monotonic())-launched,
                      sample_count=count, observed_peak_private_bytes=peak_private,
                      observed_os_peak_working_set_bytes=peak_ws, observed_os_peak_pagefile_bytes=peak_pagefile)
        try:
            result['input_hashes_after'] = {str(p): digest(p.read_bytes()) for p in expected}
            result['pinned_inputs_unchanged'] = bool(expected) and all(
                result['input_hashes_after'][str(p)] == pin for p, pin in expected.items())
            result['output_inventory'] = {
                str(p.relative_to(artifacts)): {'bytes': p.stat().st_size, 'sha256': digest(p.read_bytes())}
                for p in sorted(artifacts.rglob('*')) if p.is_file()}
            log_path = attempt/'lean.log'
            result['log_sha256'] = digest(log_path.read_bytes()) if log_path.exists() else None
            result['expected_primary_output_present'] = output.is_file()
            if result['status'] == 'diagnostic_exit_zero' and not (
                    result['pinned_inputs_unchanged'] and output.is_file()):
                result['status'] = 'diagnostic_rejected_postconditions'
        except BaseException as error:
            result.update(postcheck_exception=repr(error), status='diagnostic_postcheck_failure')
        # Local fallback preserves preflight failures even when monitor loading failed.
        with (attempt/'diagnostic.json').open('xb') as receipt:
            receipt.write((json.dumps(result, indent=2, sort_keys=True)+'\n').encode())
            receipt.flush()
            os.fsync(receipt.fileno())
        print(json.dumps(dict(status=result['status'], quarantine=str(attempt), accepted_artifact=False)), flush=True)
    return 0 if result['status'] == 'diagnostic_exit_zero' else 1


if __name__ == '__main__':
    raise SystemExit(main())
