"""Independent height/argument inventory and rational error bounds, no function values."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
BLUEPRINT=AGENTS.parents[1]/'qrh-blueprint'
checks=0
def require(p):
    global checks
    assert p
    checks+=1
def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()

def run():
    pins={
        'SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md':'8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413',
        'check_scaled_height_recurrence_20261111.py':'F9A4A552EFAD7CE139D4E61D9378E40A9B0138CE8CB2CBB03848DAAE23D9AB3F',
        'scaled_height_recurrence_20261111.json':'10058EA331D8FC143981F3DA1AC5BA92AEEEF03553849A2E4666CA0783462F02',
    }
    for f,h in pins.items(): require(digest(BLUEPRINT/f)==h)
    old=json.loads((BLUEPRINT/'scaled_height_recurrence_20261111.json').read_text())
    for f,h in old['pins'].items(): require(digest(AGENTS/f)==h)
    delta=Q(1,2**118); eps=Q(1,2**140); J=128000
    step=Q(5,64)*Q(1,2**144)+2*Q(1,2**142)
    require(step/eps==Q(517,1024)<1)
    require(Q(1,2**144)<Q(1,2**137))
    require(Q(7,16)*Q(1,2**120)<delta/4)
    require(J*eps<Q(1,2))
    bound=2*delta/4+4*J*eps+Q(1,2**122)
    require(bound/delta==Q(701,1024)<Q(11,16)<1)
    require(Q(old['recurrence_error_bound_over_delta'])==bound/delta)
    require(Q(old['step_error_upper_over_eps'])==step/eps)
    require(max(16,(120+28)//2)==74)
    require(max(16,(138+28)//2)==83)
    # A p120 output on2^-123 is exactly representable on2^-140.
    require(140-123>=0 and 144-142>=0)
    require((1+eps)*2**142<2**143)
    require((1+bound)*2**140<2**143)
    bands=[(500,512,220,6401),(1000,1024,387,6400),(2000,2048,720,12800),(5000,4096,1720,38400),(10000,8192,3387,63988)]
    H=sum(z[3] for z in bands)
    require(H==127989 and H-1<J)
    start=priorD=priorN=priorX=0
    lifecycle_pairs=lifecycle_updates=direct_pairs=0
    cohorts=[]
    for i,(V,D,N,h) in enumerate(bands):
        xcount=1+(N+1)*D
        if i:
            factor=D//priorD
            require(factor*priorD==D)
            require((priorN+1)*priorD*factor<=(N+1)*D)
        new=xcount-priorX
        remaining=H-start
        lifecycle_pairs+=new*remaining
        lifecycle_updates+=new*(remaining-1)
        direct_pairs+=h*xcount
        require(Q(5,64)*(start+h-1)<=V)
        r=old['bands'][i]
        require((r['points'],r['introduced'],r['first_j'],r['last_j'])==(xcount,new,start,start+h-1))
        require(r['updates']==h*xcount-new)
        cohorts.append({'first_height_index':start,'new_arguments':new,'remaining_heights':remaining})
        priorD,priorN,priorX=D,N,xcount
        start+=h
    require(lifecycle_pairs==direct_pairs==old['height_argument_pairs'])
    require(lifecycle_updates==lifecycle_pairs-priorX==old['recurrence_updates'])
    require(priorX==old['initializations']==old['step_phase_certificates']==27754497)
    require(priorX*72==old['raw_state_and_step_bytes_at_144_signed_bits_per_coordinate']==1998323784)
    # Reconstruct only the short geometric block metadata, not millions of values.
    n=8192; end=3389*8192; anchors=0; covered=0
    while n<=end:
        length=min(n//128,end-n+1)
        require(length>0 and 128*(length-1)<n)
        covered+=length; anchors+=1; n+=length
    require(anchors==1046 and covered==priorX and n==end+1)
    K=21
    require(2*Q(1,128)**(K+1)<=Q(1,2**144)/8)
    require(K*(priorX-anchors)==old['log_nonanchor_horner_stages']==582822471)
    return {'scope':'Independent exact rational bounds and argument-cohort/block metadata only.', 'checks':checks,'author_pins':pins,'dependency_pins':old['pins'],'cohorts':cohorts,'pairs_by_lifetimes':lifecycle_pairs,'updates_by_lifetimes':lifecycle_updates,'step_ratio':str(step/eps),'final_error_ratio':str(bound/delta),'anchors':anchors}

if __name__=='__main__':
    result=run()
    HERE.joinpath('check_height_recurrence_review_20261111.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(result['checks'],'exact checks passed')
