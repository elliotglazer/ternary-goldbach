"""Compare three rows against FLINT's scalar Dirichlet L-function API."""
import csv
import json
from pathlib import Path
from time import process_time

from flint import acb, arb, ctx, dirichlet_char

HERE = Path(__file__).resolve().parent


def main():
    ctx.prec, ctx.threads = 144, 1
    q, j, scale = 131071, 5695, 1<<28
    t = arb(5*j)/64
    s = acb(arb(1)/2, t)
    root = 3
    inv = pow(int(dirichlet_char(q,root).chi_exponent(root)), -1, q-1)
    results = []
    with (HERE/"axis257-grid28.tsv").open() as f:
        rows = list(csv.DictReader(f,delimiter="\t"))
    for a in [0, 128, 256]:
        row = {name:int(x) for name,x in rows[a].items()}
        k = row["k"]
        label = pow(root,k*inv%(q-1),q)
        chi = dirichlet_char(q,label)
        assert chi.chi_exponent(root) == k and chi.is_primitive()
        start = process_time()
        z = acb(q)**s * chi.l(s)
        cpu = process_time()-start
        box = acb(arb(row["ref_re"],1),arb(row["ref_im"],1))/scale
        assert box.contains(z)
        phases = [acb(arb(row[p],1),arb(row[g],1))/scale for p,g in [("p","q"),("f","g")]]
        h = phases[0]*phases[1]*z
        assert h.imag.contains(0) and int(h.real>0)-int(h.real<0) == row["sign"]
        results.append(dict(k=k,conrey=label,t=str(t),scalar_spectrum=str(z),completed=str(h),
                            sign=row["sign"],cpu_s=cpu))
        (HERE/"direct-reference.json").write_text(json.dumps(results,indent=2)+"\n")
        print("scalar direct check",k,label,cpu,flush=True)


if __name__ == "__main__":
    main()
