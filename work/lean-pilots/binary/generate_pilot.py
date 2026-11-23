"""Produce a bounded complete certificate from one immutable actual cover word.
FLINT proposes missing Pratt data. Only generated Lean proofs establish primality.
"""
from pathlib import Path
import json, hashlib, time
from flint import fmpz

HERE=Path(__file__).resolve().parent
ROOT=HERE.parent.parent.parent
TRACE=ROOT/'work/formal-goldbach-bench/prime-cover/actual_trace.json'
PRATT=ROOT/'work/formal-goldbach-bench/native/pratt_certificates.json'
start=time.perf_counter();cpu=time.process_time()
data=json.loads(TRACE.read_text());word=data['words'][0]
assert word['id']=='b0-nearest-0'
origin=word['target_start'];updates=word['updates']
certs={c['prime']:c for c in json.loads(PRATT.read_text())['certificates']}
sources=[];roots=set();cover=0
for a in updates:
    shift=a['shift'];q=a['anchor'];mask=int(a['source_lo_hex'],16)+(int(a['source_hi_hex'],16)<<64)
    base=origin-q-2*shift
    assert base>0 and base%2==1 and 0<=shift<64
    assert ((mask>>shift)&((1<<64)-1))==int(a['mask_hex'],16)
    ps=[base+2*j for j in range(128) if (mask>>j)&1]
    roots.update(ps);roots.add(q)
    sources.append({'base':base,'mask':mask,'shift':shift,'anchor':q,'primes':ps})
    cover|=mask>>shift
assert cover&((1<<64)-1)==(1<<64)-1
new=[];needed=set()
def visit(p):
    if p in needed:return
    if p not in certs:
        assert fmpz(p).is_prime(),p
        fs=[(int(q),int(e)) for q,e in fmpz(p-1).factor()]
        assert __import__('math').prod(q**e for q,e in fs)==p-1
        a=2
        while not (pow(a,p-1,p)==1 and all(pow(a,(p-1)//q,p)!=1 for q,e in fs)):
            a+=1
        certs[p]={'prime':p,'base':a,'factors':fs};new.append(p)
    for q,e in certs[p]['factors']:visit(q)
    needed.add(p)
for p in sorted(roots):visit(p)
lines=['import BinarySupport','namespace BinaryPilot','']
for p in sorted(needed):
    if p==2:
        lines+=['theorem prime_2 : Nat.Prime 2 := Nat.prime_two',''];continue
    c=certs[p];fs=[q for q,e in c['factors'] for _ in range(e)];uniq=sorted(set(fs))
    fac=str(fs[-1])
    for q in reversed(fs[:-1]):fac=f'{q} * ({fac})'
    lines += [f'theorem prime_{p} : Nat.Prime {p} := by',
        f'  apply lucasNat {p} {c["base"]} (by decide) (by decide +kernel)',
        '  intro q hq hd',f'  rw [show {p} - 1 = {fac} by decide] at hd',
        '  simp only [Nat.Prime.dvd_mul hq, '+', '.join(f'Nat.prime_dvd_prime_iff_eq hq prime_{q}' for q in uniq)+'] at hd']
    if len(fs)>1:lines+=['  rcases hd with '+' | '.join('h'+str(j) for j in range(len(fs))),
                         '  all_goals subst q; decide +kernel','']
    else:lines+=['  subst q','  decide +kernel','']
lines+=['end BinaryPilot']
(HERE/'PilotPrimes.lean').write_text('\n'.join(lines)+'\n',encoding='utf-8')
lines=['import PilotPrimes','namespace BinaryPilot','']
for i,s in enumerate(sources):
    ps=s['primes'];literal='['+', '.join(map(str,ps))+']'
    lines += [f'def sourcePrimes_{i} : List Nat := {literal}',
              f'theorem sourcePrimes_{i}_prime : ∀ p ∈ sourcePrimes_{i}, Nat.Prime p := by',
              '  intro p hp',
              f'  simp only [sourcePrimes_{i}, List.mem_cons, List.not_mem_nil, or_false] at hp',
              '  rcases hp with '+' | '.join(f'h{j}' for j in range(len(ps)))]
    for j,p in enumerate(ps):lines += [f'  · subst p; exact prime_{p}']
    lines += ['',f'theorem source_{i}_membership : ∀ j : Fin 128,',
              f'    Nat.testBit {s["mask"]} j.val = true → {s["base"]} + 2*j.val ∈ sourcePrimes_{i} := by',
              '  decide +kernel','',f'theorem source_{i}_sound : ∀ j : Nat, j < 128 →',
              f'    Nat.testBit {s["mask"]} j = true → Nat.Prime ({s["base"]}+2*j) := by',
              '  intro j hj hb',f'  exact sourcePrimes_{i}_prime _ (source_{i}_membership ⟨j,hj⟩ hb)','']
    for tile in range(2):
        lines += [f'def slice_{tile}_{i} : SliceCertificate {origin+64*tile} 32 where',
                  f'  sourceBase := {s["base"]}',f'  sourceMask := {s["mask"]}',
                  f'  shift := {s["shift"]+32*tile}',f'  anchor := {s["anchor"]}',
                  '  shift_bound := by decide',f'  source_prime := source_{i}_sound',
                  f'  anchor_prime := prime_{s["anchor"]}','  connection := by decide','']
for tile in range(2):
    lines += [f'def slices_{tile} : List (SliceCertificate {origin+64*tile} 32) :=',
              '  ['+', '.join(f'slice_{tile}_{i}' for i in range(len(sources)))+']',
              f'theorem tile_{tile}_coverage : unionMasks (slices_{tile}.map sliceMask) = 2^32-1 := rfl','',
              f'theorem tile_{tile} : ∀ t : Nat, t < 32 →',
              f'    ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ {origin+64*tile}+2*t=p+q :=',
              f'  certified_tile slices_{tile} tile_{tile}_coverage','']
lines += [f'theorem binary_interval : ∀ n : Nat, {origin} ≤ n → n ≤ {origin+126} →',
          '    Even n → ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ n = p+q := by',
          '  intro n hlo hhi heven','  obtain ⟨k, hk⟩ := heven',
          f'  by_cases hmid : n < {origin+64}',
          f'  · have ht : (n-{origin})/2 < 32 := by omega',
          f'    have hn : n = {origin}+2*((n-{origin})/2) := by omega',
          f'    rw [hn]; exact tile_0 _ ht',
          f'  · have ht : (n-{origin+64})/2 < 32 := by omega',
          f'    have hn : n = {origin+64}+2*((n-{origin+64})/2) := by omega',
          f'    rw [hn]; exact tile_1 _ ht','', 'end BinaryPilot']
(HERE/'BinaryPilot.lean').write_text('\n'.join(lines)+'\n',encoding='utf-8')
manifest={'fixture_sha256':hashlib.sha256(TRACE.read_bytes()).hexdigest().upper(),
          'pratt_fixture_sha256':hashlib.sha256(PRATT.read_bytes()).hexdigest().upper(),
          'word_id':word['id'],'origin':origin,'upper':origin+126,'target_count':64,
          'sources':sources,'prime_roots':sorted(roots),'pratt_nodes':sorted(needed),
          'new_pratt_nodes':sorted(new),'certificates':[certs[p] for p in sorted(needed)],
          'generation_wall_seconds':time.perf_counter()-start,'generation_cpu_seconds':time.process_time()-cpu,
          'scope':'One fixed existing word. All generated data require ordinary Lean acceptance.'}
(HERE/'pilot_manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
print(json.dumps({k:manifest[k] for k in ['origin','upper','generation_wall_seconds','generation_cpu_seconds']}))
print(json.dumps({'anchors':len(sources),'source_positive_occurrences':sum(len(s['primes']) for s in sources),
                  'prime_roots':len(roots),'pratt_nodes':len(needed),'new_pratt_nodes':len(new)}))
