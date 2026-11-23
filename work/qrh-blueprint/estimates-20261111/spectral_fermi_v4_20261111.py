"""Small literal-ledger Fermi arithmetic only. No inventories or evaluators imported.
All nonliteral microprices are assumptions, not measured upper/lower bounds.
"""
from fractions import Fraction as F
from pathlib import Path
import json

HERE=Path(__file__).resolve().parent
SCENARIOS=['low','central','high']
EXTRA=[0,167,640]
NR=[60254515577760,61445729121504,64819645326240]
REGRID=[54067011555562,55113823157878,58078744642282]
TP=[3076486625497782230,3139565675287805932,3318226696549370070]
TA=[519549455680901010,530159065628220658,560209038712545170]
HP=[593964831456366888,605707347134807232,638966057140210968]
HA=[161959260607299648,165161148340119552,174229961631380928]
LARGE_Q=[36290898519503,37014550742284,39064176499023]
SMALL_B=[128941391789290+89858217607168,129070168525694+89954059550720,129487303527630+90276181311488]
SMALL_G=[8542028172242,8544378416074,8549750401978]
SMALL_Q=[1775431871117,1778517548153,1787257220237]
SMALL_POINT=[25399177848072,25423104366744,25504315078872]
SMALL_INV_SCALE=[15046227780352,15059996816832,15107909947904]
SMALL_PREFACTOR=[1202865170991,1204094474269,1208208168343]
SMALL_RADIAL=[2421291652611,2423754559955,2431991778479]
SMALL_ODD_SCALE=[4156411711634,4157586833550,4160272826502]
# Source rows are reconciled m159 counts, plus the SAME 41 global guard nodes.
SOURCE={
 'head_scale':[10962363526720,10990073586220,11068557766720],
 'head_add':[11379239858080,11407976216080,11489367218080],
 'bernoulli':[702585728572,705631782520,714259228732],
 'E':[58056920314,58292284770,58958915834],
 'translation':[150671324160,151389557760,153423836160],
 'fine_state':[417035985639,418062717838,420970767719],
 'endpoint':[7538384728,7557542300,7611802968],
 'final':[6619212300,6673938200,6828940300],
}
GUARD=dict(head_scale=6803068500,head_add=7055034000,bernoulli=747833604,E=57784088,
 translation=176332800,fine_state=252071977,endpoint=4703356,final=13435700)
# (P,A) price assumptions per typed source operation, low/central/high.
SOURCE_PRICE={
 'head_scale':[(2000,160),(4000,320),(12000,1000)],
 'head_add':[(0,80),(0,160),(0,400)],
 'bernoulli':[(2000,240),(4000,480),(12000,1400)],
 'E':[(6000,600),(12000,1200),(40000,4000)],
 'translation':[(100,160),(1000,320),(5000,1000)],
 'fine_state':[(5000,500),(10000,1000),(30000,3000)],
 'endpoint':[(10000,2000),(50000,10000),(200000,40000)],
 'final':[(0,320),(0,640),(0,2000)],
}
def add(rows,name,p,a,basis):
 rows.append(dict(name=name,P=int(p),A=int(a),basis=basis))

out={}
for i,label in enumerate(SCENARIOS):
 rows=[]
 add(rows,'large transform',TP[i],TA[i],'accepted combined8828 three-product exact template subtotal')
 add(rows,'full20 residue',HP[i],HA[i],'accepted guarded full20/b94 exact template subtotal')
 add(rows,'assembled input regrid',0,124*REGRID[i],'accepted combined8828 conservative124 unsigned core; extra wrappers below')
 add(rows,'raw heads and exact assembly',5572*NR[i],448*NR[i],'candidate FBBB/076A producer; no prior head placeholder added')
 # All integer states through full7000 domain, deliberately conservative shared producer.
 add(rows,'raw shared integer recurrence',5252*265800*89600,378*265800*89600,'all-pool I=265800,J=89600; different from EM states')
 # Conservative cache count, no new conductor/height fold.
 add(rows,'raw conductor caches',494*125400*(84200+EXTRA[i]+41),100*125400*(84200+EXTRA[i]+41),'upper N_C; A100 is uncertain binding/add allowance')
 sp=sa=0
 for k in SOURCE:
  count=SOURCE[k][i]+GUARD[k];p,a=SOURCE_PRICE[k][i];sp+=count*p;sa+=count*a
 add(rows,'shared EM source arithmetic',sp,sa,'typed counts times explicit uncalibrated source microprices')
 # Keep full time transform for a common conservative schedule; no half-FFT saving inferred.
 add(rows,'small character and time butterflies',SMALL_B[i]*[18000,36000,72000][i],SMALL_B[i]*[2000,4000,8000][i],
  'uncalibrated width-sensitive butterfly P/A allowance; fractional widths up to415')
 add(rows,'small Gaussian and bucket work',SMALL_G[i]*[5000,20000,80000][i],SMALL_G[i]*[300,1200,4800][i],
  'uncalibrated Gaussian P/A allowance; includes bucket/contract rounds, not character/time stages')
 add(rows,'small point products and prefactors',(SMALL_POINT[i]+SMALL_PREFACTOR[i])*[18000,36000,72000][i]+SMALL_RADIAL[i]*[6000,12000,24000][i],
  (SMALL_POINT[i]+SMALL_PREFACTOR[i])*[1600,3200,6400][i]+SMALL_RADIAL[i]*[400,800,1600][i],
  'separate retained categories, NOT included in butterfly/Gaussian counts; assumed width-sensitive prices')
 add(rows,'small inverse dyadic and odd scales',0,(SMALL_INV_SCALE[i]+SMALL_ODD_SCALE[i])*[80,160,400][i],
  'retained internal scales; not deleted output omega/Y factors; assumed transport/range price')
 add(rows,'small coarse sign and binding',0,SMALL_Q[i]*[100,200,800][i],
  'separate output strict comparison/binding allowance')
 # Setup budget replaces all kernel/root/elementary construction details not expanded above.
 add(rows,'shared setup and elementary certificates',[10**15,10**16,10**17][i],[2*10**14,2*10**15,2*10**16][i],
  'explicit assumed allowance: large+small roots/chirps/cache FFTs/logs/cis/inverse roots/Bernoulli; no per-height replication')
 q=LARGE_Q[i]+41*4333246843
 add(rows,'large completion and coarse signs',q*[6000,12000,30000][i],q*[600,1500,5000][i],
  'uncalibrated per-output completion/phase/scale/sign allowance; common phase setup above')
 # Different typed repair schedules, not assumed universal sign success.
 large_queries=(q*[1,30,1000][i]+999)//1000
 small_queries=(SMALL_Q[i]*[1,30,1000][i]+999)//1000
 add(rows,'off-grid repair queries',large_queries*83*[1000,2000,6000][i]+small_queries*220*[8000,16000,48000][i],
  large_queries*83*[200,400,1200][i]+small_queries*220*[500,1000,3000][i],
  '0.1%,3%,100% query fractions; large83/small220-term local model, no claim queries succeed')
 add(rows,'principal RH1e8',[10**16,10**17,10**18][i],[10**15,10**16,10**17][i],
  'separate provisional budget; about1e12 unshared main summands at10k/100k/1m P-equivalent including phase/correction')
 # Closure/sign ordering core: about4.35e9 labels, count sharing notperzero theorem.
 add(rows,'count closure and exceptional analytic certificates',[10**14,10**16,10**18][i],[10**15,10**16,10**18][i],
  'nonzero uncertain count/central/cluster/endpoint budget; not guaranteed sufficient')
 basep=sum(r['P'] for r in rows);basea=sum(r['A'] for r in rows)
 # Additional proof work for signed/range/binding/source, beyond modeled unsigned cores.
 overhead=[F(1,5),F(1,2),F(1,1)][i]
 add(rows,'nonlocal source/export/packet binding overhead',int(basep*overhead),int(basea*overhead),
  'uncalibrated20%/50%/100% for public source/export conversions and global dependency/packet joins ONLY; excludes local product/add/round/sign/range expansion already in kP/kA')
 P=sum(r['P'] for r in rows);A=sum(r['A'] for r in rows)
 # A repair can force replay of whole dependent numerical blocks; retained checking
 # and generation retry effects differ and are applied after their own timings.
 out[label]=dict(extra_nodes=EXTRA[i],rows=rows,P=P,A=A,large_queries=large_queries,small_queries=small_queries,
  numerical_retry_generation_factor=str([F(1),F(5,4),F(3)][i]),
  retained_refinement_check_factor=str([F(1),F(11,10),F(2)][i]),
  mm0_dispatch_expansion=dict(P=[100,180,400][i],A=[80,160,320][i]),
  mm0_stock_check_dispatches_per_second=[200000000,100000000,25000000][i],
  mm0_emit_bytes_per_second=[375000000,150000000,50000000][i],
  mm0_bytes_per_dispatch=[1,2,8][i],
  numeric_witness_seconds_per_reference_gate=str([F(1,10**7),F(1,10**6),F(1,10**4)][i]),
  library_generation_core_hours=[1000,100000,10000000][i],
  library_check_core_hours=[1000,100000,10000000][i])
 # Explicit unmeasured transfer prices. Complete local pilot is about8-12ms,
 # checking21 declarations with prebuilt proof terms; R is not a measured gate count.
 out[label]['lean_generate_seconds_per_reference']=str([F(1,1000),F(1,100),F(1,10)][i])
 out[label]['lean_recheck_seconds_per_reference']=str([F(1,1000),F(1,100),F(1,10)][i])
for v in out.values():
 d=v['P']*v['mm0_dispatch_expansion']['P']+v['A']*v['mm0_dispatch_expansion']['A']
 v['mm0_dispatches_assumed']=d
 v['mm0_check_core_hours']=str(F(d,v['mm0_stock_check_dispatches_per_second']*3600)*F(v['retained_refinement_check_factor']))
 v['reference_gate_equivalents']=str(F(v['P'],5000)+F(v['A'],500))
 v['numeric_witness_core_hours']=str(F(v['reference_gate_equivalents'])*F(v['numeric_witness_seconds_per_reference_gate'])/3600*F(v['numerical_retry_generation_factor']))
 v['mm0_generation_core_hours']=str(F(d*v['mm0_bytes_per_dispatch'],v['mm0_emit_bytes_per_second']*3600)*F(v['numerical_retry_generation_factor'])+F(v['numeric_witness_core_hours'])+v['library_generation_core_hours'])
 v['mm0_check_core_hours']=str(F(v['mm0_check_core_hours'])+v['library_check_core_hours'])
 v['mm0_stream_bytes_assumed']=d*v['mm0_bytes_per_dispatch']
 v['lean_generation_core_hours']=str(F(v['reference_gate_equivalents'])*F(v['lean_generate_seconds_per_reference'])/3600*F(v['numerical_retry_generation_factor'])+F(v['numeric_witness_core_hours'])+v['library_generation_core_hours'])
 v['lean_independent_check_core_hours']=str(F(v['reference_gate_equivalents'])*F(v['lean_recheck_seconds_per_reference'])/3600*F(v['retained_refinement_check_factor'])+v['library_check_core_hours'])
receipt=dict(scope='Provisional Fermi arithmetic; no inventory fold or actual values',scenarios=out)
target=HERE/'spectral_fermi_v4_20261111.json'
with target.open('x') as f:json.dump(receipt,f,indent=2);f.write('\n')
for label,v in out.items():
 print(label,'P',v['P'],'A',v['A'],'MM0 generation/check core-hours',float(F(v['mm0_generation_core_hours'])),float(F(v['mm0_check_core_hours'])))
