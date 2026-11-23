from pathlib import Path
import hashlib
import json
import re
import statistics
import sys

home = Path(__file__).resolve().parent
mode = sys.argv[1] if len(sys.argv) > 1 else 'profile'
assert mode in ['profile', 'constructed']
prefix, marker, theory = {
    'profile': ('profile_validated', 'HOL4_PROFILE_DONE', 'StageProfileResults'),
    'constructed': ('constructed_run', 'HOL4_CONSTRUCTED_BENCHMARK_DONE',
                    'StageConstructedResults')}[mode]
log = (home / (prefix + '.log')).read_text()
time = (home / (prefix + '.time')).read_text()
assert marker in log
assert re.search(r'Exit status:\s+0\s*$', time)
assert not re.search(r'error in |Uncaught exception|FAIL<', log + time)
axioms = re.search(r'HOL4_CONTEXT_AXIOMS,(.*)', log)[1].split(';')
assert set(axioms) == {'bool.ETA_AX', 'bool.SELECT_AX', 'bool.INFINITY_AX',
                       'bool.BOOL_CASES_AX'}
times = {label: {'cpu_seconds': float(cpu), 'wall_seconds': float(wall)}
         for label, cpu, wall in re.findall(
             r'HOL4_TIME,([^,\n]+),([0-9.]+),([0-9.]+)', log)}
tags = re.findall(r'HOL4_TAG,([^,\n]+),oracles=([^,\n]*),axioms=([^\n]*)', log)
assert tags
assert all(oracles == 'DISK_THM' and not axioms for _, oracles, axioms in tags)
result = {'passed': True, 'mode': mode, 'context_axioms': axioms,
          'timings': times, 'tag_checks': tags}
if mode == 'constructed':
    result['case_cpu_medians'] = {}
    for case in ['P100N64', 'P343N64', 'P415N64', 'P343N256']:
        result['case_cpu_medians'][case] = statistics.median(
            times[f'{case}_r{rep}']['cpu_seconds'] for rep in range(3))
        assert f'Saved theorem _______ "certified_{case}"' in log
    for control in ['rounding', 'missing', 'reordered', 'coefficient']:
        assert 'HOL4_REJECTED_' + control in log
else:
    result['raw_kernel_cpu_median'] = statistics.median(
        times[f'raw_kernel_r{rep}']['cpu_seconds'] for rep in range(3))
    result['prepared_integer_cpu_median'] = statistics.median(
        times[f'prepared_eval_r{rep}']['cpu_seconds'] for rep in range(3))
def number(label):
    return float(re.search(re.escape(label) + r':\s+([0-9.]+)', time)[1])
result['whole_process'] = {'cpu_seconds': number('User time (seconds)') +
    number('System time (seconds)'),
    'elapsed_as_reported': re.search(r'Elapsed \(wall clock\) time .*:\s+(.+)', time)[1],
    'peak_rss_kib': number('Maximum resident set size (kbytes)')}
files = [home / (prefix + suffix) for suffix in ['.log', '.time']]
files += [home / '.hol/objs' / (theory + 'Theory' + suffix)
          for suffix in ['.dat', '.sig', '.sml']]
files += [home / (mode + '.sml'), home / 'StageCheckScript.sml',
          home / 'BlockRoundScript.sml', home / 'source.json']
result['artifacts'] = {str(p.relative_to(home)): {'bytes': p.stat().st_size,
    'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in files}
(home / (mode.upper() + '_RESULTS.json')).write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps({key: value for key, value in result.items()
                  if key not in ['timings', 'artifacts', 'tag_checks']}, indent=2))
