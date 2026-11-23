"""Construct the six 128-cell seed batches for the +640 guarded height schedule."""
from hashlib import sha256
from pathlib import Path
from time import process_time
import json

from produce import (F, HERE, P, S, bernoulli, coordinates, envelope, needed,
                     power_phase, root_and_step)
from cases import zig
from normalize import parameters, supplied, translated
from panel import OUTPUT_BITS, ORDER, seed
from seed_em import schedule
from flint import ctx


WIDTH = 128
RADIUS = WIDTH // 2


def emit(out, values):
    print(*values, file=out)


def main():
    ctx.prec, ctx.threads = 510, 1
    source = HERE.parent / "guard-repricing/guard.json"
    bands = json.loads(source.read_bytes())["scenarios"]["640"]["bands"]
    records, tables = [], []
    with (HERE/"normalized-cases.txt").open("w", encoding="ascii", newline="\n") as out:
        for i, band in enumerate(bands, 1):
            grid = band["cells"] - 1
            lo, hi = band["lo"], band["hi"]
            assert grid % WIDTH == 0
            j = hi - 1
            degree, bits, translation_bound = parameters(grid, j, WIDTH)
            tasks = schedule(grid, hi, degree, bits, RADIUS)
            limits = needed(tasks)
            error = envelope(grid, j, tasks, radius=RADIUS, output_bits=bits)
            assert error < F(1, 32)
            # Landing exactly at the upper mesh endpoint exercises both |u|=1 cases.
            center = grid - RADIUS
            start = process_time()
            phases = [power_phase(*root_and_step(grid*(n+1)+center, grid), j)
                      for n in range(limits[0])]
            ready = process_time()
            result = coordinates(grid, center, j, tasks, phases, radius=RADIUS,
                                 output_bits=bits)
            stop = process_time()
            reference = supplied(grid, center, j, RADIUS, degree, bits)
            diff = max(abs(x-y) for a,b in zip(result,reference,strict=True)
                       for x,y in zip(a,b,strict=True))
            assert diff <= 1
            translated_differences = {}
            for d in (-RADIUS, 0, RADIUS-1, RADIUS):
                fine = translated(result, RADIUS, d, bits)
                direct = seed(grid, center+d, j, ORDER-1, OUTPUT_BITS)
                delta = max(abs(x-y) for a,b in zip(fine,direct,strict=True)
                            for x,y in zip(a,b,strict=True))
                assert delta <= 1
                translated_differences[d] = delta
            bs = bernoulli(max(l for _,l in tasks))[1:]
            emit(out,[i, grid, center, j, RADIUS, bits])
            emit(out,(z for (n,l),k in zip(tasks,limits[1:],strict=True) for z in (n,l,k)))
            emit(out,(zig(z) for pair in phases for z in pair))
            emit(out,(zig(z) for b in bs for z in (b.numerator,b.denominator)))
            emit(out,(zig(z) for pair in result for z in pair))
            count = (grid//WIDTH)*(hi-lo)
            records.append(dict(band=i,grid=grid,lo=lo,hi=hi,degree=degree,seed_bits=bits,
                                groups=count,phase_states=limits[0],
                                finite_terms=sum(n for n,_ in tasks),
                                corrections=sum(l for _,l in tasks),scalar_steps=sum(limits[1:]),
                                base_pairs=(grid//WIDTH)*limits[0],phase_start_cpu=ready-start,
                                row_cpu=stop-ready,arithmetic_error_seed_units=float(error),
                                uniform_seed_bound_units=float(error+F(1,32)+F(3,4)),
                                truncation_and_seed_translation_bound94=translation_bound,
                                max_seed_delta=diff,translation_delta=translated_differences))
            tables.append(dict(band=i,grid=grid,j=j,center=center,radius=RADIUS,seed_bits=bits,
                               degree=degree,seeds=result))
            print(i,degree,bits,limits[0],diff,translated_differences,flush=True)
    (HERE/"normalized-seeds.json").write_text(json.dumps(tables,separators=(",",":"))+"\n")
    counts={k:sum(r["groups"]*r[k] for r in records)
            for k in ("phase_states","finite_terms","corrections","scalar_steps")}
    counts["base_pairs"]=sum(r["base_pairs"] for r in records)
    counts["groups"]=sum(r["groups"] for r in records)
    digest=lambda p:sha256(p.read_bytes()).hexdigest()
    output=dict(working_bits=P,width=WIDTH,radius=RADIUS,bands=records,counts=counts,
                endpoint="The last group also owns the upper endpoint at displacement +64.",
                hashes={p.name:digest(p) for p in
                        (source,HERE/"normalized-cases.txt",HERE/"normalized-seeds.json")})
    (HERE/"normalized-counts.json").write_text(json.dumps(output,indent=2)+"\n")
    print(counts)


if __name__=="__main__":
    main()
