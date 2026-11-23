from pathlib import Path
import re, shutil, sys
p=Path(__file__).resolve().parent
label=sys.argv[1]
assert re.fullmatch('[A-Za-z0-9_]+',label)
if not (p/'history/range01/SourceLogRange.slr_domain_bounds.dumpedheap').exists():
    shutil.copy2(p/'SourceLogRange.slr_domain_bounds.dumpedheap',p/'history/range01/SourceLogRange.slr_domain_bounds.dumpedheap')
source=(p/'SourceLogRangeScript.sml').read_text(encoding='utf-8')
theorems=re.findall(r'Theorem\s+(\w+):\s*\n(.*?)\nProof\n(.*?)\nQED',source,re.S)
prelude='''fun checked name expected tactic =
  ((set_goal ([],expected); e tactic;
    let val th = top_thm ()
    in if null (hyp th) andalso aconv (concl th) expected
       then (print ("RANGE_DIAGNOSTIC_PASS," ^ name ^ "\\n"); th)
       else raise Fail (name ^ ": root mismatch") end)
   handle ex => (print ("RANGE_DIAGNOSTIC_FAIL," ^ name ^ "," ^ General.exnMessage ex ^ "\\n");
                 (print (PolyML.makestring (top_goals ()) ^ "\\n") handle _ => ());
                 OS.Process.exit OS.Process.failure));
'''
diag=prelude+'\n'.join('val '+n+' = checked "'+n+'" ``'+term.strip()+'`` (\n'+body+'\n);' for n,term,body in theorems)+'\nval _ = print "RANGE_DIAGNOSTIC_ALL_DONE\\n";\nval _ = OS.Process.exit OS.Process.success;\n'
(p/'range_diagnostic.sml').write_text(diag,encoding='utf-8',newline='\n')
runner=(p.parent/'source-log-horner/run_horner_diagnostic.sh').read_text(encoding='utf-8').replace('SourceLogHorner','SourceLogRange').replace('slh_ratio_range','slr_domain_bounds').replace('horner01','range01').replace('horner_diagnostic','range_diagnostic')
runner=runner.replace('mkdir "${label}_run"','mkdir "${label}_run"\ncp range_diagnostic.sml "${label}_run/diagnostic.sml"')
(p/'run_range_diagnostic.sh').write_text(runner,encoding='utf-8',newline='\n')
launcher=(p/'run_range_container.ps1').read_text(encoding='utf-8').replace("$runner = 'run_range.sh'","$runner = 'run_range_diagnostic.sh'")
(p/'run_diagnostic_container.ps1').write_text(launcher,encoding='utf-8',newline='\n')
print(label, 'prepared', len(theorems), 'fixed-root proof diagnostics')
