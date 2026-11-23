from pathlib import Path
p=Path(__file__).resolve().parent
base=(p/'generate_mesh.py').read_text()
for i in range(4):
    src=base.replace('start=102396199792;step=128;m=64',f'start={102396199792+i*128*128};step=128;m=128')
    src=src.replace("p/'mesh.json'","p/'mesh-chunk"+str(i)+".json'").replace("p/'meshbench.sml'","p/'mesh-generated"+str(i)+".txt'").replace('for n in [8,32,64]','for n in [128]').replace('arb(7)/10**13','arb(2)/10**12')
    exec(compile(src,'each-segment','exec'),{'__file__':__file__})
import json
d=[json.loads((p/f'mesh-chunk{i}.json').read_text()) for i in range(4)]
orig=json.loads((p/'mesh-large.json').read_text())
assert [s for c in d for s in c['signs']]==orig['signs']
lines=['open HolKernel Parse boolLib bossLib cv_transLib RSKernelTheory RSBatchTheory;',(p/'bench.template').read_text()]
lines.append('fun integer s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x)s));\nfun tup[a,b,c]=pairSyntax.mk_pair(integer a,pairSyntax.mk_pair(integer b,integer c))|tup _=raise Fail "triple";')
lines.append('fun chunk name fields = let val io=TextIO.openIn(name^".tsv") val raw=TextIO.inputAll io val _=TextIO.closeIn io val rows=map(tup o String.tokens Char.isSpace)(String.tokens(fn c=>c= #"\\n")raw) val tm=list_mk_comb(``mesh_run``,map integer fields@[listSyntax.mk_list(rows,type_of(hd rows))]) in measure name tm end;')
pi=json.loads((p/'inputs.json').read_text())[0][2]
for i,c in enumerate(d):
    (p/f'chunk{i}.tsv').write_text(''.join(' '.join(map(str,r))+'\n' for r in c['rows']))
    lines.append(f'val _=chunk "chunk{i}" ["{c["start"]}","{c["rows"][0][0]}","{pi}","128"];')
(p/'meshchunks.sml').write_text('\n'.join(lines)+'\nval _=print "RS_DONE\\n";\n')
