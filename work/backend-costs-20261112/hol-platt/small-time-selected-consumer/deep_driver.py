from pathlib import Path
p=Path(__file__).resolve().parent
s=(p/'batchbench.sml').read_text()
s=s[:s.index('fun integer s=')]+"""
val zero=literal "0";
fun integer s=if String.isPrefix "-" s then cvSyntax.mk_cv_pair(packed(String.extract(s,1,NONE)),zero) else packed s;
fun tuples [x]=x | tuples(x::xs)=cvSyntax.mk_cv_pair(x,tuples xs) | tuples []=raise Fail "empty tuple";
val cvbatch=prim_mk_const{Name="cv_batchhead",Thy="GenuineBatch"};
val seed=list_mk_comb(cvbatch,list_mk_comb(Vector.sub(levels,0),[zero,zero])::List.tabulate(8,fn _=>zero));
val solve=cv_computeLib.cv_compute(cv_eqs_for seed);
""" + s[s.index('fun run l k='):]
s=s.replace('val v=numSyntax.mk_numeral n','val v=cvSyntax.mk_cv_num(numSyntax.mk_numeral n)').replace('mk_comb(``treeword``,numSyntax.term_of_int k)','mk_comb(prim_mk_const{Name="cv_treeword",Thy="GenuineBatch"},cvSyntax.mk_cv_num(numSyntax.term_of_int k))')
a=s.index('val spec=');b=s.index('val _=if null(hyp th)',a)
s=s[:a]+"""val spec=List.foldr cvSyntax.mk_cv_pair zero (map (tuples o map packed) rows)
     fun evalmode mode=let val tm=list_mk_comb(cvbatch,[literal(Int.toString mode),literal(Int.toString k),spec]@args)
       val wall=Time.now() val timer=Timer.startCPUTimer() val th=solve tm val {usr,sys}=Timer.checkCPUTimer timer
       val (o1,axs)=Tag.dest_tag(tag th)
       """+s[b:]
s=s.replace('boolSyntax.T','(literal "1")').replace('mode,kern,','mode,').replace('[1,2] else [2,1]','[1,2,2,1] else [2,1,1,2]')
(p/'deepbench.sml').write_text(s)
