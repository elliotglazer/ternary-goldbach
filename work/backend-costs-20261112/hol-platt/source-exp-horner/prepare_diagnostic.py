from pathlib import Path
import re, shutil, sys
p=Path(__file__).resolve().parent
label=sys.argv[1]
assert re.fullmatch('[A-Za-z0-9_]+',label)
heap='SourceExpHorner.seh_affine_distance.dumpedheap'
archive=p/'history/exphorner01'/heap
if not archive.exists(): shutil.copy2(p/heap,archive)
source=(p/'SourceExpHornerScript.sml').read_text(encoding='utf-8')
theorems=re.findall(r'Theorem\s+(\w+):\s*\n(.*?)\nProof\n(.*?)\nQED',source,re.S)
prelude='''fun checked name expected tactic =
  ((set_goal ([],expected); e tactic;
    let val th = top_thm ()
    in if null (hyp th) andalso aconv (concl th) expected
       then (print ("EXP_HORNER_DIAGNOSTIC_PASS," ^ name ^ "\\n"); th)
       else raise Fail (name ^ ": root mismatch") end)
   handle ex => (print ("EXP_HORNER_DIAGNOSTIC_FAIL," ^ name ^ "," ^ General.exnMessage ex ^ "\\n");
                 OS.Process.exit OS.Process.failure));
'''
diag=prelude+'\n'.join('val '+n+' = checked "'+n+'" ``'+term.strip()+'`` (\n'+body+'\n);' for n,term,body in theorems)+'\nval _ = print "EXP_HORNER_DIAGNOSTIC_ALL_DONE\\n";\nval _ = OS.Process.exit OS.Process.success;\n'
(p/'exp_horner_diagnostic.sml').write_text(diag,encoding='utf-8',newline='\n')
runner=(p.parent/'source-log-range/run_range_diagnostic.sh').read_text(encoding='utf-8').replace('SourceLogRange','SourceExpHorner').replace('slr_domain_bounds','seh_affine_distance').replace('range01','exphorner01').replace('range_diagnostic','exp_horner_diagnostic')
(p/'run_exp_horner_diagnostic.sh').write_text(runner,encoding='utf-8',newline='\n')
launcher=(p/'run_exp_horner_container.ps1').read_text(encoding='utf-8').replace("$runner = 'run_exp_horner.sh'","$runner = 'run_exp_horner_diagnostic.sh'")
(p/'run_diagnostic_container.ps1').write_text(launcher,encoding='utf-8',newline='\n')
print(label,'prepared',len(theorems),'fixed-root proof diagnostics')
