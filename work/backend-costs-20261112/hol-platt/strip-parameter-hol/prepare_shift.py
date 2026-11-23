"""Choose the native power witnesses and submit them against existing HOL packet constants."""
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
import json
from strip_packet_import import inputs

here=Path(__file__).resolve().parent
w,pan,rows,summary=inputs()
def clog(x):
    x=F(x)
    k=x.numerator.bit_length()-x.denominator.bit_length()
    return k+int(F(2)**k<x)
def integer(x):
    return str(x) if x>=0 else f"(-{abs(x)})"
def emit(name,expr):
    out.append(f'val {name}=prove_true "{name}" '+chr(96)*2+expr+chr(96)*2+';')
def stamp(s):
    out.append(f'val _=stamp "{s}";')

out=['Theory StripShiftAcceptance','Ancestors StripShift StripParameterAcceptance StripParameter integer list arithmetic',
     'Libs intLib','val timer=Timer.startCPUTimer();',
     'fun stamp s=let val {usr,sys}=Timer.checkCPUTimer timer in print("SHIFT_TIME "^s^" "^Time.toString(Time.+(usr,sys))^"\\n") end;',
     'fun prove_true name tm=save_thm(name,EQT_ELIM(EVAL tm));']
stamp('start')
groups={};masses={};compiled=[]
for i,(ref,raw) in enumerate(zip(w['refs'],rows,strict=True)):
    q,label,tick,gid,mid,e=ref
    A=w['geometries'][gid]
    M=next(t for t in w['mass_bounds'] if t['id']==mid)
    # Verify that the same b selected by the exact path suffices here.
    b=M['b']
    kg=clog(F(A['node_distance_product']*10**12,(64*A['sub']*(2*b-1))**12))
    km=clog(M['mass'])
    u=1<<max(0,kg+km+raw[5]-e)
    groups[gid,b]=kg;masses[mid]=km
    row=next(t for t in pan['rows'] if t['q']==q)
    a=next(t['parity'] for t in row['channels'] if t['label']==label)
    last=row['coarse_intervals']//len(row['channels'])
    assert a==M['parity'] and last==M['last']
    compiled.append((i,q,label,a,last,gid,mid,b,km,kg,u))
for (gid,b),kg in sorted(groups.items()):
    emit(f'geo_{gid}_{b}',f'geom_shift sg{gid} {b} {integer(kg)}')
for mid,km in sorted(masses.items()):
    emit(f'mass_{mid}',f'mass_shift sm{mid} {integer(km)}')
stamp('shared_shifts')
for i,q,label,a,last,gid,mid,b,km,kg,u in compiled:
    emit(f'row_{i}',f'shift_row sp{i} ({q},{label},{a},{last}) sg{gid} sm{mid} {b} {integer(km)} {integer(kg)} {u}')
stamp('rows')
for i,q,label,a,last,gid,mid,b,km,kg,u in compiled:
    emit(f'sign_{i}',f'shift_sign sp{i} {u}')
    out.append(f'val _=save_thm("sp{i}_shifted",LIST_CONJ [StripParameterAcceptanceTheory.sg{gid}_ok,StripParameterAcceptanceTheory.sm{mid}_ok,geo_{gid}_{b},mass_{mid},row_{i},sign_{i}]);')
stamp('signs')
(here/'StripShiftAcceptanceScript.sml').write_bytes(('\n'.join(out)+'\n').encode())
print(len(groups),len(masses),len(compiled),max(F(t[-1],r[6]) for t,r in zip(compiled,rows)))
