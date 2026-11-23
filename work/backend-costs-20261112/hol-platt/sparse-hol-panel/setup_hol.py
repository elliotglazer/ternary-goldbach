from pathlib import Path
import json,sys
from fractions import Fraction as F
out=Path(__file__).resolve().parent/sys.argv[1]
base=out.parent.parent
src=base/"sparse-head"
d=base/"sparse-full-panel"/out.name
def wr(n,s): (out/n).write_bytes(s.encode())
spec=json.loads((d/"spectrum.json").read_text())
main,last,n,j,theta,labels=[spec[k] for k in ("main","final","N","J","theta","labels")]
rad=json.loads((out/"inputs.json").read_text())["coarse_radius"]
s=(src/"SparseHeadScript.sml").read_text().replace("85121",str(last+257)).replace("519575974158994",str(rad)).replace("344981504",str(main*4096)).replace("347602944",str(last*4096))
# Instantiate the radius formula using the selected FFT, Gaussian bound and tilt.
a=(base/"full-height-count/KernelWeightsScript.sml").read_text()
a=a[a.index("Definition radius_ok_def:"):a.index("val ins=")].replace("radius_ok","panel_radius").replace("524288",str(n)).replace("68267",str(j)).replace("1250000",str(80000000//theta)).replace("3**64","3**"+str(theta))
grid=(base/"grid-sign-join/GridSignsScript.sml").read_text()
b=grid[grid.index("Definition valid_kernels_def:"):grid.index("Definition coarse_radius_ok_def:")]
b=b[:b.index("End")+3].replace("valid_kernels","panel_valid").replace("KernelWeights$radius_ok","panel_radius")+"\n"
s=s.replace("Definition observation_def:",a+b+"\nDefinition observation_def:").replace("GridSigns$valid_kernels","panel_valid").replace("GridSigns$coarse_radius_ok rad",f"(2*(512*4*3**{theta}*2**80)+5*{n}*2**220 <= rad*(512*4*3**{theta}*2**80))")
wr("SparseHeadScript.sml",s)
table=r"""Theory PanelTables
Ancestors SparseHead JoinTables
Libs meter cv_transLib intLib
open meter;
val ins=TextIO.openIn "kernels.txt";
fun line()=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
fun tuple [v]=v | tuple(v::vs)=pairSyntax.mk_pair(v,tuple vs) | tuple []=raise Fail "tuple";
fun reading i =
 let val [k,r,o1,d,e]=line()
     val w=listSyntax.mk_list(map integer(line()),“:int”)
     val kd=new_definition("w_"^k^"_def",mk_eq(mk_var("w_"^k,type_of w),w))
     val term=list_mk_comb(“KernelWeights$kernel_ok”,[nat r,nat o1,integer d,w])
     val t=cv_transLib.cv_eval term
     val cert=EQT_ELIM(TRANS(AP_TERM(rator term)kd)t)
     val er=EQT_ELIM(cv_transLib.cv_eval(list_mk_comb(“SparseHead$panel_radius”,[nat r,nat e])))
     val args=map nat[r,o1,d,e]
 in (tuple(args@[lhs(concl kd)]),tuple(args@[w]),kd,cert,er) end;
""".replace("“",chr(96)*2).replace("”",chr(96)*2)
join=(base/"grid-sign-join/JoinTablesScript.sml").read_text()
table+=join[join.index("val rows="):].replace("GridSigns$valid_kernels","SparseHead$panel_valid").replace("GridSignsTheory.valid_kernels_def","SparseHeadTheory.panel_valid_def")
wr("PanelTablesScript.sml",table)
kt=(d/"stencils.txt").read_text().splitlines()
wr("kernels.txt","\n".join(kt[:1+int(kt[0])*2])+"\n")
obs=(src/"headobserve.sml").read_text().replace(" JoinTablesTheory;"," PanelTablesTheory;")
wr("headobserve.sml",obs)
counts=json.loads((d/"counts.json").read_text())
for typ,left,right in [("Even",*labels[:2]),("Odd",*labels[2:])]:
    th=f'HeadPair{typ}'
    wr(th+"Script.sml",f'Theory {th}\nAncestors SparseHead PanelTables\nLibs headobserve\nval _=headobserve.certify "{typ.lower()}" "{left}" "{right}";\n')
    phase=F(counts["counts"][str((left,right))]["fixed"][-1]["phase_upper"])*2**32
    assert phase.denominator==1
    wr("pair-"+typ.lower()+".txt",f"640 {phase.numerator} 18\n")
wr("Holmakefile",(src/"Holmakefile").read_text().replace(" ../"," ../../"))
sh=(src/"run.sh").read_text().replace("SparseHead|HeadPair","PanelTables|SparseHead|HeadPair").replace("cd ../../../.. ","cd ../../../../.. ").replace("cd ../../hol4","cd ../../../hol4").replace(" ../grid-"," ../../grid-")
wr("run.sh",sh)

