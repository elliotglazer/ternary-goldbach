"""Independent rational envelope, cost and lifetime checks; no analytic values."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import json,hashlib

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
P=HERE.parent/'major-constants'
author=P/'FINAL_SEED_HEAD_CORRECTION_TRADEOFF_2026-11-11.md'
source=P/'seed_head_correction_tradeoff_20261111.py'
data=P/'seed_head_correction_tradeoff_20261111.json'
pinlist={author:'3B760B39986F6A80C1ADB71BCABDEFDE28947964225383AF1073E6601162DE4F',
 source:'F9EED5088D70655D6D3CB23DF70F76D6F80D3854F406CAB8EE058163A836C7B2',
 data:'A430173E669CCD088931EF11E95D473BB5FBF96BA668EF5A3D3B337D2E4D9522'}
checks={}
def ck(name,condition):
 assert condition,name
 checks[name]=True
for p,h in pinlist.items():ck('pin '+p.name,hashlib.sha256(p.read_bytes()).hexdigest().upper()==h)
a=json.loads(data.read_text())
for path,h in a['input_sha256'].items():
 p=ROOT/path;ck('input '+path,hashlib.sha256(p.read_bytes()).hexdigest().upper()==h);pinlist[p]=h
V,D,N,m=7000,8192,1500,256
blo,bhi=N+1,N+2
r=F(17,20);eta=F(1,2**100);delta=F(1,2**118);u=F(1,2**122)
W=V+32+2*m
ratio=F(W,6*blo)
ck('actual E ratio',ratio<r<1)
ck('scaled power ratio',F(W,blo*D)<1)
ck('R first factor',F(V+32,D)<F(5,4))
ck('R later factor',F(V+32,2*D)<F(5,8))
ck('lambda factor',F(6,D)<F(1,2))
rem=F(4*bhi,1)/F(4*m-1,2)*r**(2*m)
ck('receipt remainder',rem==F(a['remainder_upper']))
ck('remainder threshold',rem<F(1,2**116))
for k in range(32):
 ck('last rising factor '+str(k),V+k+2*m<=W)
 ck('k normalized factor '+str(k),F(W,blo*D)**k/factorial(k)<=1)
 bound=F(4*bhi,1)/F(2*k+4*m-1,2)*F(W,blo*D)**k/factorial(k)*ratio**(2*m)
 ck('complete k remainder '+str(k),bound<=rem)
for p in (20,27,32):ck('last E update '+str(p),V+(p+2*m-2)<=W)
ck('E rounding geometry',1/(1-r)<7)
ck('E center',1+7*u<2)
S=4*r/(1-r*r)
ck('S bound',S<13)
ck('S product constant',4*7+2+1==31)
Serr=m*31
ck('S sum constant',Serr==7936)
ck('half E error',F(7,2)+1<=5)
ck('S scaled error',F(Serr,6)+1<1324)
Zerr=14*bhi+1+5+1324
ck('Z error',Zerr==14*bhi+1330 and Zerr*u<1)
ck('Z magnitude',2*bhi+F(1,2)+S/6<2*bhi+3)
Ferr=Zerr+2*(2*bhi+4)+1
ck('F error',Ferr==18*bhi+1339)
end_u=2*Ferr+1;end_d=2*bhi+3
ck('endpoint error',end_u==36*bhi+2679)
errors={}
for p in (20,27,32):
 dcoeff=5*N+end_d
 ucoeff=5*N*p+3*N+1+end_u+1
 error=dcoeff*delta+ucoeff*u+rem
 ck('full error '+str(p),error<eta/4)
 errors[str(p)]=dict(delta=dcoeff,u=ucoeff,error_over_eta=str(error/eta))
ck('P27 receipt error',F(errors['27']['error_over_eta'])==F(a['P27_error_over_eta']))
ck('P27 receipt coefficients',errors['27']['delta']==a['P27_error_delta_coefficient'] and errors['27']['u']==a['P27_error_u_coefficient'])
ck('P32 coefficient',errors['32']['u']==301253)
C=N+2*bhi+3
ck('C bound',C==4507 and 4*C+1<2**16)
alpha=1266*F(5,16)**20/factorial(20)+1266*F(15,16)**27/factorial(27)+2532*eta+633*330*F(1,2**110)+1688*F(1,2**100)
ck('full alpha',alpha<F(1,2**82))
ck('shift magnitude perturbation',2**27*(eta+330*F(1,2**110))<1)
ck('old recurrence with final copy',delta/2+4*128000*F(1,2**140)+F(1,2**122)<delta)

def cost(n,mm):
 # D complete-P anchors and one endpoint with twenty coefficients.
 result=dict(head_scales=0,head_additions=0,Bernoulli_terms=0,Bernoulli_additions=0,E_complex_stages=0,source_slots=0,midpoint_updates=330*D)
 for p,count in ((27,D),(20,1)):
  result['head_scales']+=count*n*(p-1)
  result['head_additions']+=count*n*p
  result['Bernoulli_terms']+=count*mm*p
  result['Bernoulli_additions']+=count*mm*p
  result['E_complex_stages']+=count*(p+2*mm-2)
  result['source_slots']+=count*p
 return result
old,new=cost(2387,64),cost(N,m)
ck('old costs',old==a['old_per_height']);ck('new costs',new==a['new_per_height'])
ck('net scale saving',old['head_scales']+old['Bernoulli_terms']-new['head_scales']-new['Bernoulli_terms']==146469589)
ck('net add saving',old['head_additions']+old['Bernoulli_additions']-new['head_additions']-new['Bernoulli_additions']==153736780)
ck('extra E cost',new['E_complex_stages']-old['E_complex_stages']==3146112)

# In final-grid integer coordinates the earlier arguments are even integers.
previous_last=1721*8192
final_last=1501*8192
previous=previous_last//2+1
final=final_last+1
intersection=final_last//2+1
introduced=final-intersection
retired=previous-intersection
union=previous+introduced
transition=dict(previous_arguments=previous,last_band_arguments=final,retained=intersection,retired=retired,introduced=introduced,total_required_union=union)
ck('exact progression intersection',final_last<previous_last and final_last%2==previous_last%2==0)
ck('transition',transition==a['transition'])
ck('counts',retired==901120 and union==13197313)
old_final=2388*D+1
prefix=json.loads((P/'combined_odd_even_height_inventory_20261111.json').read_text())
for i,row in enumerate(a['scenarios']):
 H=prefix['scenarios'][i]['global_nodes']-64001
 ck('H '+str(i),H==row['last_band_heights'])
 ck('height '+str(i),F(5*(64000+H),64)<7000)
 ck('old work '+str(i),{k:H*v for k,v in old.items()}==row['old_work'])
 ck('new work '+str(i),{k:H*v for k,v in new.items()}==row['new_work'])
 ck('old pairs '+str(i),H*old_final==row['old_argument_pairs'])
 ck('new pairs '+str(i),H*final==row['new_argument_pairs'])
 ck('old updates '+str(i),H*old_final-(old_final-previous)==row['old_last_band_updates'])
 ck('new updates '+str(i),(H-1)*final+intersection==row['new_last_band_updates'])
 ck('update difference '+str(i),row['old_last_band_updates']-row['new_last_band_updates']==H*7266304-6365184)

n=D;end=1722*D;starts=[];lengths=[]
while n<=end:
 length=min(n//128,end-n+1)
 ck('block '+str(n),length>0 and F(length-1,n)<=F(1,128))
 starts.append(n);lengths.append(length);n+=length
full=end-D+1
ck('cover',sum(lengths)==full)
ck('log setup',dict(full_grid_points=full,anchors=len(starts),degree21_stages=21*(full-len(starts)))==a['log_setup_conservative'])
ck('explicit log overcoverage',full-union==901120)
ck('new gamma count',a['new_exact_gamma_constants']==192 and a['highest_Bernoulli_index']==512)
out=dict(status='PASS_INDEPENDENT_HEAD_CORRECTION_TRADEOFF',checks=checks,pins={str(p):h for p,h in pinlist.items()},
 errors=errors,alpha_over_budget=str(alpha*2**82),old_per_height=old,new_per_height=new,transition=transition,
 log_setup=dict(full_grid_points=full,anchors=len(starts),degree21_stages=21*(full-len(starts))),
 scope='Exact envelopes and counts only; no author code import, analytic values, builds or D4096 combination')
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(status=out['status'],checks=len(checks),transition=transition,log_setup=out['log_setup'])))
