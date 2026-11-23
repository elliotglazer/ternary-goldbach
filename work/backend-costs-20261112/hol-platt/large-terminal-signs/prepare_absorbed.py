"""Independent residual bound for the unrotated Gaussian-integer pair."""
from pathlib import Path
d=Path(__file__).resolve().parent
src=(d/'prepare_fused.py').read_text().split('orig=')[0]
src=src.replace('ys=[]','ys=[]; unm=[]').replace('ys.append(rot((R,I),w,S*S))','ys.append(rot((R,I),w,S*S));unm.append((R,I))')
s1="""   rr,ii=int(sr['re']),int(sr['im']);rad=int(sr['abs_error_grid_units']); u,v=ws[k+1]; R,I=unm[k+1]
   unc=(max(abs(R*D-(u*rr+v*ii)),abs(I*D-(u*ii-v*rr)))+(abs(rr)+abs(ii))+(abs(u)+abs(v)+2)*rad+D-1)//D
   ap,aq=rot((a,bb),(u,v),S)
   # Unit roots and nearest-integer input phase/chirp centers each have coordinate error <= 1.
   ep=(abs(a)+abs(bb)+abs(u)+abs(v)+2+S-1)//S+1
   use=(ap>0)==(f>0); other=(aq>0)==(g>0)
   raw,orient=(R,use) if use!=other else (I,(ap>0)!=(g>0))
   ok=min(abs(ap),abs(aq))>ep and min(abs(f),abs(g))>1 and abs(raw)>unc
   if ok: assert ((raw>0)==orient)==(val>0)
   arr_abs.append([a,bb,f,g,e,unc]); misses+=not ok"""
src=src.replace('rows=[];bits=0','rows=[];bits=0;arr_abs=[];misses=0').replace('   bits+=int(val>0)<<k;',s1+'\n   bits+=int(val>0)<<k;').replace("t=f'fu{p}h{h}'","t=f'fu{p}h{h}';save(d/(t+'abs.txt'),arr_abs);print(t,'unresolved',misses)")
exec(src)


