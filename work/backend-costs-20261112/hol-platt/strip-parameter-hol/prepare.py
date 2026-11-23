"""Marshal literal packet fields and untrusted witnesses into HOL source."""
from hashlib import sha256
from pathlib import Path
import json

here=Path(__file__).resolve().parent
src=here.parent/"guard-repricing"
w=json.loads((src/"strip-parameter-witnesses.json").read_bytes())
panel_bytes=(src/"strip-repair-panel-stress.json").read_bytes()
packet=(src/"strip-repair-packets-stress.tsv").read_bytes()
assert sha256(packet).hexdigest()==w["packet_sha256"] and sha256(panel_bytes).hexdigest()==w["panel_sha256"]
panel=json.loads(panel_bytes)
channels={(row["q"],c["label"]):(c["parity"],row["coarse_intervals"]//len(row["channels"]))
          for row in panel["rows"] for c in row["channels"]}
for row in panel["rows"]:
    assert row["coarse_intervals"]%len(row["channels"])==0
def lit(x):
    if isinstance(x,list): return "["+";".join(map(lit,x))+"]"
    return str(x) if x>=0 else f"(-{abs(x)})"
def tup(xs):
    return "("+",".join(map(lit,xs))+")"

out=['Theory StripParameterAcceptance','Ancestors StripParameter integer arithmetic list','Libs intLib',
     'val timer = Timer.startCPUTimer();',
     'fun stamp s = let val {usr,sys}=Timer.checkCPUTimer timer in print ("PARAMETER_TIME "^s^" "^Time.toString(Time.+(usr,sys))^"\\n") end;',
     'fun prove_true name tm = save_thm(name,EQT_ELIM(EVAL tm));',
     'val _=stamp "start";']
def definition(name,typ,value):
    out.extend([f"Definition {name}_def:",f"  {name} : {typ} = {tup(value)}","End"])
for g in w["geometries"]:
    name=f'sg{g["id"]}'
    definition(name,"int#int#num#int list#num",[g[k] for k in ("offset","sub","bits","weights","node_distance_product")])
    out.append(f'val {name}_ok=prove_true "{name}_ok" ``geometry {name}``;'.replace('\\`','`'))
out.append('val _=stamp "geometries";')
for g in w["mass_bounds"]:
    name=f'sm{g["id"]}'
    definition(name,"num#num#num#num#num#num#num",[g[k] for k in ("q","parity","b","last","mass","radical_upper","damping_exponent")])
    out.append(f'val {name}_ok=prove_true "{name}_ok" ``mass {name}``;'.replace('\\`','`'))
out.append('val _=stamp "mass";')
for i,(line,ref) in enumerate(zip(packet.splitlines(),w["refs"],strict=True)):
    vals=list(map(int,line.split()))
    q,label,tick,sub,exp,bits,claimed,sg=vals[:8]
    assert [q,label,tick,exp]==[ref[j] for j in (0,1,2,5)] and len(vals)==32
    p=f"sp{i}"
    geo,mass=f"sg{ref[3]}",f"sm{ref[4]}"
    definition(p,"num#num#num#num#int#num#num#int#int list#int list",vals[:8]+[vals[8:20],vals[20:]])
    cond=tup((q,label,*channels[q,label]))
    out.append(f'val _=save_thm("{p}_accepted",LIST_CONJ [{geo}_ok,{mass}_ok,EQT_ELIM(EVAL ``row {p} {cond} {geo} {mass}``)]);'.replace('\\`','`'))
out.append('val _=stamp "packets";')
(here/"StripParameterAcceptanceScript.sml").write_bytes(("\n".join(out)+"\n").encode())
print(len(w["geometries"]),len(w["mass_bounds"]),len(w["refs"]),w["packet_sha256"])
