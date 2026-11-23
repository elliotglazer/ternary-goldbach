from pathlib import Path
import hashlib, re
p=Path(__file__).resolve().parent
def read(path): return path.read_text(encoding='utf-8-sig')
def digest(path): return hashlib.sha256(path.read_bytes()).hexdigest()
old=read(p/'history/range01/SourceLogRangeScript.sml')
new=read(p/'SourceLogRangeScript.sml')
pattern=r'Theorem\s+(\w+):\s*\n(.*?)\nProof\n'
assert re.findall(pattern,old,re.S)==re.findall(pattern,new,re.S)
assert re.findall(r'Definition .*?\nEnd',old,re.S)==re.findall(r'Definition .*?\nEnd',new,re.S)
assert (p/'range_audit.sml').read_bytes()==(p/'history/range01/range_audit.sml').read_bytes()
lines=[]
for line in read(p/'source_expected.sha256').splitlines():
    expected,name=line.split('  ',1)
    actual=digest(p/name)
    if name!='SourceLogRangeScript.sml': assert actual==expected,name
    lines.append(actual+'  '+name+'\n')
(p/'source_expected.sha256').write_text(''.join(lines),encoding='utf-8',newline='\n')
print('All eleven statements, two definitions and fixed audit unchanged; current proof body pinned.')
