from pathlib import Path
import json
p=Path(__file__).resolve().parent
data=json.loads((p/'mesh.json').read_text())
rows=data['rows'];signs=data['signs']
def lit(v):return str(v) if v>=0 else '(~'+str(-v)+')'
tests=['(1000000 * ('+lit(s)+' :int) * '+lit(v)+' > &(2**128))' for (_,_,v),s in zip(rows,signs)]
f=p/'meshbench.sml';src=f.read_text();target='val _=print "RS_DONE'
src=src.replace(target,'val _=measure "signed_margins64" ``'+' /\\ '.join(tests)+'``;\n'+target)
f.write_text(src)
