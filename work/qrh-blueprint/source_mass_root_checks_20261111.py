"""Independent scalar/label metadata; no spectral or prover execution."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
import json
import re

HERE=Path(__file__).resolve().parent
ROOT=HERE.parent.parent
AGENTS=ROOT/'work/qrh-campaign/agents'
pins={
 'prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md':'429562CD92AF356BD84EED1C253D0A9E95D434262DF08CCCAC8EAF3D15CE234D',
 'major-constants/REVIEW_EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md':'0B224BB58D88D63D9F787D88CA1CB33CA85C411DB8B733307064AE8D82EA84BD',
 'prime-estimates/source_mass_joint_cutoff_20261111.json':'67F6C3BAE93EDE7BD93C49A4EC8B442671A921D9E71B5AEC4925031261984FC9',
 'integration/EXACT_MASS_TAIL_SOURCE_JOIN_2026-11-11.md':'7BCBA7142E2B069ABEFB3F1FD6490DE00F3BFCEC0E4D6FAC1140DB88F048DE8E',
}
for name,h in pins.items():assert sha256((AGENTS/name).read_bytes()).hexdigest().upper()==h
source=ROOT/'work/ternary-goldbach/TernaryGoldbach/Prelim/SmallMuPhi.lean'
assert sha256(source.read_bytes()).hexdigest().upper()=='7ECE1D48D9679ECF529A5566C79D06FADB3CA70CCAF057ADAA020D6AA390BADF'
lt=int(re.search(r'theorem c_132 : Lt 132000 = (\d+)',source.read_text(encoding='utf-8')).group(1))
j=json.loads((AGENTS/'prime-estimates/source_mass_joint_cutoff_20261111.json').read_text(encoding='utf-8'))
row=next(r for r in j['rows'] if r['R']==132900)
def val(x):return F(int(x['num']),int(x['den']))
mass=F(2*lt,10**18)
assert mass==val(row['mass_lower'])
i_bound=(F(638108,10**6)*mass-F(108,10**5)-100001*F(8,10**11))/F(100001,100000)
assert i_bound==val(row['I_lower'])
nonprime=F(20618162523,7784250095800)
minors=[val(cell['minor_upper']) for cell in row['cells']]+[val(row['asymptotic_minor'])]
margin=val(row['major_lower'])-max(minors)-nonprime
assert margin==val(row['joint_margin']) and margin>F(13565,10**7)

# Integer divisor identities, independent of factor-local primitive formula.
bound=300000
phi=list(range(bound+1))
for d in range(1,bound+1):
    for n in range(2*d,bound+1,d):phi[n]-=phi[d]
primitive=phi.copy()
for d in range(1,bound+1):
    for n in range(2*d,bound+1,d):primitive[n]-=primitive[d]
labels={}
for r in (150000,138000,135000,132900):
    conductors=list(range(3,r+1,2))+list(range(4,2*r+1,4))
    labels[str(r)]={'conductor_indices':len(conductors),'primitive_labels':sum(primitive[c] for c in conductors)}
assert labels['150000']['primitive_labels']==5543640187
assert labels['138000']['primitive_labels']==4692136729
ratio=F(labels['132900']['primitive_labels'],labels['150000']['primitive_labels'])
out={'scope':'source checkpoint identity, scalar composition and independent divisor metadata only',
     'pins':pins,'mass_lower':str(mass),'I_lower':str(i_bound),'margin':str(margin),
     'labels':labels,'retained_label_ratio':str(ratio),'retained_label_ratio_display':float(ratio),
     'full_spectral_inventory':False,'kernel_check':False}
(HERE/'source_mass_root_checks_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'labels':labels,'retained_label_ratio':float(ratio),'margin':float(margin)},indent=2))
