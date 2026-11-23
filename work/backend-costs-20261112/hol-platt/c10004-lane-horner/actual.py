from benchmark import *
data=(here.parent/"c10004-p20-slab/slab.json").read_bytes()
assert hashlib.sha256(data).hexdigest()=="ed4ad0e7516fedcb62bf7fec7cc94076b4222d80ce7c7238fcc47d2b5ef54d05"
slab=json.loads(data)
assert len(slab["rows"])==64
def input_rows(cell):
    return [[pair[c] for pair in reversed(h["mixed"][cell])] for h in slab["rows"] for c in range(2)]
rows={cell:input_rows(cell) for cell in slab["cells"]}
res=[(cell,a) for cell,aa in slab["cells"].items() for a in aa]
def coeffs():
    return {cell:coefficient_pack(input_rows(cell)) for cell in rows}
def setup():
    return [residual_setup(128,residual(a)) for cell,a in res]
cs,ops=coeffs(),setup()
def execute(cs,ops):
    return [evaluate((cs[cell],op,STRIDE,128),residual(a)) for (cell,a),op in zip(res,ops)]
def transpose(zz):
    decoded=[discharge(z,(0,0,STRIDE,128)) for z in zz]
    return [[(row[2*h],row[2*h+1]) for row in decoded] for h in range(64)]
def scalar():
    decoded=[reference(rows[cell],residual(a)) for cell,a in res]
    return [[(row[2*h],row[2*h+1]) for row in decoded] for h in range(64)]
zz=execute(cs,ops)
actual=transpose(zz)
assert actual==scalar()
for j,(cell,a) in enumerate(res):
    p,z=check(rows[cell],residual(a))
    assert z==zz[j]
    for h in range(64):
        expected=next(v[1:] for v in slab["rows"][h]["outputs"][cell] if v[0]==a)
        assert actual[h][j]==tuple(64*x for x in expected)
print("448 matched height/residue complex outputs")
for label,f in [("scalar_including_transpose",scalar),("pack_two_cells",coeffs),
 ("setup_seven_residues",setup),("hot_seven_residues",lambda:execute(cs,ops)),
 ("unpack_transpose_64h7a",lambda:transpose(zz)),("reuse",lambda:transpose(execute(cs,ops))),
 ("cold",lambda:transpose(execute(coeffs(),setup())))]:
    print(label,timed(f,6))
