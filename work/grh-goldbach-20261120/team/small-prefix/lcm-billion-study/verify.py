from pathlib import Path
import re,hashlib,json,math
d=Path(__file__).resolve().parent
s=(d/'Power9.lean').read_text(encoding='utf8')
t=(d.parent/'compact-prefix/Power9.lean').read_text(encoding='utf8')
def body(x):
    start=x.index('def rows0 :')
    rows=[r.split(',') for r in re.findall('⟨([^⟨⟩]+)⟩',x[start:])]
    assert len(rows)==1908 and all(len(r)==4 for r in rows)
    return [r[:3] for r in rows],x[x.index('theorem binaryGoldbachUpTo :'):].split(':=')[0]
assert body(s)==body(t)
def fac(x):
    f=x.split('def fac : Nat := ')[1].splitlines()[0]
    return int(re.search('[0-9a-f]{100,}',f)[0],16)
z=dict(rows_identical=1908,statement_identical=True,anchor_occurrences=129075,source_bytes_new=len(s.encode()),source_bytes_control=len(t.encode()),
       lcm_bits=fac(s).bit_length(),factorial_bits=fac(t).bit_length(),
       lcm_hex_matches=fac(s)==math.lcm(*range(1,31623)),factorial_matches=fac(t)==math.factorial(31622))
assert z['lcm_hex_matches'] and z['factorial_matches']
(d/'coverage.json').write_text(json.dumps(z,indent=2))
print(z)
