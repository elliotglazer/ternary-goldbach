from pathlib import Path
p=Path(__file__).resolve().parent
lines=(p/'retained.hex').read_text().splitlines()
fields={}
for i in range(0,len(lines),3):
    lab,ix,mask,w,e,n=map(int,lines[i].split())
    if lab!=3 or ix>2: continue
    raw=list(map(lambda v:int(v,16),lines[i+1].split()))
    heads=list(map(int,lines[i+2].split()))
    j=0
    for b in range(64):
        if mask>>b&1:
            a=(raw[j//4]>>(256*(j%4))) % 2**256
            q=(heads[j//4]>>(w*(j%4))) % 2**w-2**(w-1)
            fields[ix*64+b]=(a,q,2**e)
            j+=1
v=[fields[k] for k in range(105,153)]
t,k,r,off,den,err,sg=map(int,(p.parent/'grid-sign-join/jobs-3.txt').read_text().splitlines()[0].split())
assert (t,k,r,off,sg)==(1,0,48,1,1)
def ilit(n): return ('-' if n<0 else '')+str(abs(n))
s=r"""Theory SparseRepair
Ancestors HeadPairEven SparseHeadLink RepairPerturbation JoinTables
Libs replay intLib
Definition witness_ok_def:
 witness_ok data kernels raw ps ws <=>
   case SparseHead$load_grid (FST data) 0 sptree$LN of NONE => F | SOME tab =>
       let ks=sptree$fromList kernels in
   MEM (1:num,0:num) (FST(SND data)) /\
   sptree$lookup 0 ks=SOME(48,1,DEN,ERR,ws) /\ LENGTH ws=LENGTH ps /\
   WindowPerturbation$reads tab 105 ps /\ LIST_REL Enclosure$encloses raw ps /\
   GridSigns$at_repair tab ks 1 0=2
End
Definition raw_inputs_def: raw_inputs = RAW:num list
End
Definition head_inputs_def: head_inputs = HEAD:(int#num) list
End

val _=cv_transLib.cv_auto_trans witness_ok_def;
fun lit def = let val eq=replay.literal def fun check t=if cvSyntax.is_cv_num t andalso can numSyntax.dest_numeral(rand t) then () else if cvSyntax.is_cv_pair t then List.app check (#2(strip_comb t)) else raise Fail ("nonliteral "^term_to_string(lhs(concl def))^" "^String.substring(term_to_string t,0,40)) in check(rhs(concl eq));eq end;
val actual = replay.joined ``witness_ok`` [lit HeadPairEvenTheory.raw_3_def,
 JoinTablesTheory.tables_encoded,lit raw_inputs_def,lit head_inputs_def,
 lit StencilReceiptTheory.kernel_0_def];
val _=save_thm("actual_full_table_support",actual);
Theorem actual_raw_margin:
 &(DEN*ERR) < StencilReceipt$dot StencilReceipt$kernel_0 (MAP WindowPerturbation$raw_center raw_inputs)
Proof
 mp_tac (Q.SPECL [`THE (SparseHead$load_grid (FST HeadPairEven$raw_3) 0 sptree$LN)`,
   `sptree$fromList JoinTables$tables`,`1`,`0`,`48`,`1`,`DEN`,`ERR`,`StencilReceipt$kernel_0`,
   `head_inputs`,`raw_inputs`] RepairPerturbationTheory.repair_raw_margin) >>
 mp_tac actual >> Cases_on `SparseHead$load_grid (FST HeadPairEven$raw_3) 0 sptree$LN` >> simp[witness_ok_def, LET_THM,KernelWeightsTheory.kernel_0_lagrange]
QED
"""
s=s.replace('DEN',str(den)).replace('ERR',str(err)).replace('RAW','['+';'.join(str(a) for a,q,u in v)+']').replace('HEAD','['+';'.join(f'({ilit(q)},{u})' for a,q,u in v)+']')
s=s.replace('witness_ok data kernels raw ps ws','witness_ok (data:((num#num#num#num)list # (num#num)list # num # (num#num)list # num # (num#num)list # num # num)) kernels raw ps ws')
(p/'SparseRepairScript.sml').write_text(s)
hf=(p/'Holmakefile').read_text()
if '../stencil-perturbation' not in hf: (p/'Holmakefile').write_text(hf.strip()+' ../stencil-perturbation ../raw-analytic/dependency-build-win01\n')
run=(p/'run.sh').read_text().replace('|SparseHeadLink) theory','|SparseHeadLink|SparseRepair) theory')
run=run.replace('if test "$theory" = SparseHeadLink; then','if test "$theory" = SparseHeadLink || test "$theory" = SparseRepair; then')
run=run.replace('test ! -e "$label.log"','''if test "$theory" = SparseRepair; then
  for d in ../stencil-perturbation ../raw-analytic/dependency-build-win01; do
    mkdir -p "$here/metadata/$(basename "$d")"
    cp -a "$d/.hol/make-deps/." "$here/metadata/$(basename "$d")/"
    mount --bind "$here/metadata/$(basename "$d")" "$d/.hol/make-deps"
  done
fi
test ! -e "$label.log"''') if 'for d in ../stencil' not in run else run
(p/'run.sh').write_bytes(run.encode())





