"""Adapt pinned local four-character benchmark, preserving interval arithmetic."""
import json
import sys
from pathlib import Path

team = Path(__file__).resolve().parent
parent = team.parents[1]/'backend-costs-20261112/hol-platt'
base = parent/'full-height-count'
out = team/'q10004-gaussian'
out.mkdir(exist_ok=True)
sys.path.insert(0,str(out))
sys.path.insert(1,str(parent/'one-character-completeness'))
sys.path.insert(2,str(parent/'small-character-kernel'))
def replace(s,a,b):
    assert s.count(a)==1,a
    return s.replace(a,b)

s=(base/'spectrum.py').read_text()
s=replace(s,'Q = 10000','Q = 10004')
s=replace(s,'BASE_LABELS = (3, 11)','BASE_LABELS = (6559, 5499)')
s=s[:s.index('    cases =')]+'    return 84199, 84839, 524288, 68267, 64\n\n'+s[s.index('def phase_and_weights'): ]
s=replace(s,'second = (-200*z).exp()','second = (-8*z).exp()')
s=replace(s,'for residue in (1,3,7,9):','for residue in (1,):')
s=replace(s,'m+1,240','m+1,48')
s=replace(s,'20*i0+100','4*i0+4')
s=replace(s,'min(i0+240,m+1),10','min(i0+48,m+1),2')
s=replace(s,'[SOURCE,Path(__file__),HERE/"coefficients.tsv"]','[Path(__file__),HERE/"coefficients.tsv"]')
(out/'spectrum.py').write_text(s)
g=(base/'grid.py').read_text()
(out/'grid.py').write_text(g)
r=(base/'repair.py').read_text()
r=replace(r,'SUB = 4096','SUB = 20480')
r=replace(r,'GUARDS = (167,320,640)','GUARDS = (320,640)')
r=replace(r,'    for extra in GUARDS:', '    main = F(6578*64,5)\n    for extra in GUARDS:')
r=replace(r,'edges = {1,main*SUB-1,main*SUB+1,*((main+e)*SUB-1 for e in GUARDS)}','target = 6578*64*(SUB//5)\n        edges = {1,target-1,target+1,*(target+e*SUB-1 for e in GUARDS)}')
r=replace(r,'T=str(F(5*main,64))','T="6578"')
r=replace(r,'W_ticks=weight','W_ticks=int(weight)')
(out/'repair.py').write_text(r)
import spectrum,grid,repair
assert spectrum.LABELS==(6559,7707,5499,7659)
if __name__=='__main__':
    for stage in (spectrum,grid,repair):
        print(stage.__name__,flush=True)
        stage.run()
