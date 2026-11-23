"""Independent exact polynomial identities, geometry and sizes. No seed values."""
from pathlib import Path
from fractions import Fraction as F
from math import comb
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
OWN = Path(__file__).resolve().parent
AUTHOR = ROOT / 'work/qrh-campaign/agents/integration'
EXPECTED = {
    'EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md': '691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025',
    'check_exact_residue_difference_20261111.py': 'A33EB58C3D0ED9F6494142433C0B96F5D6FCBE58C919D4ECDE384018175DA099',
    'exact_residue_difference_20261111.json': '9D38144A3343C2C3D1A84A83753B8010AB1219BDFD5403DB4C4B0FC488D6F330',
    'check_screened_residue_difference_20261111.py': 'E25D5B12A5DEE0273B2FB82340D7C3D55A4E6FF0CBEA9D00BEF6786FA82B359B',
    'screened_residue_difference_20261111.json': 'B3658790344899BE28DB5B9CBD00793084152418E0DDA74674B521879E4556D5',
}
checks = 0
def check(p):
    global checks
    assert p
    checks += 1
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def ceildiv(a,b): return -((-a)//b)

for name, value in EXPECTED.items(): check(sha(AUTHOR/name) == value)
saved = json.loads((AUTHOR/'exact_residue_difference_20261111.json').read_text())
for name, value in saved['pins'].items(): check(sha(ROOT/name) == value)
extra = json.loads((AUTHOR/'screened_residue_difference_20261111.json').read_text())
for name, value in extra['pins'].items(): check(sha(ROOT/name) == value)

# Independent cell-partition test, including exact ties and endpoint cells.
ties = 0
for c in range(2,81):
    for grid in [2,4,8,16,32]:
        seen = []
        for k in range(grid+1):
            lo = max(1,ceildiv((2*k-1)*c,2*grid))
            hi = min(c-1,ceildiv((2*k+1)*c,2*grid)-1)
            for a in range(lo,hi+1):
                check((2*grid*a+c)//(2*c) == k)
                h = F(grid*a-k*c,2*c)
                check(-F(1,4) <= h < F(1,4))
                ties += h == -F(1,4)
                seen.append(a)
        check(seen == list(range(1,c)))

# Independent binomial formula for each live slot, with actual array pruning.
# Basis monomials are exact symbolic arithmetic fixtures, not analytic data.
blocks = [(100003,1024,500),(265800,1024,512),(265800,2048,1000)]
states_checked = 0
for c,grid,k in blocks:
    left = max(1,ceildiv((2*k-1)*c,2*grid))
    right = min(c-1,ceildiv((2*k+1)*c,2*grid)-1)
    for length in [20,21,right-left+1]:
        check(left+length-1 <= right)
        for degree in range(20):
            def value(n): return (grid*(left+n)-k*c)**degree*(2*c)**(19-degree)
            def diff(n,j): return sum((-1)**(j-v)*comb(j,v)*value(n+v) for v in range(j+1))
            state = [diff(0,j) for j in range(20)]
            updates = 0
            for n in range(length):
                check(len(state) == min(19,length-1-n)+1)
                for j,z in enumerate(state):
                    check(z == diff(n,j))
                    states_checked += 1
                    check(abs(z) <= 2**j*(2*c)**19)
                if n+1 < length:
                    next_count = min(19,length-2-n)+1
                    for j in range(min(19,next_count)):
                        state[j] += state[j+1]
                        updates += 1
                    state = state[:next_count]
            check(updates == 19*length-190)

# Separate full-state endpoint method. Explicitly use the occupancy ties-DOWN
# convention, and check all live higher slots, including polynomial-only points.
full_slots = 0
for c,grid in [(20483,1024),(20484,1024),(265800,8192)]:
    check(c > 20*grid)
    for k in [0,grid]:
        left = max(1,((2*k-1)*c)//(2*grid)+1)
        right = min(c-1,((2*k+1)*c)//(2*grid))
        length = right-left+1
        check(0 < length < 20)
        for a in range(left,right+1):
            check((2*grid*a+c-1)//(2*c) == k)
            check(-F(1,4) < F(grid*a-k*c,2*c) <= F(1,4))
            for j in range(20):
                check(abs(F(grid*(a+j)-k*c,2*c)) < F(29,40))
        for degree in range(20):
            def value(n): return (grid*(left+n)-k*c)**degree*(2*c)**(19-degree)
            def diff(n,j): return sum((-1)**(j-v)*comb(j,v)*value(n+v) for v in range(j+1))
            state = [diff(0,j) for j in range(20)]
            for n in range(length):
                for j,z in enumerate(state):
                    check(z == diff(n,j))
                    check(abs(z) <= 2**j*(2*c)**19)
                    full_slots += 1
                if n+1 < length:
                    for j in range(19): state[j] += state[j+1]
        check(380+190+19*(length-1) == 19*length+551)
check(F(1,4)+F(19,40) == F(29,40) < F(3,4))

# General signed grid rounding checked by the independent floor formula.
for den in [1,2,3,17,256,1001]:
    for num in range(-101,102):
        for g in [0,1,7]:
            m = (num*(1<<g)*2+den)//(2*den)
            check((2*m-1)*den <= (1<<(g+1))*num < (2*m+1)*den)
            check(abs(F(m,1<<g)-F(num,den)) <= F(1,1<<(g+1)))
power = (2*265800)**19
check(2**361 <= power < 2**362)
check((2**122*power).bit_length() == 484)
check((2**22*power).bit_length() == 384)
check(2**36*2**122*power < 2**520)
check(2**37*2**122*power < 2**521)
check(2**38*2**122*power < 2**522)
check(ceildiv(265800,1024) == 260)
check(ceildiv(265800,16384) == 17)
check(F(4,3)*2**16 < 2**17)
check(633 < 1688)
for length in range(20,261):
    check(sum(min(19,length-1-n) for n in range(length-1)) == 19*length-190)
    check(380+190+19*length-190 == 19*length+380)

out = {'scope':'Exact finite identities and metadata only; no analytic coefficients or values',
       'checks':checks,'live_slots_checked':states_checked,'full_slots_checked':full_slots,
       'exact_ties_checked':ties,
       'author_pins':EXPECTED,'source_pins':saved['pins'] | extra['pins'],
       'findings':{'max_cell_length':260,'final_band_max_cell_length':17,
                   'b122_denominator_bits':484,'signed_live_capacity':521,
                   'signed_temporary_capacity':522,'g100_divisor_bits':384}}
dest = OWN/'review_exact_residue_difference_20261111.json'
with dest.open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2)
    f.write('\n')
print(json.dumps({'checks':checks,'live_slots_checked':states_checked,'receipt_sha256':sha(dest)}))
