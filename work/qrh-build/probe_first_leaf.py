"""Prepare/run ONE original QRH leaf as a quarantined Windows diagnostic.

Authoring status: not executed or syntax-tested when first submitted for review.
Run only after coordinator approval: python probe_first_leaf.py --run

No Lake, source edits, dependency compilation, cache reuse or publication.
Even exit zero is NOT provider validation or an accepted reusable artifact.
Limits: one Lean worker/process, sampled private bytes 4 GiB, wall 600 seconds.
The process is assigned to a kill-on-close job immediately after Popen; no
untrusted task code is deliberately run before assignment. If assignment fails,
the process is terminated and the attempt is rejected. Samples are observations,
not a claim to capture every between-sample memory peak or an OS hard memory cap.
"""
from __future__ import annotations

import argparse
import ctypes as ct
from ctypes import wintypes as wt
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time
import traceback
import uuid

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
SOURCE_ROOT = ROOT / 'work/openai-math/lean'
MODULE = 'OAI.NumberTheory.DirichletL.Arithmetic.EisensteinCoordinates'
SOURCE = SOURCE_ROOT.joinpath(*MODULE.split('.')).with_suffix('.lean')
LEAN = Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe')
PACKAGES = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
QUARANTINE = HERE / 'first-leaf-quarantine'
WALL_SECONDS = 600.0
PRIVATE_BYTES = 4 * 1024**3
SAMPLE_SECONDS = 0.25
SOURCE_PIN = 'a97237026d0add0b1e1f6a3a025a253a9e6dd17c0e06929f779772727f02260b'
COMPILER_PIN = 'ec7a472d1c12a09b0c0c718f7427c2be527b3f5f07810fdbe076c2507c7a91ea'
LAKEFILE_PIN = '9847ec38547c41c8ed14b0d28a5f0ef38f5883334e648b52e4ffff58cf60c676'
MANIFEST_PIN = 'b61e36d7fb579f9eb682afc4623e871934189e1248c4c92e69f9e9e2e6fc0227'


def sha(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for data in iter(lambda: f.read(1024**2), b''):
            h.update(data)
    return h.hexdigest()


def encode(value) -> bytes:
    return (json.dumps(value, indent=2, sort_keys=True) + '\n').encode('utf-8')


def exclusive_json(path: Path, value) -> None:
    with path.open('xb') as f:
        f.write(encode(value))
        f.flush()
        os.fsync(f.fileno())


def utc() -> str:
    return datetime.now(timezone.utc).isoformat()


class BasicLimits(ct.Structure):
    _fields_ = [('process_time', ct.c_longlong), ('job_time', ct.c_longlong),
                ('flags', wt.DWORD), ('min_ws', ct.c_size_t), ('max_ws', ct.c_size_t),
                ('active_processes', wt.DWORD), ('affinity', ct.c_size_t),
                ('priority', wt.DWORD), ('scheduling', wt.DWORD)]


class IOCounters(ct.Structure):
    _fields_ = [(name, ct.c_ulonglong) for name in
                ('read_ops', 'write_ops', 'other_ops', 'read_bytes', 'write_bytes', 'other_bytes')]


class ExtendedLimits(ct.Structure):
    _fields_ = [('basic', BasicLimits), ('io', IOCounters),
                ('process_memory', ct.c_size_t), ('job_memory', ct.c_size_t),
                ('peak_process_memory', ct.c_size_t), ('peak_job_memory', ct.c_size_t)]


class ProcessMemory(ct.Structure):
    _fields_ = [('cb', wt.DWORD), ('page_faults', wt.DWORD)] + [
        (name, ct.c_size_t) for name in
        ('peak_working_set', 'working_set', 'peak_paged_pool', 'paged_pool',
         'peak_nonpaged_pool', 'nonpaged_pool', 'pagefile', 'peak_pagefile', 'private')]


class WindowsMonitor:
    def __init__(self):
        self.k = ct.WinDLL('kernel32', use_last_error=True)
        self.p = ct.WinDLL('psapi', use_last_error=True)
        self.k.CreateJobObjectW.argtypes = [ct.c_void_p, wt.LPCWSTR]
        self.k.CreateJobObjectW.restype = wt.HANDLE
        self.k.SetInformationJobObject.argtypes = [wt.HANDLE, ct.c_int, ct.c_void_p, wt.DWORD]
        self.k.SetInformationJobObject.restype = wt.BOOL
        self.k.AssignProcessToJobObject.argtypes = [wt.HANDLE, wt.HANDLE]
        self.k.AssignProcessToJobObject.restype = wt.BOOL
        self.k.TerminateJobObject.argtypes = [wt.HANDLE, wt.UINT]
        self.k.TerminateJobObject.restype = wt.BOOL
        self.k.CloseHandle.argtypes = [wt.HANDLE]
        self.k.CloseHandle.restype = wt.BOOL
        self.k.GetProcessTimes.argtypes = [wt.HANDLE] + [ct.POINTER(wt.FILETIME)]*4
        self.k.GetProcessTimes.restype = wt.BOOL
        self.p.GetProcessMemoryInfo.argtypes = [wt.HANDLE, ct.POINTER(ProcessMemory), wt.DWORD]
        self.p.GetProcessMemoryInfo.restype = wt.BOOL
        self.job = self.k.CreateJobObjectW(None, None)
        if not self.job:
            raise ct.WinError(ct.get_last_error())
        limits = ExtendedLimits()
        # KILL_ON_JOB_CLOSE and ACTIVE_PROCESS=1. No hard memory/CPU limit.
        limits.basic.flags = 0x2000 | 0x8
        limits.basic.active_processes = 1
        if not self.k.SetInformationJobObject(self.job, 9, ct.byref(limits), ct.sizeof(limits)):
            error = ct.get_last_error()
            self.close()
            raise ct.WinError(error)

    def assign(self, process):
        if not self.k.AssignProcessToJobObject(self.job, int(process._handle)):
            raise ct.WinError(ct.get_last_error())

    def cpu(self, process):
        created, exited, kernel, user = (wt.FILETIME() for _ in range(4))
        if not self.k.GetProcessTimes(int(process._handle), ct.byref(created), ct.byref(exited),
                                     ct.byref(kernel), ct.byref(user)):
            raise ct.WinError(ct.get_last_error())
        ticks = lambda f: (int(f.dwHighDateTime) << 32) | int(f.dwLowDateTime)
        return {'cpu_user_seconds': ticks(user)/10**7,
                'cpu_kernel_seconds': ticks(kernel)/10**7,
                'cpu_total_seconds': (ticks(user)+ticks(kernel))/10**7}

    def sample(self, process):
        memory = ProcessMemory()
        memory.cb = ct.sizeof(memory)
        if not self.p.GetProcessMemoryInfo(int(process._handle), ct.byref(memory), memory.cb):
            raise ct.WinError(ct.get_last_error())
        return dict(self.cpu(process), private_bytes=int(memory.private),
                    working_set_bytes=int(memory.working_set),
                    os_peak_working_set_bytes=int(memory.peak_working_set),
                    os_peak_pagefile_bytes=int(memory.peak_pagefile),
                    page_fault_count=int(memory.page_faults))

    def terminate(self):
        if not self.k.TerminateJobObject(self.job, 124):
            raise ct.WinError(ct.get_last_error())

    def close(self):
        if self.job:
            self.k.CloseHandle(self.job)
            self.job = None


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', action='store_true', help='explicitly authorize this diagnostic launch')
    args = parser.parse_args()
    if not args.run:
        parser.error('No launch without --run; this file is submitted for review, not auto-execution.')
    if os.name != 'nt':
        parser.error('Windows-only monitor; no unmonitored fallback.')

    # The parent may already exist, but each attempt and every written file is new.
    if QUARANTINE.exists() and QUARANTINE.resolve() != QUARANTINE.absolute():
        raise RuntimeError('Quarantine parent is redirected; refusing writes.')
    QUARANTINE.mkdir(exist_ok=True)
    generation = QUARANTINE / (datetime.now(timezone.utc).strftime('%m%dT%H%M%S_') + uuid.uuid4().hex[:8])
    generation.mkdir(exist_ok=False)
    artifacts = generation / 'artifacts'
    artifacts.mkdir(exist_ok=False)
    output = artifacts.joinpath(*MODULE.split('.')).with_suffix('.olean')
    output.parent.mkdir(parents=True, exist_ok=False)
    options = ['-t0', '-j', '1', '-M4096', '-DautoImplicit=false', '-R', str(SOURCE_ROOT)]
    command = [str(LEAN), *options, '-o', str(output), str(SOURCE)]
    started = time.monotonic()
    result = {'kind': 'diagnostic_original_qrh_leaf_only', 'module': MODULE,
              'provider_validated': False, 'reusable_accepted_artifact': False,
              'publication': 'none; all outputs stay quarantined',
              'command': command, 'cwd': str(SOURCE_ROOT), 'options': options,
              'options_sha256': hashlib.sha256(encode(options)).hexdigest(),
              'python_version': sys.version, 'python_executable': sys.executable,
              'started_utc': utc(), 'status': 'preflight_failed',
              'limits': {'lean_workers': 1, 'job_active_processes': 1, 'lean_memory_megabytes': 4096,
                         'observed_private_bytes': PRIVATE_BYTES, 'process_wall_seconds': WALL_SECONDS,
                         'sample_interval_seconds': SAMPLE_SECONDS,
                         'hard_memory_cap': False},
              'dependencies_rehashed': False, 'axiom_audit_performed': False}
    process = None
    monitor = None
    launched = None
    samples = 0
    peak_private = peak_ws = peak_pagefile = 0
    try:
        expected = {SOURCE: SOURCE_PIN, LEAN: COMPILER_PIN,
                    SOURCE_ROOT/'lakefile.lean': LAKEFILE_PIN,
                    SOURCE_ROOT/'lake-manifest.json': MANIFEST_PIN}
        result['expected_input_hashes'] = {str(path): pin for path, pin in expected.items()}
        initial_hashes = {str(path): sha(path) for path in expected}
        result['input_hashes_before'] = initial_hashes
        for path, pin in expected.items():
            if initial_hashes[str(path)] != pin:
                raise RuntimeError('Pinned input changed: ' + str(path))
        graph_path = ROOT/'work/qrh-campaign/agents/integration/qrh-import-graph.json'
        graph = json.loads(graph_path.read_text(encoding='utf-8-sig'))
        if graph.get(MODULE) != []:
            raise RuntimeError('Saved first leaf no longer has an empty custom dependency list.')
        result['saved_import_graph_sha256'] = sha(graph_path)
        package_roots = [PACKAGES/'mathlib'] + sorted(
            (p for p in PACKAGES.iterdir() if p.is_dir() and p.name != 'mathlib'),
            key=lambda p: p.name.lower())
        package_paths = [p/'.lake/build/lib/lean' for p in package_roots]
        if not (package_paths[0]/'Mathlib.olean').is_file():
            raise RuntimeError('Missing prebuilt Mathlib.olean; no dependency build is permitted.')
        package_paths = [p for p in package_paths if p.is_dir()]
        result['prebuilt_package_metadata'] = {
            str(p): {str(f.relative_to(p)): sha(f)
                     for f in [p/'lean-toolchain', p/'lake-manifest.json'] if f.is_file()}
            for p in package_roots}
        environment = dict(os.environ)
        environment['LEAN_PATH'] = ';'.join(map(str, [artifacts, *package_paths]))
        # Remove inherited compiler-specific overrides; record these exact removals.
        removed = [key for key in ('LEAN_SYSROOT', 'LEAN_OPTS', 'LEAN_OPTIONS') if key in environment]
        for key in removed:
            del environment[key]
        result.update(command=command, cwd=str(SOURCE_ROOT), options=options,
                      options_sha256=hashlib.sha256(encode(options)).hexdigest(),
                      lean_path=environment['LEAN_PATH'], removed_environment_keys=removed,
                      source_original_toolchain='leanprover/lean4:v4.34.1',
                      diagnostic_toolchain='leanprover/lean4:v4.35.0',
                      original_mathlib='d13f23b723b8a846827a245b89c10fc7d3f11612',
                      target_mathlib_recorded_pin='56a005855ea17e0b0958f73ec801ae140b0a1679',
                      driver_sha256=sha(Path(__file__)),
                      package_options_source='OAI lakefile: autoImplicit=false; no Lake evaluation')
        exclusive_json(generation/'request.json', result)
        monitor = WindowsMonitor()
        with (generation/'lean.log').open('xb') as log, (generation/'telemetry.jsonl').open('xb') as telemetry:
            launched = time.monotonic()
            result['status'] = 'launch_failed'
            process = subprocess.Popen(command, cwd=SOURCE_ROOT, env=environment,
                                       stdin=subprocess.DEVNULL, stdout=log, stderr=subprocess.STDOUT,
                                       creationflags=subprocess.CREATE_NO_WINDOW)
            result['pid'] = process.pid
            result['status'] = 'job_assignment_failed'
            monitor.assign(process)
            result['status'] = 'running'
            while process.poll() is None:
                elapsed = time.monotonic()-launched
                if elapsed >= WALL_SECONDS:
                    result['status'] = 'wall_limit_stop'
                    monitor.terminate()
                    break
                try:
                    sample = dict(monitor.sample(process), process_wall_seconds=elapsed, utc=utc())
                except OSError:
                    if process.poll() is not None:
                        break
                    raise
                telemetry.write(json.dumps(sample, sort_keys=True).encode('utf-8')+b'\n')
                telemetry.flush()
                samples += 1
                peak_private = max(peak_private, sample['private_bytes'])
                peak_ws = max(peak_ws, sample['os_peak_working_set_bytes'])
                peak_pagefile = max(peak_pagefile, sample['os_peak_pagefile_bytes'])
                if sample['private_bytes'] >= PRIVATE_BYTES:
                    result['status'] = 'observed_private_limit_stop'
                    monitor.terminate()
                    break
                time.sleep(min(SAMPLE_SECONDS, max(0, WALL_SECONDS-(time.monotonic()-launched))))
            process.wait(timeout=5)
            result['exit_code'] = process.returncode
            result.update(monitor.cpu(process))
            if result['status'] == 'running':
                result['status'] = 'diagnostic_exit_zero' if process.returncode == 0 else 'diagnostic_exit_nonzero'
    except BaseException as error:
        if isinstance(error, KeyboardInterrupt):
            result['status'] = 'operator_interrupt'
        elif result['status'] == 'running':
            result['status'] = 'monitor_or_runtime_failure'
        result['exception'] = ''.join(traceback.format_exception(type(error), error, error.__traceback__))
    finally:
        # Stop only this owned child/job. No process-name or system-wide termination.
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
            if monitor is not None:
                try:
                    result.update(monitor.cpu(process))
                except OSError as error:
                    result['final_cpu_error'] = repr(error)
                    if result['status'] == 'diagnostic_exit_zero':
                        result['status'] = 'diagnostic_measurement_incomplete'
        if monitor is not None:
            monitor.close()
        result.update(finished_utc=utc(), overall_wall_seconds=time.monotonic()-started,
                      process_wall_seconds=None if launched is None else time.monotonic()-launched,
                      sample_count=samples, observed_peak_private_bytes=peak_private,
                      observed_os_peak_working_set_bytes=peak_ws,
                      observed_os_peak_pagefile_bytes=peak_pagefile)
        try:
            result['source_sha256_after'] = sha(SOURCE)
            result['source_unchanged'] = result['source_sha256_after'] == SOURCE_PIN
            result['compiler_sha256_after'] = sha(LEAN)
            result['compiler_unchanged'] = result['compiler_sha256_after'] == COMPILER_PIN
            result['package_options_unchanged'] = sha(SOURCE_ROOT/'lakefile.lean') == LAKEFILE_PIN
            result['source_manifest_unchanged'] = sha(SOURCE_ROOT/'lake-manifest.json') == MANIFEST_PIN
            result['output_inventory'] = {
                str(p.relative_to(artifacts)): {'bytes': p.stat().st_size, 'sha256': sha(p)}
                for p in sorted(artifacts.rglob('*')) if p.is_file()}
            result['log_sha256'] = sha(generation/'lean.log') if (generation/'lean.log').exists() else None
            result['expected_primary_output_present'] = output.is_file()
            if result['status'] == 'diagnostic_exit_zero' and not (
                result['source_unchanged'] and result['compiler_unchanged'] and output.is_file()):
                result['status'] = 'diagnostic_rejected_postconditions'
            if result['status'] == 'diagnostic_exit_zero' and not (
                result['package_options_unchanged'] and result['source_manifest_unchanged']):
                result['status'] = 'diagnostic_rejected_postconditions'
        except BaseException as error:
            result['postcheck_exception'] = repr(error)
            result['status'] = 'diagnostic_postcheck_failure'
        # Written once, last; never a success/cache receipt. Failed attempts remain.
        exclusive_json(generation/'diagnostic.json', result)
        print(json.dumps({'status': result['status'], 'quarantine': str(generation),
                          'receipt': str(generation/'diagnostic.json'),
                          'accepted_artifact': False}), flush=True)
    return 0 if result['status'] == 'diagnostic_exit_zero' else 1


if __name__ == '__main__':
    raise SystemExit(main())
