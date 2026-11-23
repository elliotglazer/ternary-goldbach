from pathlib import Path
p=Path(__file__).resolve().parent
s=(p/'SparseHeadScript.sml').read_text().split('Definition observation_def:')[1].split('Definition exact_observation_def:')[0]
common=r"""Theory FusedCount
Ancestors SparseHead Enclosure
Libs cv_transLib intLib
Definition raw_window_def:
 (raw_window tab j [] bits (a:int) = if bits=0 then SOME a else NONE) /\
 (raw_window tab j (w::ws) bits a =
  case sptree$lookup j tab of NONE => NONE | SOME sample =>
    let raw=bits MOD (2**256) in
    if Enclosure$encloses raw sample then
      raw_window tab (SUC j) ws (bits DIV (2**256)) (a+w*(&raw- &(2**255)))
    else NONE)
End
Definition margins_def:
 (margins tab ks fixes [] [] <=> T) /\
 (margins tab ks fixes (j::js) [] <=> F) /\
 (margins tab ks fixes [] (x::xs) <=> F) /\
 (margins tab ks fixes ((t,k)::js) (bits::xs) <=>
  (case sptree$lookup k ks of NONE => F | SOME(r,off,den,err,ws) =>
   case raw_window tab (129+t DIV 4096-r DIV 2) ws bits 0 of NONE => F | SOME v =>
    (sptree$lookup t fixes=SOME (2:num) /\ &(den*err)<v) \/
    (sptree$lookup t fixes=SOME (1:num) /\ v < -&(den*err))) /\
    margins tab ks fixes js xs)
End
Definition optionally_def:
 (optionally NONE tab ks fixes jobs <=> T) /\
 (optionally (SOME bits) tab ks fixes jobs <=> margins tab ks fixes jobs bits)
End
Definition fused_def:
"""
s=s.replace('observation kernels','fused words kernels').replace('if GridSigns$coarse_radius_ok','if optionally words tab (sptree$fromList kernels) fixes jobs /\\ GridSigns$coarse_radius_ok')
common+=s+r'''
Definition outcome_def:
 outcome words kernels data res <=> fused words kernels data = SOME res
End
val _=cv_auto_trans outcome_def;
Theorem implies_observation:
 !w ks d r. outcome w ks d r ==> SparseHead$observation ks d=SOME r
Proof
 rpt gen_tac >> PairCases_on `d` >> simp[outcome_def,fused_def,SparseHeadTheory.observation_def,LET_THM] >>
 strip_tac >> gvs[AllCaseEqs()]
QED
'''
(p/'FusedCountScript.sml').write_text(common)
for lab in (3,6667,11,9091):
    slim=[]
    for line in (p/f'windows-{lab}.txt').read_text().splitlines():
        t,k,c,r,*xs=map(int,line.split())
        bits=sum(v<<(256*i) for i,v in enumerate(xs[:r]))
        slim.append(format(bits,'x'))
    (p/f'rawpacked-{lab}.hex').write_text('\n'.join(slim)+'\n')
for suffix,on in [('Baseline','false'),('Margins','true')]:
    (p/f'Fused{suffix}Script.sml').write_text(f'Theory Fused{suffix}\nAncestors FusedCount HeadPairEven HeadPairOdd JoinTables\nLibs fusedworker\nval _=fusedworker.run {on};\n')
runner=(p/'run.sh').read_text().replace('|SparseAllRepairs) theory','|SparseAllRepairs|FusedCount|FusedBaseline|FusedMargins) theory').replace('|| test "$theory" = SparseAllRepairs; then','|| test "$theory" = SparseAllRepairs || test "${theory#Fused}" != "$theory"; then')
(p/'run.sh').write_bytes(runner.encode())


