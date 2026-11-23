from pathlib import Path
import json, sys

ROOT = Path(__file__).resolve().parent
fixture = json.loads((ROOT.parent/'native/pratt_certificates.json').read_text())
certs = {c['prime']: c for c in fixture['certificates']}
count = int(sys.argv[1] if len(sys.argv)>1 else 3)
spread = len(sys.argv)>2 and sys.argv[2]=='spread'
roots = ([fixture['roots'][512*pool+i] for pool in range(8) for i in range(4)]
         if spread else list(dict.fromkeys(fixture['roots']))[:count])
stem = 'PrimeSamples32' if spread else 'PrimeSamples'
needed = set()
def visit(p):
    if p in needed: return
    for q, _ in certs[p]['factors']: visit(q)
    needed.add(p)
for p in roots: visit(p)
lines = ['import PrimeSupport', '']
for p in sorted(needed):
    name = f'prime_{p}'
    if p == 2:
        lines += [f'theorem {name} : Nat.Prime 2 := Nat.prime_two', '']
        continue
    c=certs[p]
    factors=[q for q,e in c['factors'] for _ in range(e)]
    unique=[q for q,e in c['factors']]
    factor=str(factors[-1])
    for q in reversed(factors[:-1]): factor=f'{q} * ({factor})'
    lines += [f'theorem {name} : Nat.Prime {p} := by',
              f'  apply lucasNat {p} {c["base"]} (by decide) (by decide +kernel)',
              '  intro q hq hd',
              f'  rw [show {p} - 1 = {factor} by decide] at hd',
              '  simp only [Nat.Prime.dvd_mul hq, '+', '.join(f'Nat.prime_dvd_prime_iff_eq hq prime_{q}' for q in unique)+'] at hd']
    if len(factors)==1:
        lines += ['  subst q', '  decide +kernel']
    else:
        lines += ['  rcases hd with '+' | '.join('h'+str(i) for i in range(len(factors)))]
        lines += ['  all_goals subst q; decide +kernel']
    lines += ['']
lines += [f'#print axioms prime_{p}' for p in roots]
lines += [f'#check prime_{p}' for p in roots]
(ROOT/f'{stem}.lean').write_text('\n'.join(lines)+'\n')
(ROOT/f'{stem}.manifest.json').write_text(json.dumps({'roots':roots,'nodes':sorted(needed)},indent=2)+'\n')
print(json.dumps({'roots':roots,'nodes':len(needed)}))
