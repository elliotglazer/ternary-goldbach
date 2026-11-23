"""Fermi accounting only, using pinned saved calibrations; no prime/certificate runs."""
from pathlib import Path
import json, hashlib, math
HERE=Path(__file__).resolve().parent
YEAR=31557600
N=989*10**24
L=2**36
W=2**18
def ceildiv(a,b):return (a+b-1)//b
def model(backend,B,i):
 targets=B//2-1;words=ceildiv(targets,64);tiles=ceildiv(targets,W)
 anchors=512*(B//(2*L));Kmin=ceildiv(N-1-B-3,B-2)
 K=ceildiv(Kmin*[105,120,200][i],100)
 scale=B/10**16
 search=words*1.30e-6*[1,2,5][i]
 anchor_generation=anchors*[.002,.02,.2][i]
 exception_generation=YEAR*scale*[.05,.5,5][i]
 exception_check=YEAR*scale*[.05,.5,5][i]
 if backend=='Lean':
  cover_check=tiles*.003399653*[1,2,8][i]
  cover_produce=cover_check*[.1,.5,1.5][i]
  anchor_check=anchors*[.03,.055078125,.25][i]
  sourcegen=YEAR*[.02,.1,1][i];sourcecheck=YEAR*[.02,.2,2][i]
 else:
  updates=words*11.175
  if backend=='MM0_stock_conditional':
   cover_check=updates*8.22014460148686e-7*[1.2,2,5][i]
   cover_produce=updates*3.9959993084370677e-7*[1,2,5][i]
  else:
   # Same-rule engineering scenario, explicitly not a measured implementation.
   cover_check=updates*[.60e-6,.822e-6,1.5e-6][i]*[1.2,2,5][i]
   cover_produce=updates*3.9959993084370677e-7*[.75,1.25,3][i]
  anchor_check=anchors*[.1,1,10][i]
  anchor_generation+=anchor_check*[.5,1,2][i]
  sourcegen=YEAR*[.1,1,10][i];sourcecheck=YEAR*[.2,2,20][i]
 fallback=[1e-5,.001,.01][i]
 native_rung=15e-6*[2,10,100][i]+fallback*[.02,.1,1][i]
 if backend=='Lean':
  rungcheck=55e-6*[1,3,30][i]+fallback*[.1,.5,5][i]
  laddergen=K*native_rung;laddercheck=K*rungcheck
  commands=None
 else:
  # 44 modular squares, each two S(12) products plus A(24), A(12), glue.
  P=44*2*745;A=44*(49+25)
  commands=P*[100,180,400][i]+A*[80,160,320][i]+44*[100,180,400][i]
  throughput=([200e6,100e6,25e6]if backend=='MM0_stock_conditional'else[400e6,160e6,50e6])[i]
  rungcheck=1.2*commands/throughput+fallback*[.1,1,10][i]
  laddercheck=K*rungcheck
  proof_ratio=([.5,1,2]if backend=='MM0_stock_conditional'else[.3,.6,1.5])[i]
  laddergen=K*native_rung+proof_ratio*laddercheck
 # Cold finite library, checked decoders/composition, process/shard overhead.
 # Explicit judgment reserve, not inherited from the old 4e18 headline.
 setup=YEAR*([.1,1,10]if backend=='Lean'else[.2,2,20])[i]
 gen=search+anchor_generation+exception_generation+cover_produce+sourcegen+laddergen+setup/2
 check=cover_check+anchor_check+exception_check+sourcecheck+laddercheck+setup/2
 result=dict(backend=backend,scenario=['low','central','high'][i],B=B,L=L,targets=targets,words=words,tiles=tiles,anchor_records=anchors,Kmin=Kmin,assumed_K=K,
  seconds=dict(binary_native_search=search,binary_anchor_generation=anchor_generation,binary_exception_generation=exception_generation,binary_cover_production=cover_produce,binary_source_generation=sourcegen,binary_cover_checking=cover_check,binary_anchor_checking=anchor_check,binary_exception_checking=exception_check,binary_source_checking=sourcecheck,ladder_generation=laddergen,ladder_checking=laddercheck,cold_library_decoding_assembly_reserve=setup),
  core_years=dict(generation=gen/YEAR,checking=check/YEAR,total=(gen+check)/YEAR),rung_check_seconds=rungcheck,assumed_fallback_fraction=fallback,mm0_dispatches_per_rung=commands)
 if backend!='Lean':
  result['schematic_binary_stream_bytes']=math.ceil(words*11.175*150.01)
  result['ladder_dispatch_bytes_sensitivity']=math.ceil(K*commands*3)
 return result
rows=[model(b,B,i)for b,B in [('Lean',10**16),('MM0_stock_conditional',2*10**16),('MM0_engineered_same_rules',2*10**16)]for i in range(3)]
cutoff=[model(b,B,1)for b in ['Lean','MM0_stock_conditional','MM0_engineered_same_rules']for B in [10**16,2*10**16,10**17]]
out=dict(status='PROVISIONAL_FERMI_NOT_BENCHMARK_OR_UPPER_BOUND',year_seconds=YEAR,N0=N,rows=rows,central_cutoff_sensitivity=cutoff,no_candidates_or_new_inventory=True)
raw=(json.dumps(out,indent=2)+'\n').encode()
p=HERE/'finite_cost_scenarios.json'
with p.open('xb')as f:f.write(raw)
print(json.dumps([dict(backend=r['backend'],scenario=r['scenario'],years=r['core_years'])for r in rows],indent=2))
print('cutoff central',[(r['backend'],r['B'],round(r['core_years']['total'],2))for r in cutoff])
print('receipt SHA256',hashlib.sha256(raw).hexdigest().upper())
