"""One outer execution of the frozen benign capability preflight; no mathematics."""
import hashlib
import json
from pathlib import Path
import subprocess
import time

HERE = Path(__file__).resolve().parent
EXE = Path('C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe')
MANIFEST = HERE / 'coordinator_c8_capability_authorization_20261111_01.json'
SUPERVISOR = HERE / 'c8_supervisor_capability_preflight_20261111_v2.py'
PREFIX = 'coordinator_c8_capability_20261111_01'


def digest(data):
    return hashlib.sha256(data).hexdigest().upper()


def main():
    manifest_raw = MANIFEST.read_bytes()
    manifest = json.loads(manifest_raw)
    assert manifest['authorize'] == 'RUN_ONE_C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V2'
    assert digest(SUPERVISOR.read_bytes()) == manifest['pins']['supervisor']
    assert digest(EXE.read_bytes()) == manifest['pins']['executable']
    attempt = HERE / manifest['attempt_name']
    assert not attempt.exists(), 'Attempt already exists; no retry'
    stdout_path = HERE / (PREFIX + '.stdout')
    stderr_path = HERE / (PREFIX + '.stderr')
    record_path = HERE / (PREFIX + '.json')
    marker_path = HERE / (PREFIX + '.started')
    assert not any(p.exists() for p in (stdout_path, stderr_path, record_path, marker_path))
    with marker_path.open('xb') as out:
        out.write((digest(manifest_raw) + '\n').encode())
    timed_out = False
    start = time.monotonic_ns()
    process = subprocess.Popen(
        [str(EXE), '-I', '-S', str(SUPERVISOR), '--manifest', str(MANIFEST)],
        cwd=str(HERE), stdin=subprocess.DEVNULL, stdout=subprocess.PIPE,
        stderr=subprocess.PIPE, creationflags=subprocess.CREATE_NO_WINDOW,
    )
    try:
        remaining = max(0, 30 - (time.monotonic_ns() - start) / 1e9)
        stdout, stderr = process.communicate(timeout=remaining)
    except subprocess.TimeoutExpired:
        timed_out = True
        process.kill()
        # Closing the supervisor's job handles kills any of its remaining child.
        stdout, stderr = process.communicate(timeout=3)
    end = time.monotonic_ns()
    for path, data in ((stdout_path, stdout), (stderr_path, stderr)):
        with path.open('xb') as out:
            out.write(data)
    record = dict(
        schema='coordinator-c8-capability-v1', status='INCOMPLETE',
        manifest_sha256=digest(manifest_raw), runner_sha256=digest(Path(__file__).read_bytes()),
        start_monotonic_ns=start, observed_exit_monotonic_ns=end,
        elapsed_ns=end-start, pid=process.pid, returncode=process.returncode,
        timed_out=timed_out, stdout_sha256=digest(stdout), stderr_sha256=digest(stderr),
        stdout_bytes=len(stdout), stderr_bytes=len(stderr),
    )
    try:
        assert not timed_out and end-start < 30_000_000_000, 'outer deadline'
        assert process.returncode == 0 and stderr == b'', 'exit/stderr'
        assert len(stdout.splitlines()) == 1, 'one final console line required'
        console = json.loads(stdout)
        completion_path = attempt / 'completion.json'
        completion_raw = completion_path.read_bytes()
        completion = json.loads(completion_raw)
        assert console['status'] == completion['status'] == 'PASS', 'fixture status'
        assert console['receipt_sha256'] == digest(completion_raw), 'receipt hash'
        assert console['manifest_sha256'] == completion['manifest_sha256'] == digest(manifest_raw)
        for key in ('supervisor', 'child'):
            assert console[key+'_sha256'] == manifest['pins'][key]
        assert console['elapsed_ns'] < 30_000_000_000
        assert len(console['conservative_peak_sums']) == 2
        assert all(0 < n <= 268435456 for n in console['conservative_peak_sums'])
        files = list(attempt.iterdir())
        assert all(p.is_file() and not p.is_symlink() for p in files)
        known_bytes = len(manifest_raw) + sum(p.stat().st_size for p in files)
        assert known_bytes == console['aggregate_disk_bytes']
        # Include this outer record, logs and marker, plus a reserve for the
        # bounded tool-visible final summary. Source files are dependencies.
        retained = known_bytes + len(stdout) + len(stderr) + marker_path.stat().st_size
        record.update(status='PASS', console=console, completion_sha256=digest(completion_raw),
                      retained_bytes_before_record=retained, tool_summary_reserve_bytes=65536)
    except Exception as exc:
        record['error'] = type(exc).__name__ + ': ' + str(exc)
    raw = (json.dumps(record, sort_keys=True, indent=2) + '\n').encode()
    if record['status'] == 'PASS':
        assert record['retained_bytes_before_record'] + len(raw) + 65536 <= 4194304
    with record_path.open('xb') as out:
        out.write(raw)
    print(json.dumps(dict(status=record['status'], elapsed_ns=end-start,
                          returncode=process.returncode, record=str(record_path),
                          record_sha256=digest(raw))))
    return 0 if record['status'] == 'PASS' else 1


if __name__ == '__main__':
    raise SystemExit(main())
