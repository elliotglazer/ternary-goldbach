"""Require both mathematical closure and actual kernel-channel export."""
from pathlib import Path
import hashlib
import json
import re
import sys

home = Path(__file__).resolve().parent
profile = sys.argv[1] if len(sys.argv) > 1 else 'compact'
assert profile in ['compact', 'balanced', 'isolated']
timing = (home / f'reproduce_{profile}.time').read_text()
required = [
    'ENCODING_SOUND_DONE', 'ROW_EXACT_DONE', 'RESIDUAL_SOUND_DONE',
    'STAGE_EXACT_DONE', 'BOOTSTRAP_SOUND_DONE', 'INTEGER_EXPORT_DONE',
    'REJECTED_rounding', 'REJECTED_missing', 'REJECTED_reordered',
    'REJECTED_coefficient', 'CONTROLS_DONE', 'COMPACT_PROOF_DONE',
    'COMPACT_EXPORT_DONE', profile.upper() + '_REPRODUCTION_DONE',
]
if profile in ['balanced', 'isolated']:
    required.append('BALANCED_LISTS_DONE')
markers = {name: False for name in required}
errors = []
kernel_channel = False
with (home / f'reproduce_{profile}.log').open(errors='replace') as stream:
    for line in stream:
        for name in required:
            if name in line:
                markers[name] = True
        if line.startswith(('ERROR:', 'EXCEPTION:')):
            errors.append(line.rstrip())
        if '# The following is a theorem of higher-order logic' in line:
            kernel_channel = True
exit_match = re.search(r'Exit status:\s*(\d+)', timing)
exit_status = int(exit_match.group(1)) if exit_match else None
events = {label: (float(cpu), float(wall)) for label, cpu, wall in
          re.findall(r'CANDLE_TIME,([^,\r\n]+),([0-9.]+),([0-9.]+)', timing)}
intervals = {}
for prefix in ['first', 'repeat100', 'compact_conclusion', 'compact_export']:
    start, end = events.get(prefix + '_start'), events.get(prefix + '_end')
    if start is not None and end is not None:
        intervals[prefix] = {'cpu_seconds': end[0] - start[0],
                             'wall_seconds': end[1] - start[1]}
resources = {}
for name in ['User time (seconds)', 'System time (seconds)',
             'Elapsed (wall clock) time (h:mm:ss or m:ss)',
             'Maximum resident set size (kbytes)']:
    match = re.search(r'^\s*' + re.escape(name) + r':\s*(.+)$', timing, re.M)
    if match:
        resources[name] = match.group(1)
if profile == 'isolated':
    with (home / 'isolated_export.sexp').open('rb') as stream:
        kernel_channel = stream.read(100).startswith(
            b'# The following is a theorem of higher-order logic')
passed = all(markers.values()) and not errors and exit_status == 0 and kernel_channel
files = ['checker.ml', 'arithmetic_sound.ml', 'encoding_sound.ml', 'row_sound.ml',
         'residual_sound.ml', 'stage_sound.ml', 'export_integer.ml',
         'bootstrap_sound.ml', 'fixture.ml', 'controls.ml', 'compact_export.ml',
         f'reproduce_{profile}.ml', f'reproduce_{profile}.log', f'reproduce_{profile}.time']
if profile in ['balanced', 'isolated']:
    files.append('balance_lists.ml')
if profile == 'isolated':
    files.extend(['isolated_export.sexp', 'build_export.json', 'build_export.py'])
def artifact(name):
    path = home / name
    with path.open('rb') as stream:
        digest = hashlib.file_digest(stream, 'sha256').hexdigest()
    return {'bytes': path.stat().st_size, 'sha256': digest}

result = dict(passed=passed, markers=markers, errors=errors, exit_status=exit_status,
              kernel_channel_present=kernel_channel, intervals=intervals,
              kernel_output_isolated=(profile == 'isolated'),
              resources=resources,
              statement='closed integer residual theorem, numerals represented by proved balanced arithmetic expressions',
              real_coordinate_interpretation=False, root_certification=False,
              spectral_inputs=False,
              artifacts={name: artifact(name) for name in files})
(home / (profile.upper() + '_RESULTS.json')).write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps({k: v for k, v in result.items() if k != 'artifacts'}, indent=2))
raise SystemExit(0 if passed else 1)
