"""Generate a fixed small arithmetic fixture, not spectral values."""
from pathlib import Path
import json, hashlib, time, sys
H=Path(__file__).resolve().parent
small='--small' in sys.argv
complete='--complete' in sys.argv
start=time.perf_counter()
header='''import Lean.Elab.Command
import Lean.Elab.Tactic.Omega
open Lean

namespace ArithmeticCalibration
theorem three_real (a b c d : Int) : c*(a+b)-b*(c+d)=a*c-b*d := by
  rw [Int.mul_add, Int.mul_add, Int.mul_comm c a, Int.mul_comm c b]
  omega
theorem three_imag (a b c d : Int) : c*(a+b)+a*(d-c)=a*d+b*c := by
  rw [Int.mul_add, Int.mul_sub, Int.mul_comm c a, Int.mul_comm c b]
  omega
theorem round_interval (n q r s h : Int) (hs : s=2*h)
    (hw : n+h=q*s+r) (h0 : 0<=r) (h1 : r<s) :
    -s<=2*(n-q*s) ∧ 2*(n-q*s)<s := by omega
end ArithmeticCalibration

namespace Fixture
'''
lines=[header];rows=[];bundles=[]
def z(n):return f'({n} : Int)'
for p in ((74,100,120) if small else (74,80,100,108,120)):
 S=2**p
 cases=[(311*S+1234567,-173*S+76543,3*S//4+11,-S//4+19),
        (-251*S+7919,119*S-104729,-S//2+7,S//3-13),
        (111*S+1,-37*S-1,S//2,0),
        (511*S-17,255*S+9,-S//2+3,S//2-11)]
 for j,(a,b,c,d) in enumerate(cases):
  if small and not (j==0 or (p==100 and j==2)):continue
  prefix=f'p{p}f{j}_'; names=[];types={}; groups={}
  def theorem(name,typ,proof='by decide',group='product'):
   full=prefix+name;names.append(full);types[full]=typ;groups[full]=group
   lines.append(f'theorem {full} : {typ} := {proof}\n')
   return full
  cp=c+d;cm=d-c;ab=a+b;t=c*ab;u=b*cp;v=a*cm;rr=t-u;ii=t+v
  qr=(rr+S//2)//S;tr=rr+S//2-qr*S;qi=(ii+S//2)//S;ti=ii+S//2-qi*S
  cap=2**(p+10);rawcap=2**(2*p+12)
  source=f'-{z(cap)}<{z(a)} ∧ {z(a)}<{z(cap)} ∧ -{z(cap)}<{z(b)} ∧ {z(b)}<{z(cap)} ∧ -{z(S)}≤{z(c)} ∧ {z(c)}≤{z(S)} ∧ -{z(S)}≤{z(d)} ∧ {z(d)}≤{z(S)}'
  nsource=theorem('source_ranges',source,group='setup')
  nc=theorem('cache_plus',f'{z(c)}+{z(d)}={z(cp)}',group='setup')
  nd=theorem('cache_minus',f'{z(d)}-{z(c)}={z(cm)}',group='setup')
  cache=f'-{z(2*S)}≤{z(cp)} ∧ {z(cp)}≤{z(2*S)} ∧ -{z(2*S)}≤{z(cm)} ∧ {z(cm)}≤{z(2*S)}'
  if complete:cache+=f' ∧ {z(c)}*{z(c)}+{z(d)}*{z(d)}≤{z(S)}*{z(S)}'
  ncr=theorem('cache_ranges',cache,group='setup')
  nab=theorem('presum',f'{z(a)}+{z(b)}={z(ab)}')
  np1=theorem('mul_t',f'{z(c)}*{z(ab)}={z(t)}')
  np2=theorem('mul_u',f'{z(b)}*{z(cp)}={z(u)}')
  np3=theorem('mul_v',f'{z(a)}*{z(cm)}={z(v)}')
  nr=theorem('post_real',f'{z(t)}-{z(u)}={z(rr)}')
  ni=theorem('post_imag',f'{z(t)}+{z(v)}={z(ii)}')
  rawranges=f'-{z(rawcap)}<{z(t)} ∧ {z(t)}<{z(rawcap)} ∧ -{z(rawcap)}<{z(u)} ∧ {z(u)}<{z(rawcap)} ∧ -{z(rawcap)}<{z(v)} ∧ {z(v)}<{z(rawcap)} ∧ -{z(rawcap)}<{z(rr)} ∧ {z(rr)}<{z(rawcap)} ∧ -{z(rawcap)}<{z(ii)} ∧ {z(ii)}<{z(rawcap)}'
  if complete:rawranges+=f' ∧ -{z(2*cap)}<{z(ab)} ∧ {z(ab)}<{z(2*cap)}'
  nraw=theorem('raw_ranges',rawranges)
  real=f'{z(a)}*{z(c)}-{z(b)}*{z(d)}={z(rr)}'
  imag=f'{z(a)}*{z(d)}+{z(b)}*{z(c)}={z(ii)}'
  reproof=f'''by
  calc
    {z(a)}*{z(c)}-{z(b)}*{z(d)} = {z(c)}*({z(a)}+{z(b)})-{z(b)}*({z(c)}+{z(d)}) := (ArithmeticCalibration.three_real _ _ _ _).symm
    _ = {z(rr)} := by rw [{nab}, {nc}, {np1}, {np2}]; exact {nr}'''
  improof=f'''by
  calc
    {z(a)}*{z(d)}+{z(b)}*{z(c)} = {z(c)}*({z(a)}+{z(b)})+{z(a)}*({z(d)}-{z(c)}) := (ArithmeticCalibration.three_imag _ _ _ _).symm
    _ = {z(ii)} := by rw [{nab}, {nd}, {np1}, {np3}]; exact {ni}'''
  nre=theorem('real_identity',real,reproof)
  nim=theorem('imag_identity',imag,improof)
  scale=f'0<{z(S)} ∧ {z(S)}=2*{z(S//2)}'
  ns=theorem('scale',scale,group='round')
  outr=f'-{z(2*cap)}<{z(qr)} ∧ {z(qr)}<{z(2*cap)} ∧ -{z(2*cap)}<{z(qi)} ∧ {z(qi)}<{z(2*cap)}'
  if complete:
   for value in (qr*S,qi*S,rr+S//2,ii+S//2,qr*S+tr,qi*S+ti):
    outr+=f' ∧ -{z(rawcap)}<{z(value)} ∧ {z(value)}<{z(rawcap)}'
  no=theorem('output_ranges',outr,group='round')
  wr=f'{z(rr)}+{z(S//2)}={z(qr)}*{z(S)}+{z(tr)}'
  wi=f'{z(ii)}+{z(S//2)}={z(qi)}*{z(S)}+{z(ti)}'
  nwr=theorem('round_real_witness',wr,group='round')
  nwi=theorem('round_imag_witness',wi,group='round')
  rem=f'0≤{z(tr)} ∧ {z(tr)}<{z(S)} ∧ 0≤{z(ti)} ∧ {z(ti)}<{z(S)}'
  nrem=theorem('remainder_ranges',rem,group='round')
  rb=f'-{z(S)}≤2*({z(rr)}-{z(qr)}*{z(S)}) ∧ 2*({z(rr)}-{z(qr)}*{z(S)})<{z(S)}'
  ib=f'-{z(S)}≤2*({z(ii)}-{z(qi)}*{z(S)}) ∧ 2*({z(ii)}-{z(qi)}*{z(S)})<{z(S)}'
  nrb=theorem('real_round_bound',rb,f'by exact ArithmeticCalibration.round_interval _ _ _ _ _ {ns}.2 {nwr} {nrem}.1 {nrem}.2.1',group='round')
  nib=theorem('imag_round_bound',ib,f'by exact ArithmeticCalibration.round_interval _ _ _ _ _ {ns}.2 {nwi} {nrem}.2.2.1 {nrem}.2.2.2',group='round')
  final=f'({source}) ∧ ({cache}) ∧ ({rawranges}) ∧ ({outr}) ∧ ({real}) ∧ ({imag}) ∧ ({rb}) ∧ ({ib})'
  nf=theorem('certificate',final,f'by exact ⟨{nsource}, {ncr}, {nraw}, {no}, {nre}, {nim}, {nrb}, {nib}⟩',group='final')
  bundles.append((p,j,names,groups))
  rows.append(dict(p=p,fixture=j,a=str(a),b=str(b),c=str(c),d=str(d),real=str(rr),imag=str(ii),qr=str(qr),qi=str(qi),tr=str(tr),ti=str(ti),theorems=len(names),groups=groups,negative_half_tie=(j==2),input_signed_capacity=p+11,coefficient_signed_capacity=p+2,raw_signed_capacity=2*p+13,output_signed_capacity=p+12))
lines.append('end Fixture\n')
if small:
 audit=''.join(lines)+'\n'+''.join(f'#print axioms Fixture.{names[-1]}\n' for p,j,names,groups in bundles)
 (H/('AxiomComplete.lean' if complete else 'AxiomAudit.lean')).write_text(audit,encoding='utf-8')
lines.append('''namespace Replay
def renamed (names : Array Name) (e : Expr) : Expr := e.replace fun x =>
  match x with
  | .const n us => match names.findIdx? (fun old => old == n) with
    | some i => some (.const (Name.num `Trial i) us)
    | none => none
  | _ => none

def pool (env : Environment) (names : Array Name) : IO (Array Declaration) := do
  let mut ds := #[]
  for i in [:names.size] do
    match env.find? names[i]! with
    | some (.thmInfo v) =>
      let ty := renamed names v.type
      let val := renamed names v.value
      let leftover := (ty.foldConsts false fun n b => b || n.toString.startsWith "Fixture.") || (val.foldConsts false fun n b => b || n.toString.startsWith "Fixture.")
      if leftover then throw (IO.userError "unreplayed fixture auxiliary reference")
      ds := ds.push (.thmDecl {name := Name.num `Trial i, levelParams := v.levelParams, type := ty, value := val})
    | _ => throw (IO.userError s!"missing theorem {names[i]!}")
  return ds

def checkedEnv (base : Kernel.Environment) (ds : Array Declaration) (hb depth : USize) : IO Kernel.Environment := do
  let mut env := base
  let mut count := 0
  for d in ds do
    match env.addDeclCore hb depth d none with
    | .ok next => env := next; count := count+1
    | .error _ => throw (IO.userError s!"kernel rejected auxiliary index {count}")
  return env

def checkBundle (base : Kernel.Environment) (ds : Array Declaration) (hb depth : USize) : IO Nat := do
  discard <| checkedEnv base ds hb depth
  return ds.size

def measurePart (base : Kernel.Environment) (ds : Array Declaration) (label : String) (p f reps : Nat) (hb depth : USize) : IO Unit := do
  let t0 ← IO.monoNanosNow
  let mut accepted := 0
  for _ in [:reps] do
    accepted := accepted + (← checkBundle base ds hb depth)
  let t1 ← IO.monoNanosNow
  IO.println s!"PART,{label},{p},{f},{reps},{ds.size},{accepted},{t1-t0}"

def measure (env : Environment) (names : Array Name) (p f reps : Nat) (hb depth : USize) : IO Unit := do
  let tgen ← IO.monoNanosNow
  let ds ← pool env names
  let tend ← IO.monoNanosNow
  let base := env.toKernelEnv
  discard <| checkBundle base ds hb depth
  -- Change the claimed result by one, preserving the genuine arithmetic proof.
  let corrupt (d : Declaration) : Declaration := match d with
    | .thmDecl v =>
      let xs := v.type.getAppArgs
      let wrong := mkApp2 (mkConst ``Int.add) xs[2]! (mkIntLit 1)
      .thmDecl {v with type := mkAppN v.type.getAppFn #[xs[0]!,xs[1]!,wrong]}
    | _ => d
  let rejects (i : Nat) := match base.addDeclCore hb depth (corrupt ds[i]!) none with
    | .error _ => true
    | .ok _ => false
  let rejected := rejects 5 && rejects 15
  if !rejected then throw (IO.userError "corrupt declaration accepted")
  let t0 ← IO.monoNanosNow
  let mut accepted := 0
  for _ in [:reps] do
    accepted := accepted + (← checkBundle base ds hb depth)
  let t1 ← IO.monoNanosNow
  IO.println s!"RESULT,{p},{f},{reps},{ds.size},{accepted},{rejected},{tend-tgen},{t1-t0}"
  measurePart base (ds.extract 0 4) "setup" p f reps hb depth
  let withSetup ← checkedEnv base (ds.extract 0 4) hb depth
  measurePart withSetup (ds.extract 4 13) "product" p f reps hb depth
  measurePart base (ds.extract 13 20) "round" p f reps hb depth
  let withAll ← checkedEnv base (ds.extract 0 20) hb depth
  measurePart withAll (ds.extract 20 21) "final_assembly" p f reps hb depth
  IO.println s!"CONTROL,{p},{f},product_plus_one={rejects 5},round_plus_one={rejects 15},no_fixture_refs=true"
  (← IO.getStdout).flush

elab "#arithmetic_calibration" : command => do
  let env ← getEnv
  let opts ← getOptions
  let hb := (Lean.Core.getMaxHeartbeats opts).toUSize
  let depth := (maxRecDepth.get opts).toUSize
  liftM <| IO.println s!"LIMITS,trust={env.header.trustLevel},heartbeats={hb},recdepth={depth}"
''')
for p,j,names,groups in bundles:
 literal='#['+', '.join('``Fixture.'+n for n in names)+']'
 lines.append(f'  liftM <| measure env {literal} {p} {j} 100 hb depth\n')
lines.append('end Replay\n#arithmetic_calibration\n')
source=''.join(lines)
(H/('ArithmeticComplete.lean' if complete else 'ArithmeticSmall.lean' if small else 'ArithmeticCalibration.lean')).write_text(source,encoding='utf-8')
(H/'Baseline.lean').write_text('import Lean.Elab.Command\nimport Lean.Elab.Tactic.Omega\n',encoding='utf-8')
(H/('complete_fixture_metadata.json' if complete else 'small_fixture_metadata.json' if small else 'fixture_metadata.json')).write_text(json.dumps({'fixtures':rows,'generation_seconds':time.perf_counter()-start,'source_sha256':hashlib.sha256(source.encode()).hexdigest().upper(),'source_bytes':len(source.encode()),'not_spectral_values':True},indent=2)+'\n')
print(json.dumps({'source_bytes':len(source.encode()),'fixtures':len(rows),'generation_seconds':time.perf_counter()-start}))
