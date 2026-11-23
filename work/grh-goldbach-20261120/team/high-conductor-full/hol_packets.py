"""Bind both dyadic Turing allowances and both native phase bounds to the sign scans."""
from pathlib import Path
import json
from fractions import Fraction as F
from hashlib import sha256

src=Path(__file__).resolve().parent
out=src/'hol'
out.mkdir(exist_ok=True)
base=src.parent/'q10004-gaussian/hol'
name='Q265800'
def write(file,s):
    (out/file).write_bytes(s.encode())
def swap(s):
    return s.replace('Q10004',name)

s=swap((base/'Q10004ScanScript.sml').read_text())
s=s.replace('a+2*b*4294967296','a+2*b').replace('2*1310720*b*4294967296','2*1310720*b')
s=s.replace('upper numerator a has denominator 2^32','and allowance numerators a,b have denominator 2^32')
write(name+'ScanScript.sml',s)
s=swap((base/'Q10004ReceiptScript.sml').read_text())
s=s.replace('["F","T","F","T"]','["T","F","T","T"]')
write(name+'ReceiptScript.sml',s)
write('Holmakefile',(base/'Holmakefile').read_text())
write('check.sh',swap((base/'check.sh').read_text()))
data=json.loads((src/'counts.json').read_bytes())
sub=data['sub']
pair=(9539,117059)
rows=data['counts'][str(pair)]['fixed']
lines=[]
manifest=[]
for gi,guard in enumerate([320,640]):
    row=rows[gi]
    assert row['extra']==guard and sub==20480 and data['T']=='455'
    for policy in ['Rumely','moderate']:
        number=len(manifest)
        lower=455*64*(sub//5)
        upper=lower+guard*sub
        for ix,label in enumerate(pair):
            path=src/f'signs-{label}.tsv'
            assert sha256(path.read_bytes()).hexdigest()==data['sha256'][path.name]
            entries=[tuple(map(int,s.split())) for s in path.read_text().splitlines()]
            for region,(a,b) in enumerate(((0,lower),(lower,upper))):
                interior=[(j,s) for j,s in entries if a<j<b]
                flips=[j for (_,t),(j,s) in zip(interior,interior[1:]) if s!=t]
                assert len(flips)==row['main_label_counts' if not region else 'aux'][ix]
                blocks=[]
                for j,s in interior:
                    if blocks and j==blocks[-1][0]+blocks[-1][1]*sub and blocks[-1][1]<60:
                        p,n,w=blocks[-1]
                        blocks[-1]=(p,n+1,w+((s>0)<<n))
                    else: blocks.append((j,1,int(s>0)))
                lines += [' '.join(map(str,[number,ix,region,a,b,len(interior),len(flips),sum(b-j for j in flips),len(blocks)])),
                          ' '.join(str(v) for group in blocks for v in group)]
        phase=F(row['phase_upper'])*2**32
        allowance=F(row['allowance'][policy])*2**32
        assert phase.denominator==allowance.denominator==1
        lines.append(f'{guard} {phase} {allowance}')
        manifest.append(dict(policy=policy,guard=guard,phase_numerator=int(phase),allowance_numerator=int(allowance),
                             denominator=2**32,K=row['K'],W_ticks=row['W_ticks'],expected=F(row['exact_margin'][policy])>0))
write('packets.txt','\n'.join(lines)+'\n')
write('manifest.json',json.dumps(dict(rows=manifest,inputs=data['sha256'],packet_sha256=sha256((out/'packets.txt').read_bytes()).hexdigest(),
    assumptions=['Strict Hardy signs at supplied ticks','Arb phase upper bound','Rumely or moderate analytic allowance','Turing counting theorem']),indent=2))
