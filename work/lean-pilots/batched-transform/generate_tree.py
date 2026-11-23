"""Balanced stage assembly using the same 256 input/output literals."""
from pathlib import Path
H=Path(__file__).resolve().parent
p,n,size=343,256,16
case=f'P{p}N{n}'
data=[f'import Data{case}','open BatchedTransform',f'open Data{case}',f'namespace TreeData{case}']
proof=[f'import TreeData{case}','import StageFast','open BatchedTransform',
       f'open Data{case} TreeData{case}',f'namespace TreeChunk16{case}']
names=[]
def node(lo,hi):
    label=f'n{lo}_{hi}'
    if hi-lo<=size:
        xs='['+', '.join(f'x{k}' for k in range(lo,hi))+']'
        ys='['+', '.join(f'y{k}' for k in range(lo,hi))+']'
        body='by decide +kernel'
    else:
        mid=(lo+hi)//2
        left=node(lo,mid); right=node(mid,hi)
        xs=f'xs_{left} ++ xs_{right}'
        ys=f'ys_{left} ++ ys_{right}'
        body=f'checkStage_append scale bound xs_{left} xs_{right} ys_{left} ys_{right} checked_{left} checked_{right}'
    data.extend([f'def xs_{label} : List Input := {xs}',f'def ys_{label} : List Output := {ys}'])
    proof.append(f'theorem checked_{label} : checkStage scale bound xs_{label} ys_{label} = true := {body}')
    names.append(f'TreeChunk16{case}.checked_{label}')
    return label
root=node(0,n)
proof.extend([f'theorem certified : stage_spec scale bound xs_{root} ys_{root} :=',
              f'  checkStage_sound scale bound xs_{root} ys_{root} checked_{root}',f'end TreeChunk16{case}'])
names.append(f'TreeChunk16{case}.certified')
data.append(f'end TreeData{case}')
(H/f'TreeData{case}.lean').write_text('\n'.join(data)+'\n',encoding='utf-8')
(H/f'TreeChunk16{case}.lean').write_text('\n'.join(proof)+'\n',encoding='utf-8')
(H/f'ReplayTreeChunk16{case}.lean').write_text(
    f'import TreeChunk16{case}\nimport Replay\n#replay_stage "TreeChunk16" {p} {n} 10 ['+
    ', '.join(names)+']\n',encoding='utf-8')
