from pathlib import Path
import hashlib, json, re, shutil

p = Path(__file__).resolve().parent
parent = p.parent / 'source-log-horner'
def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()
review = json.loads((parent / 'review_result.json').read_text(encoding='utf-8'))
for name, expected in review['hashes'].items():
    assert digest(parent / name) == expected, name
source = (p / 'SourceLogRangeScript.sml').read_text(encoding='utf-8')
roots = re.findall(r'Theorem\s+(\w+):\s*\n(.*?)\nProof\n', source, re.S)
assert len(roots) == 11, len(roots)
old = (parent / 'horner_audit.sml').read_text(encoding='utf-8')
header = old.split('val program_types = [')[0].replace('SourceLogHorner', 'SourceLogRange').replace('SOURCE_LOG_HORNER', 'SOURCE_LOG_RANGE')
type_text = '''val program_types = [
 ("source_raw_log129",type_of ``source_raw_log129``,``:num -> num -> int``),
 ("source_log_from_two",type_of ``source_log_from_two``,``:num -> num -> num -> int -> num -> num -> num -> int``),
 ("slr_numerator",type_of ``slr_numerator``,``:num -> num -> num -> num -> int``),
 ("slr_error_bound",type_of ``slr_error_bound``,``:num -> real``)
];
val _ = List.app (fn (name,actual,expected) =>
  (require (actual = expected) (name ^ ": wrong program type");
   print ("SOURCE_LOG_RANGE_TYPE," ^ name ^ "," ^ type_to_string actual ^ "\\n"))) program_types;
'''
footer = old[old.index('val _ = List.app (fn (name,th,expected)'):].replace('SOURCE_LOG_HORNER','SOURCE_LOG_RANGE')
audit = header + type_text + 'val roots = [\n' + ',\n'.join(' ("'+n+'",'+n+',\n  ``'+s.strip()+'``)' for n,s in roots) + '\n];\n' + footer
(p / 'range_audit.sml').write_text(audit, encoding='utf-8', newline='\n')
(p / 'Holmakefile').write_text('PRE_INCLUDES = ../raw-pair-round-proof ../source-log-real ../source-log-horner\nINCLUDES = ../source-producer ../raw-analytic/dependency-build-win01 ../../hol4-setup\nall: SourceLogRangeTheory.uo\n', encoding='utf-8', newline='\n')
runner = (parent / 'run_horner.sh').read_text(encoding='utf-8')
runner = runner.replace('SourceLogHorner','SourceLogRange').replace('horner_audit','range_audit').replace('run_horner','run_range').replace('SOURCE_LOG_HORNER','SOURCE_LOG_RANGE')
runner = runner.replace('test "$(grep -c \'^SOURCE_LOG_RANGE_TYPE,\' "${label}_audit.log")" -eq 3','test "$(grep -c \'^SOURCE_LOG_RANGE_TYPE,\' "${label}_audit.log")" -eq 4')
runner = runner.replace('-eq 13','-eq 11')
runner = runner.replace('sha256sum ../source-producer/', 'sha256sum ../source-log-horner/.hol/objs/SourceLogHornerTheory.uo ../source-log-horner/.hol/objs/SourceLogHornerTheory.dat \\\n ../source-producer/',1)
(p / 'run_range.sh').write_text(runner, encoding='utf-8', newline='\n')
launcher = (parent / 'run_horner_container.ps1').read_text(encoding='utf-8').replace('source-log-horner','source-log-range').replace('run_horner','run_range')
extra = '''$hornerMetadataLocal = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot 'horner-make-deps')).Path
$hornerMetadataLinux = "$linuxWorkspace/work/backend-costs-20261112/hol-platt/source-log-horner/.hol/make-deps"
$metadataMount += @('--mount', "type=bind,source=$hornerMetadataLocal,target=$hornerMetadataLinux")
'''
launcher = launcher.replace('$imageIndex =',extra+'$imageIndex =',1)
(p / 'run_range_container.ps1').write_text(launcher, encoding='utf-8', newline='\n')
for name in ('library','helper','source','tail'):
    shutil.copytree(parent / (name+'-make-deps'), p / (name+'-make-deps'), dirs_exist_ok=True)
shutil.copytree(parent / '.hol/make-deps', p / 'horner-make-deps', dirs_exist_ok=True)
pins = ['SourceLogRangeScript.sml','range_audit.sml','Holmakefile','run_range.sh','run_range_container.ps1']
for folder, thy, auditname in [('source-producer','SourceArithmetic','source_audit.sml'),('source-log-real','SourceLogTail','log_tail_audit.sml'),('source-log-horner','SourceLogHorner','horner_audit.sml'),('raw-pair-round-proof','RawPairRound','../raw-pair-round-audit/raw_pair_round_audit.sml')]:
    paths = [f'../{folder}/{thy}Script.sml',f'../{folder}/{auditname}',f'../{folder}/.hol/objs/{thy}Theory.uo',f'../{folder}/.hol/objs/{thy}Theory.dat']
    pins.extend(paths)
for name in pins:
    assert (p / name).is_file(), name
(p / 'source_expected.sha256').write_text(''.join(digest(p/name)+'  '+name+'\n' for name in pins),encoding='utf-8',newline='\n')
archive=p / 'history/range01'
archive.mkdir(parents=True, exist_ok=False)
for name in pins[:5]+['source_expected.sha256']:
    shutil.copy2(p/name, archive/name)
print(json.dumps({'roots':[n for n,s in roots], 'expected_sources':len(pins), 'parent_run':review['accepted_run']}))
