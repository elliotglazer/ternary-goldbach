"""Concrete pre-gain and full q131071 terminal ball from the same sparse spectrum."""
from hashlib import sha256
import json
from pathlib import Path
from flint import arb,acb,ctx
from precision_hard_case import HERE,SEC,HOL,Q,N,chirps,parts,source,nearest,residues,tsv,quantize,pairmul,ball

def main():
    ctx.prec=192;ctx.threads=1
    j,k,p=5694,266,24;S=1<<p;_,rs=residues(Q);s,order,raw=source(rs,Q,j);w=chirps(p)
    xs=[nearest(z,1<<28) for z in raw];del raw
    src_hash=sha256(b''.join(f'{a} {b}\n'.encode() for a,b in xs)).hexdigest()
    def rd(n):return (n+8)//16
    R=I=er=0
    for h,(u,v) in enumerate(xs):
        u,v=rd(u),rd(v);a,b=quantize(pairmul((u,v),w[h]),S);x,y=w[(k-h)%N]
        R+=a*x+b*y;I+=b*x-a*y
        er+=(2*S+2)*(3+(abs(u)+abs(v)+2+S-1)//S)+abs(a)+abs(b)
    r,i=quantize(pairmul((R,I),w[k]),S*S);e=(2*S*er+abs(R)+abs(I)+2*er+S*S-1)//(S*S)+1
    ix,pp,qq=tsv(SEC/'roots28.tsv')[k-1];assert ix==k;ph=[rd(pp),rd(qq)]
    a=k%2;g=(arb.pi()*s.imag/4).exp()*abs(((s+a)/2).gamma())*arb.pi()**(-arb(1+2*a)/4)
    f=parts(s)[a];base=nearest(f/g,S);full=[rd(v) for v in nearest(f,1<<28)]
    assert g>0 and abs((f/g).real*S-base[0])<1 and abs((f/g).imag*S-base[1])<1
    v,d=ball(*ph,*base,e,r,i);v1,d1=ball(*ph,*full,e,r,i)
    archive=HERE/'precision-fine-hidden.json';old=json.loads(archive.read_bytes())
    assert (v1,d1)==next((int(v),int(d)) for jj,kk,pp,v,d in old['rows'] if (jj,kk,pp)==(j,k,p))
    out=arb(arb((v,-72)),arb((d,-72)))*g
    large=arb(arb((v1,-72)),arb((d1,-72)))
    assert out.overlaps(large) and out<0 and large<0
    record=dict(q=Q,k=k,j=j,t=str(s.imag),p=p,parity=a,phase=ph,source=[r,i,e],
        pregain=dict(factor=base,v=str(v),d=str(d)),full=dict(factor=full,v=str(v1),d=str(d1)),
        gain=str(g),regained=str(out),full_interval=str(large),spectrum_input_p28_sha256=src_hash,
        taylor_order=order,scale='2^-72 for v,d; 2^-24 for factor,phase,spectrum',
        gain_definition='exp(pi*t/4)*abs(Gamma((1/2+a+it)/2))*pi^(-(1+2*a)/4)',
        sha256={f.name:sha256(f.read_bytes()).hexdigest() for f in (Path(__file__),archive,SEC/'roots28.tsv',HOL/'large-coarse-sign/prime_panel.py')})
    (HERE/'precision-gain-packet.json').write_text(json.dumps(record,indent=2)+'\n');print(record['pregain'],ph,base,[r,i,e],flush=True)

if __name__=='__main__':main()
