from pathlib import Path
import hashlib,re
p=Path(__file__).resolve().parent
def read(path): return path.read_text(encoding='utf-8-sig')
def digest(path): return hashlib.sha256(path.read_bytes()).hexdigest()
old=read(p/'history/exphorner01/SourceExpHornerScript.sml')
new=read(p/'SourceExpHornerScript.sml')
pat=r'Theorem\s+(\w+):\s*\n(.*?)\nProof\n'
assert re.findall(pat,old,re.S)==re.findall(pat,new,re.S)
assert re.findall(r'Definition .*?\nEnd',old,re.S)==re.findall(r'Definition .*?\nEnd',new,re.S)
assert (p/'exp_horner_audit.sml').read_bytes()==(p/'history/exphorner01/exp_horner_audit.sml').read_bytes()
lines=[]
for line in read(p/'source_expected.sha256').splitlines():
    expected,name=line.split('  ',1)
    actual=digest(p/name)
    if name!='SourceExpHornerScript.sml': assert actual==expected,name
    lines.append(actual+'  '+name+'\n')
(p/'source_expected.sha256').write_text(''.join(lines),encoding='utf-8',newline='\n')
print('All twelve statements, three definitions and fixed audit unchanged; repaired proof body pinned.')
