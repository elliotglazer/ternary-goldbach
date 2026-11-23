"""Construct exact sign packets on the 20480-subtick lattice for stock HOL4."""
from fractions import Fraction as F
from pathlib import Path
from hashlib import sha256
import json

team=Path(__file__).resolve().parent
src=team/'q10004-gaussian'
out=src/'hol'
out.mkdir(exist_ok=True)
base=team.parents[1]/'backend-costs-20261112/hol-platt/full-height-count'
data=json.loads((src/'counts.json').read_bytes())
sub=data['sub']
assert sub==20480 and data['T']=='6578'
theory=(base/'FullCountScript.sml').read_text().replace('Theory FullCount','Theory Q10004Scan')
theory=theory.replace('20480','GUARD_SCALE').replace('4096','20480').replace('262144','1310720').replace('GUARD_SCALE','102400')
(out/'Q10004ScanScript.sml').write_text(theory)
receipt=(base/'CountReceiptScript.sml').read_text().replace('CountReceipt','Q10004Receipt').replace('FullCount','Q10004Scan')
receipt=receipt.replace('val both=map verify [0,1];','val both=map verify [0,1,2,3];\nval _=require (map (term_to_string o rhs o concl) both = ["F","T","F","T"]) "guard truth mismatch";')
(out/'Q10004ReceiptScript.sml').write_text(receipt)
prefix='../../../../backend-costs-20261112/hol-platt/'
incs=' '.join(prefix+x for x in ['small-gaussian-transform','small-gaussian','small-character-kernel'])
(out/'Holmakefile').write_text('INCLUDES = $(HOLDIR)/src/num/theories/cv_compute/automation '+incs+'\n')
lines=[]
manifest=[]
for pair_index,pair in enumerate(((6559,7707),(5499,7659))):
    for gi,guard in enumerate((320,640)):
        row=data['counts'][str(pair)]['fixed'][gi]
        assert row['extra']==guard
        number=pair_index*2+gi
        lower=6578*64*(sub//5)
        upper=lower+guard*sub
        for ix,label in enumerate(pair):
            source=src/f'signs-{label}.tsv'
            assert sha256(source.read_bytes()).hexdigest()==data['sha256'][source.name]
            entries=[tuple(map(int,s.split())) for s in source.read_text().splitlines()]
            for region,(a,b) in enumerate(((0,lower),(lower,upper))):
                interior=[(j,s) for j,s in entries if a<j<b]
                flips=[j for (_,t),(j,s) in zip(interior,interior[1:]) if s!=t]
                assert len(flips)==row['main_label_counts' if not region else 'aux'][ix]
                blocks=[]
                for j,s in interior:
                    if blocks and j==blocks[-1][0]+blocks[-1][1]*sub and blocks[-1][1]<60:
                        p,n,w=blocks[-1]
                        blocks[-1]=(p,n+1,w+((s>0)<<n))
                    else:
                        blocks.append((j,1,int(s>0)))
                lines.extend([' '.join(map(str,[number,ix,region,a,b,len(interior),len(flips),sum(b-j for j in flips),len(blocks)])),
                              ' '.join(str(v) for group in blocks for v in group)])
        phase=F(row['phase_upper'])*2**32
        assert phase.denominator==1
        lines.append(f'{guard} {phase} 18')
        manifest.append(dict(pair=pair,guard=guard,phase_numerator=int(phase),allowance=18,
                             K=row['K'],weight=row['W_ticks'],expected=row['U_minus_K']['moderate']<1))
(out/'packets.txt').write_bytes(('\n'.join(lines)+'\n').encode())
(out/'manifest.json').write_text(json.dumps({'rows':manifest,'inputs':data['sha256'],
     'packet_sha256':sha256((out/'packets.txt').read_bytes()).hexdigest()},indent=2))
