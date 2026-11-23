from pathlib import Path
import hashlib, json, re, shutil
p=Path(__file__).resolve().parent
template=p.parent/'source-log-horner'
def digest(path): return hashlib.sha256(path.read_bytes()).hexdigest()
for folder in ('source-log-range',):
    parent=p.parent/folder
    review=json.loads((parent/'review_result.json').read_text(encoding='utf-8-sig'))
    for name,h in review['hashes'].items(): assert digest(parent/name)==h,(folder,name)
state=p.parent/'source-state-error'
state_pins=re.findall(r'^- (.*): ([0-9a-f]{64})$',(state/'RESULT_REVIEW.md').read_text(encoding='utf-8-sig'),re.M)
assert len(state_pins)==6,state_pins
for name,h in state_pins: assert digest(state/name)==h,name
assert json.loads((state/'stateint01_container_exit.json').read_text(encoding='utf-8-sig'))['exitCode']==0
source=(p/'SourceExpHornerScript.sml').read_text(encoding='utf-8').replace('*&','* &')
(p/'SourceExpHornerScript.sml').write_text(source,encoding='utf-8',newline='\n')
roots=re.findall(r'Theorem\s+(\w+):\s*\n(.*?)\nProof\n',source,re.S)
assert len(roots)==12,len(roots)
old=(template/'horner_audit.sml').read_text(encoding='utf-8')
header=old.split('val program_types = [')[0].replace('SourceLogHorner','SourceExpHorner').replace('SOURCE_LOG_HORNER','SOURCE_EXP_HORNER')
type_text='''val program_types = [
 ("source_exp_horner",type_of ``source_exp_horner``,``:num -> int -> num -> num -> num -> int # int``),
 ("source_exp_step",type_of ``source_exp_step``,``:num -> int -> num -> num -> (int # int) -> int # int``),
 ("seh_affine",type_of ``seh_affine``,``:real -> real -> complex -> complex``),
 ("seh_ideal",type_of ``seh_ideal``,``:real -> num -> num -> complex``),
 ("seh_bound",type_of ``seh_bound``,``:num -> real``)
];
val _ = List.app (fn (name,actual,expected) =>
  (require (actual = expected) (name ^ ": wrong program type");
   print ("SOURCE_EXP_HORNER_TYPE," ^ name ^ "," ^ type_to_string actual ^ "\\n"))) program_types;
'''
footer=old[old.index('val _ = List.app (fn (name,th,expected)'):].replace('SOURCE_LOG_HORNER','SOURCE_EXP_HORNER')
audit=header+type_text+'val roots = [\n'+',\n'.join(' ("'+n+'",'+n+',\n  ``'+s.strip()+'``)' for n,s in roots)+'\n];\n'+footer
(p/'exp_horner_audit.sml').write_text(audit,encoding='utf-8',newline='\n')
(p/'Holmakefile').write_text('PRE_INCLUDES = ../raw-pair-round-proof ../source-state-error\nINCLUDES = ../source-producer ../raw-analytic/dependency-build-win01 ../../hol4-setup\nall: SourceExpHornerTheory.uo\n',encoding='utf-8',newline='\n')
runner=(template/'run_horner.sh').read_text(encoding='utf-8').replace('SourceLogHorner','SourceExpHorner').replace('horner_audit','exp_horner_audit').replace('run_horner','run_exp_horner').replace('SOURCE_LOG_HORNER','SOURCE_EXP_HORNER')
runner=runner.replace('../source-log-real/.hol/objs/SourceLogTail','../source-state-error/.hol/objs/SourceStateError').replace('-eq 3','-eq 5').replace('-eq 13','-eq 12')
(p/'run_exp_horner.sh').write_text(runner,encoding='utf-8',newline='\n')
launcher=(template/'run_horner_container.ps1').read_text(encoding='utf-8').replace('source-log-horner','source-exp-horner').replace('run_horner','run_exp_horner').replace('tailMetadata','stateMetadata').replace('tail-make-deps','state-make-deps').replace('source-log-real','source-state-error')
(p/'run_exp_horner_container.ps1').write_text(launcher,encoding='utf-8',newline='\n')
for name in ('library','helper','source'):
    shutil.copytree(template/(name+'-make-deps'),p/(name+'-make-deps'),dirs_exist_ok=True)
shutil.copytree(p.parent/'source-state-error/.hol/make-deps',p/'state-make-deps',dirs_exist_ok=True)
pins=['SourceExpHornerScript.sml','exp_horner_audit.sml','Holmakefile','run_exp_horner.sh','run_exp_horner_container.ps1']
for folder,thy,auditname in [('source-producer','SourceArithmetic','source_audit.sml'),('source-state-error','SourceStateError','state_error_audit.sml'),('raw-pair-round-proof','RawPairRound','../raw-pair-round-audit/raw_pair_round_audit.sml')]:
    pins.extend([f'../{folder}/{thy}Script.sml',f'../{folder}/{auditname}',f'../{folder}/.hol/objs/{thy}Theory.uo',f'../{folder}/.hol/objs/{thy}Theory.dat'])
for n in pins: assert (p/n).is_file(),n
(p/'source_expected.sha256').write_text(''.join(digest(p/n)+'  '+n+'\n' for n in pins),encoding='utf-8',newline='\n')
archive=p/'history/exphorner01'
archive.mkdir(parents=True,exist_ok=False)
for n in pins[:5]+['source_expected.sha256']: shutil.copy2(p/n,archive/n)
print(json.dumps({'roots':[n for n,s in roots],'expected_sources':len(pins),'parent_reviews_rechecked':True}))
