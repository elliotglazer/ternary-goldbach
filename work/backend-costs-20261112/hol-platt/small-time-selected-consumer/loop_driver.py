from pathlib import Path
p=Path(__file__).parent
s=(p/'deepbench.sml').read_text().replace('GenuineBatchTheory;','GenuineBatchTheory GenuineLoopTheory;')
s=s.replace('Name="cv_batchhead",Thy="GenuineBatch"','Name="cv_repeated",Thy="GenuineLoop"').replace('List.tabulate(8,','List.tabulate(9,')
s=s.replace('fun evalmode mode=','fun evalmode (rep,mode)=').replace('cvbatch,[literal(Int.toString mode)','cvbatch,[cvSyntax.mk_cv_num(numSyntax.term_of_int rep),literal(Int.toString mode)')
s=s.replace('Int.toString k,Int.toString mode','Int.toString k,Int.toString rep,Int.toString mode')
s=s.replace('then [1,2,2,1] else [2,1,1,2]','then [(1,1),(1,2),(32,2),(32,1)] else [(32,1),(32,2),(1,2),(1,1)]')
(p/'loopbench.sml').write_text(s)
