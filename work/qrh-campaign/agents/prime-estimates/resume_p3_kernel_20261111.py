"""Exploratory LP for rational-scale factorial minorants; no theorem claim."""
from fractions import Fraction as Q
import math,json,sys,time

def simplex(A,b,c):
 m=len(b);n=len(c); D=[list(row)+[bb] for row,bb in zip(A,b)]+[[-v for v in c]+[0.]]
 B=list(range(n,n+m));N=list(range(n));eps=1e-9
 for it in range(20000):
  s=min(range(n),key=lambda j:(D[m][j],N[j]))
  if D[m][s]>=-eps:return D[m][-1],{B[i]:D[i][-1] for i in range(m) if B[i]<n},it
  rows=[i for i in range(m) if D[i][s]>eps]
  if not rows:raise ValueError('unbounded')
  r=min(rows,key=lambda i:(D[i][-1]/D[i][s],B[i]));p=D[r][s]
  rr=D[r]; inv=1/p
  for i in range(m+1):
   if i==r:continue
   v=D[i][s]*inv
   if abs(v)>1e-15:
    D[i]=[D[i][j]-rr[j]*v if j!=s else -v for j in range(n+1)]
   else:D[i][s]=-v
  D[r]=[rr[j]*inv if j!=s else inv for j in range(n+1)]
  B[r],N[s]=N[s],B[r]
 raise ValueError('iterations')

def solve(d,m):
 ids=[j for j in range(1,m+1) if j!=d]; k=len(ids)
 pts=sorted(set(Q(d*i,j) for j in range(1,m+1) for i in range(1,j+1)))
 A=[];b=[]
 for u in pts:
  f=u.numerator//u.denominator
  aa=[float((Q(j,d)*u).__floor__()-Q(j,d)*f) for j in ids]
  target=0 if u<1 else u
  A.append(aa+[-a for a in aa]);b.append(float(target-f))
 obj=[j/d*math.log(j/d) for j in ids]
 val,sol,it=simplex(A,b,obj+[-v for v in obj])
 coeff={j:sol.get(i,0)-sol.get(k+i,0) for i,j in enumerate(ids)}
 coeff[d]=1-sum(j/d*v for j,v in coeff.items())
 return {'d':d,'m':m,'improvement':val,'lower_constant':1-val,'iterations':it,'coeff':{j:v for j,v in coeff.items() if abs(v)>1e-7}}
if __name__=='__main__':
 for d,m in [(2,6),(3,9),(4,12),(6,18),(10,30),(15,45)]:
  t=time.time();r=solve(d,m);r['seconds']=time.time()-t;print(json.dumps(r),flush=True)