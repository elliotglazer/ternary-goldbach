"""Certified finite Gram cells using python-flint Arb/Acb.

Analytic error estimates are derived in JointPrincipalL2.md. This checks the
finite inequalities, not the Lean analytic bridge or global QRH. No float
participates in an acceptance comparison. All numerical arithmetic is Arb.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time


def main():
    from flint import arb, acb, acb_mat, ctx
    import flint
    parser=argparse.ArgumentParser()
    parser.add_argument('--start',type=int,default=0)
    parser.add_argument('--stop',type=int,default=2750)
    parser.add_argument('--batch',type=int,default=32)
    parser.add_argument('--prec',type=int,default=128)
    args=parser.parse_args()
    if not (0<=args.start<args.stop<=2750 and args.batch>0 and args.prec>=96):
        raise ValueError('invalid range, batch, or precision')
    ctx.prec=args.prec
    ctx.threads=1
    started=time.monotonic()
    def emit(obj):
        print(json.dumps(obj),flush=True)
    def rr(a,b=1):
        return arb(a)/b
    def upper_text(a):
        return str(a.upper())
    I=acb(0,1)
    eu=rr(10*10**18,2**104)/rr(3,4)
    ed=rr(16*10**90,2**360)/rr(1,2)
    tail=2*arb(8).sqrt()*rr(64,31)*rr(-31,2).exp()
    assert eu<arb('7e-13') and ed<arb('2e-17') and tail<arb('2.2e-6')
    # Verify the two complex-disk majorants used by the Taylor remainder.
    rmax=2*rr(1,5).exp()
    hbound=(rmax.log()*rr(31,8)).exp()*arb(15).exp()*(2+rmax)**3
    hbound*=(rmax+rmax*rmax/2-rr(1,2)+8*arb.pi()*rmax/5).exp()
    assert hbound<arb('1e18')
    assert 9*(64*arb.pi()).exp()<arb('1e90')
    assert (4+arb(2).log())/47<rr(1,10)
    emit(dict(kind='header',status='RUNNING',flint_version=flint.__version__,precision_bits=ctx.prec,threads=ctx.threads,start=args.start,stop=args.stop,batch=args.batch,source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),u_error=upper_text(eu),delta_error=upper_text(ed),pair_tail=upper_text(tail)))

    # The Legendre root routine encloses exact algebraic roots and weights.
    rule_u=[arb.legendre_p_root(26,j,weight=True) for j in range(26)]
    rule_d=[arb.legendre_p_root(180,j,weight=True) for j in range(180)]
    deltas=[4*z for z,w in rule_d]
    dw=[4*w for z,w in rule_d]
    length=4+arb(2).log()
    half=length/94
    unodes=[]; base=[]; rnodes=[]
    for panel in range(47):
        center=-4+(2*panel+1)*half
        for z,w in rule_u:
            u=center+half*z
            r=u.exp()
            b=half*w*(rr(31,8)*u).exp()*(2-r)**3*(r-rr(1,2)-r*r/2).exp()
            unodes.append(u); rnodes.append(r); base.append(b)
    assert len(unodes)==1222
    emit(dict(kind='progress',stage='building_cached_twist_matrix',elapsed_seconds=time.monotonic()-started))
    twist=acb_mat(len(unodes),len(deltas),[(I*(2*arb.pi()*delta*r)).exp()*b for r,b in zip(rnodes,base) for delta in deltas])
    emit(dict(kind='progress',stage='cached_twist_matrix_ready',elapsed_seconds=time.monotonic()-started))

    def cell(k):
        if k<2400:
            return rr(16)+rr(k,100),rr(16)+rr(k+1,100)
        k-=2400
        return rr(40)+rr(k,10),rr(40)+rr(k+1,10)
    def F_upper(a):
        a=a.upper()
        threshold=rr(626,61000)
        exponential=threshold*(-1+a/threshold).exp()
        if a>=threshold:
            return a
        if a<=threshold:
            return exponential.upper()
        # Only a rounding-width overlap at the branch point can reach this.
        return a.union(exponential).upper()
    worst=arb(0); worst_index=None; failed=[]; processed=0
    digest=hashlib.sha256()
    for first in range(args.start,args.stop,args.batch):
        ks=list(range(first,min(first+args.batch,args.stop)))
        cells=[cell(k) for k in ks]
        gammas=[(a+b)/2 for a,b in cells]
        heights=acb_mat(len(ks),len(unodes),[(I*(g*u)).exp() for g in gammas for u in unodes])
        values=heights*twist
        for row,(k,(a,b),g) in enumerate(zip(ks,cells,gammas)):
            # Eu is a complex absolute error, so a box of radius Eu in each
            # coordinate safely encloses the exact truncated transform.
            vals=[values[row,j]+acb(arb(0,eu),arb(0,eu)) for j in range(len(deltas))]
            D=arb(0); C=acb(0)
            for j,w in enumerate(dw):
                z=vals[j]
                D+=w*(z.real*z.real+z.imag*z.imag)
                C+=w*z*vals[len(vals)-1-j]
            d_upper=(D+ed).upper()
            c_upper=(abs(C)+ed).upper()
            N=(2*d_upper+2*c_upper).sqrt()+tail
            bound=((b*b+rr(225,64))/6)*(F_upper(N+rr(626,1000)*(b-a)/2+arb('.00313'))+arb('1e-9'))
            passed=bool(bound<85)
            record=dict(kind='cell',index=k,left=str(a),right=str(b),gamma=str(g),N0_upper=upper_text(N),ratio_upper=upper_text(bound),passed=passed)
            encoded=json.dumps(record,sort_keys=True)
            digest.update(encoded.encode())
            emit(record)
            if not passed: failed.append(k)
            if worst_index is None or bound.upper()>worst:
                worst=bound.upper(); worst_index=k
            processed+=1
        emit(dict(kind='progress',stage='batch_complete',processed=processed,elapsed_seconds=time.monotonic()-started,worst_index=worst_index,worst_upper=upper_text(worst),failed_count=len(failed)))
    full=args.start==0 and args.stop==2750
    emit(dict(kind='summary',status=('PASS_ALL_2750' if full and not failed else 'FAIL' if failed else 'PASS_PARTIAL'),processed=processed,failed=failed,worst_index=worst_index,worst_upper=upper_text(worst),cell_records_sha256=digest.hexdigest(),elapsed_seconds=time.monotonic()-started,qualification='Finite Arb inequalities only; analytic reductions are paper proofs and not Lean-checked.'))
    if failed:
        raise SystemExit(1)


if __name__=='__main__':
    main()
