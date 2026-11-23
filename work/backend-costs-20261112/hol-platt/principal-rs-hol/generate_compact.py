from pathlib import Path
import json
p=Path(__file__).resolve().parent
d=json.loads((p/'mesh-large.json').read_text()); rows=d['rows']
(p/'compact-input.tsv').write_text(''.join(' '.join(map(str,r))+'\n' for r in rows))
base=(p/'bench.template').read_text().replace('cv_transLib RSKernelTheory','cv_transLib RSKernelTheory RSBatchTheory')
src=r"""
fun integer s=intSyntax.term_of_int (Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x)s));
fun tup [a,b,c]=pairSyntax.mk_pair(integer a,pairSyntax.mk_pair(integer b,integer c))
 | tup _=raise Fail "triple";
val start=Timer.startCPUTimer();
val inp=TextIO.openIn "compact-input.tsv";
val raw=TextIO.inputAll inp;
val _=TextIO.closeIn inp;
val rows=map (tup o String.tokens Char.isSpace) (String.tokens(fn c=>c= #"\n")raw);
val fields=map integer ["START","THETA","PI","128"];
fun term rs=list_mk_comb(``mesh_run``,fields@[listSyntax.mk_list(rs,type_of(hd rs))]);
val t512=term rows;
val _=print("CONSTRUCT_CPU="^Time.toString(#usr(Timer.checkCPUTimer start))^"\n");
val _=measure "mesh512" t512;
val bad=List.take(rows,511)@[tup ["BH","BJ","BZ"]];
val _=measure "wrong512" (boolSyntax.mk_neg(term bad));
val _=print "RS_DONE\n";
"""
sc=json.loads((p/'inputs.json').read_text())[0]
for k,v in [('START',sc[0]),('THETA',sc[1]),('PI',sc[2]),('BH',rows[-1][0]),('BJ',rows[-1][1]),('BZ',rows[-1][2]+1)]:src=src.replace('"'+k+'"','"'+str(v)+'"')
(p/'meshcompact.sml').write_text(base+src)
