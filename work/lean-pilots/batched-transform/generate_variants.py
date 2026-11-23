"""Alternative certificate encodings for the identical checked stage data."""
from pathlib import Path
import sys
HERE=Path(__file__).resolve().parent

def generate(p,n):
    case=f'P{p}N{n}'
    for variant in ['Fast','FastScalar','Chunk8','Chunk16','Chunk32']:
        text=[f'import Data{case}','import StageFast','open BatchedTransform',
              f'open Data{case}',f'namespace {variant}{case}']
        names=[]
        def add(name,ty,proof='by decide +kernel'):
            text.append(f'theorem {name} : {ty} := {proof}')
            names.append(f'{variant}{case}.{name}')
        if variant.startswith('Fast'):
            add('scale_pos','0 < scale','by decide')
            add('scale_even',f'scale = 2*({2**(p-1)} : Int)','by decide')
            if variant=='Fast':
                add('checked',f'checkFastStage scale {2**(p-1)} bound inputs outputs = true')
                add('certified','stage_spec scale bound inputs outputs',
                    f'checkFastStage_sound scale {2**(p-1)} bound scale_pos scale_even inputs outputs checked')
            else:
                for k in range(n):
                    add(f'fast_{k}',f'checkFast scale {2**(p-1)} bound x{k} y{k} = true')
                    add(f'row_{k}',f'checkOne scale bound x{k} y{k} = true',
                        f'checkFast_implies_checkOne scale {2**(p-1)} bound scale_pos scale_even x{k} y{k} fast_{k}')
                term='rfl'
                for k in reversed(range(n)):
                    term=f'(checkStage_cons scale bound x{k} y{k} _ _ row_{k} {term})'
                add('checked','checkStage scale bound inputs outputs = true',term)
                add('certified','stage_spec scale bound inputs outputs',
                    'checkStage_sound scale bound inputs outputs checked')
        else:
            size=int(variant[5:])
            chunks=list(range(0,n,size))
            for j,start in enumerate(chunks):
                xs='['+', '.join(f'x{k}' for k in range(start,min(start+size,n)))+']'
                ys='['+', '.join(f'y{k}' for k in range(start,min(start+size,n)))+']'
                add(f'chunk_{j}',f'checkStage scale bound {xs} {ys} = true')
            term='rfl'
            for j in reversed(range(len(chunks))):
                term=f'(checkStage_append scale bound _ _ _ _ chunk_{j} {term})'
            add('checked','checkStage scale bound inputs outputs = true',term)
            add('certified','stage_spec scale bound inputs outputs',
                'checkStage_sound scale bound inputs outputs checked')
        text.append(f'end {variant}{case}')
        (HERE/f'{variant}{case}.lean').write_text('\n'.join(text)+'\n',encoding='utf-8')
        (HERE/f'Replay{variant}{case}.lean').write_text(
            f'import {variant}{case}\nimport Replay\n#replay_stage "{variant}" {p} {n} 10 ['+
            ', '.join(names)+']\n',encoding='utf-8')

if __name__=='__main__':
    generate(int(sys.argv[1]),int(sys.argv[2]))
