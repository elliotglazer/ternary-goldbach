"""Split only evaluation certificates, preserving the full verified tree."""
import re
from pathlib import Path
H=Path(__file__).resolve().parent
text=(H/'BatchData1024.lean').read_text(encoding='utf-8')
nodes=re.findall(r'^def (certificates_\d+) : BatchPrime.Tree := (.+)$',text,re.M)
size=16;parts=[]
for start in range(0,len(nodes),size):
    part=f'BatchValidPart{start//size:02}'
    previous=parts[-1] if parts else 'BatchData1024'
    lines=[f'import {previous}','set_option maxRecDepth 65536','set_option maxHeartbeats 0',
           'namespace FiniteBatch1024','open BatchPrime BatchData1024']
    for name,rhs in nodes[start:start+size]:
        number=name.rsplit('_',1)[1]
        match=re.fullmatch(r'BatchPrime.Tree.node (certificates_\d+) (\d+) (\d+) (\[[\d, ]*\]) (certificates_\d+)',rhs)
        declaration=f'theorem valid_{number} : treeValid certificates {name} = true := '
        if match:
            left,p,a,fs,right=match.groups()
            lines += [declaration+'by',
                      f'  have hn : nodeValid certificates {p} {a} {fs} = true := by decide +kernel',
                      f'  exact treeValid_node valid_{left.rsplit("_",1)[1]} hn valid_{right.rsplit("_",1)[1]}']
        else:
            lines.append(declaration+'by decide +kernel')
    lines.append('end FiniteBatch1024')
    (H/f'{part}.lean').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')
    parts.append(part)
block=(H/'BatchBlock1024.lean').read_text(encoding='utf-8')
block=block.replace('import BatchData1024',f'import {parts[-1]}')
block=block.replace('theorem valid : treeValid certificates certificates = true := by decide +kernel',
                    f'theorem valid : treeValid certificates certificates = true := valid_{nodes[-1][0].rsplit("_",1)[1]}')
(H/'BatchBlock1024.lean').write_text(block,encoding='utf-8',newline='\n')
print(f'{len(nodes)} data definitions, {len(parts)} bounded evaluation modules')
