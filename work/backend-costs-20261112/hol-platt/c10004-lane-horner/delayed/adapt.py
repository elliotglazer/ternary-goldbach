from pathlib import Path
p=Path("generate.py")
s=p.read_text()
a=s.index("factors=[")
b=s.index("def lit(")
s=s[:a]+'''pin=json.loads((here.parent.parent/"c10004-exact-horner/h1-8-a5.json").read_text())
degree=len(pin["columns"])-1
skip=19-degree
assert all(not any(row[:skip]) for row in rows)
rows=[row[skip:] for row in rows]
factors=[(1<<(94-g))*v**p for p,g in enumerate(reversed(slab["grids"][:degree+1]))]
B=1<<(8*pin["width_bytes"])
one=sum(B**i for i in range(n))
offset=one*(B//2)
cols=[sum(row[i]*f*B**j for j,row in enumerate(rows)) for i,f in enumerate(factors)]
assert cols==list(reversed(pin["columns"]))
z=cols[0]
xs=[row[0]*factors[0] for row in rows]
for i in range(1,degree+1):
    z=r*z+cols[i]
    xs=[r*x+row[i]*factors[i] for row,x in zip(rows,xs)]
    assert max(map(abs,xs))<B//2
    assert all((z+offset)//(B**j)%B-B//2==x for j,x in enumerate(xs))
assert z==pin["packed_numerator"]
den=v**degree
out=[(x+den//2)//den for x in xs]
assert out==[x for pair in pin["centers"] for x in pair]
'''+s[b:]
a=s.index('df("packc"')
b=s.index('df("round_final"')
s=s[:a]+'''df("packc",f"(packc ([]:int list) (f:int) = 0:int) /\\\\ (packc (x::xs) f = x*f + &{B}*packc xs f)")
df("columns","(columns ([]:int list) rows = []) /\\\\ (columns (f::fs) rows = packc (heads rows) f :: columns fs (tails rows))")
df("step","(step ([]:int list) (z:int) = z) /\\\\ (step (x::xs) z = step xs (x-4884*z))")
df("evalp","(evalp ([]:int list) = 0:int) /\\\\ (evalp (x::xs) = step xs x)")
'''+s[b:]
s=s.replace('x+&','x + &').replace(')-&{bias[-1]}',') - &{B//2}').replace('L(cols)+" : num list"','L(map(lit,cols))+" : int list"').replace('f"columns factors rows (&{A})"','"columns factors rows"').replace('L(cols)+" :num list"','L(map(lit,cols))+" :int list"').replace('f"{z}:num"','f"{lit(z)}:int"').replace('f"decode {n} (evalp cached)"','f"decode {n} (Num (evalp cached + &{offset}))"').replace('f"decode {n} (evalp (columns factors rows (&{A})))"','f"decode {n} (Num (evalp (columns factors rows) + &{offset}))"')
p.write_text(s)
