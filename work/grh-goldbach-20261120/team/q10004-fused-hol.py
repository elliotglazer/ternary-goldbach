"""Generate a single fresh first-pass replay from raw and compressed witness files."""
from pathlib import Path
hol=Path(__file__).resolve().parent/'q10004-gaussian/hol'
raw=(hol/'Q10004AllScript.sml').read_text()
comp=(hol/'Q10004CompressedScript.sml').read_text()
proj=(hol/'Q10004ProjectScript.sml').read_text()
f=comp.replace('Theory Q10004Compressed','Theory Q10004Fused').replace('Ancestors Q10004All','Ancestors Q10004Window')
helpers=raw[raw.index('Definition cut_def:'):raw.index('Definition slice_def:')]+raw[raw.index('Definition weights_for_def:'):raw.index('Definition all_jobs_def:')]
f=f.replace('Definition digits_def:',helpers+'Definition digits_def:')
pr=proj[proj.index('Definition within_def:'):proj.index('val _=cv_auto_trans projects_def;')]
f=f.replace('val _=cv_auto_trans compact_jobs_def;',pr+'''
Definition accepted_def:
  accepted radi err raw witnesses ks runs js <=>
    projects raw witnesses /\ compact_jobs radi err witnesses ks runs js
End
val _=cv_auto_trans accepted_def;
''')
f=f.replace('val _=endfile ins\n','''val _=endfile ins
     val original=TextIO.openIn ("all-"^label^".txt")
     val header=line original
     val _=if header=[actual,r,e,spanCount,jobCount] then () else raise Fail "original header"
     val originals=rows(count spanCount)original
     val rawJobs=rows(count jobCount)original
     val _=if rawJobs=jobs then () else raise Fail "job source"
     val _=endfile original
''')
f=f.replace('val st=listSyntax','val originalTerm=table originals\n     val st=listSyntax')
f=f.replace('val sf=named','val rf=named ("source_raw_"^label) originalTerm\n     val sf=named')
f=f.replace('val paired=[sf,kernels,pf,jf]','val paired=[rf,sf,kernels,pf,jf]')
f=f.replace('Q10004Compressed$compact_jobs','Q10004Fused$accepted').replace('compressed_repair_bits_', 'fused_repair_bits_')
(hol/'Q10004FusedScript.sml').write_text(f)
s=(hol/'compressed.sh').read_text().replace('Q10004Compressed','Q10004Fused').replace('compressed-inputs','fused-inputs').replace('compressed.time','fused.time').replace('compressed.log','fused.log').replace('compressed-export','fused-export').replace('sha256sum compressed-*.txt','sha256sum all-*.txt compressed-*.txt')
(hol/'fused.sh').write_bytes(s.encode())
