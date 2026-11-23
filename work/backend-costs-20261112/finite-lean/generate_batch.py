"""The same certificate graph and witnesses as HOL, checked by stock Lean."""
import hashlib
import json
from pathlib import Path
H=Path(__file__).resolve().parent
f=json.loads((H/'fixture1024.json').read_text())
w=json.loads((H.parent/'finite-hol/cover_fixture.json').read_text())
cs=sorted(f['certificates'],key=lambda c:c['prime'])
lines=['import BatchPrime','set_option maxRecDepth 65536','namespace BatchData1024','open BatchPrime']
serial=0
def raw_tree(certificates):
    if not certificates:return 'BatchPrime.Tree.empty'
    m=len(certificates)//2;c=certificates[m]
    fs=[q for q,e in c['factors'] for _ in range(e)]
    return f'(BatchPrime.Tree.node {raw_tree(certificates[:m])} {c["prime"]} {c["base"] or 0} '+\
           '['+', '.join(map(str,fs))+f'] {raw_tree(certificates[m+1:])})'
def named_tree(certificates):
    global serial
    if len(certificates)<=31:rhs=raw_tree(certificates)
    else:
        m=len(certificates)//2;c=certificates[m]
        left=named_tree(certificates[:m]);right=named_tree(certificates[m+1:])
        fs=[q for q,e in c['factors'] for _ in range(e)]
        rhs=f'BatchPrime.Tree.node {left} {c["prime"]} {c["base"] or 0} ['+', '.join(map(str,fs))+f'] {right}'
    name=f'certificates_{serial}';serial+=1
    lines.append(f'def {name} : BatchPrime.Tree := {rhs}')
    return name
tree=named_tree(cs)
lines.append(f'def certificates : BatchPrime.Tree := {tree}')
def named_list(xs,prefix,typ,show):
    counter=0
    def rec(xs):
        nonlocal counter
        if len(xs)<=32:rhs='['+', '.join(map(show,xs))+']'
        else:
            m=len(xs)//2;l=rec(xs[:m]);r=rec(xs[m:]);rhs=f'{l} ++ {r}'
        name=f'{prefix}_{counter}';counter+=1
        lines.append(f'def {name} : List {typ} := {rhs}')
        return name
    name=rec(xs)
    lines.append(f'def {prefix} : List {typ} := {name}')
named_list(f['roots'],'roots','Nat',str)
named_list(w['witnesses'],'witnesses','(Nat × Nat)',lambda pq:f'({pq[0]}, {pq[1]})')
lines += [f'def target : Nat := {f["target"]}',f'def endExclusive : Nat := {f["end_exclusive"]}','end BatchData1024']
(H/'BatchData1024.lean').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')
block='''import BatchData1024
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteBatch1024
open BatchPrime BatchData1024

theorem valid : treeValid certificates certificates = true := by decide +kernel

theorem roots_checked : rootsKnown certificates roots = true := by decide +kernel

theorem roots_prime : ∀ p ∈ roots, p.Prime := rootsKnown_sound valid roots_checked

theorem covered : checkedCover target certificates witnesses = true := by decide +kernel

theorem width : witnesses.length = 1024 := by decide +kernel

theorem binary_index : ∀ j < 1024, PrimeCoverage.BinaryGoldbach (target + 2 * j) := by
  intro j hj
  exact checkedCover_sound valid witnesses target covered j (width.symm ▸ hj)

theorem binary_interval : ∀ n : Nat,
  3999999997356537860 ≤ n → n < 3999999997356539908 → n % 2 = 0 →
  ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n :=
  PrimeCoverage.binaryGoldbach_interval target 1024 (by decide) binary_index

theorem complete : (∀ p ∈ roots, p.Prime) ∧ (∀ n : Nat,
  3999999997356537860 ≤ n → n < 3999999997356539908 → n % 2 = 0 →
  ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n) := ⟨roots_prime, binary_interval⟩

end FiniteBatch1024
'''
(H/'BatchBlock1024.lean').write_text(block,encoding='utf-8',newline='\n')
for name,root in [('Full','complete'),('Primality','valid'),('Roots','roots_checked'),('Cover','covered')]:
    text=f'import BatchBlock1024\nimport FiniteReplay\nset_option maxRecDepth 65536\nset_option maxHeartbeats 0\n#replay_cover "batch_{name.lower()}" "FiniteBatch1024." 1024 1 FiniteBatch1024.{root}\n'
    (H/f'ReplayBatch{name}1024.lean').write_text(text,encoding='utf-8',newline='\n')
audit='''import BatchBlock1024
#print FiniteBatch1024.complete
#print axioms BatchPrime.nodeValid_prime
#print axioms FiniteBatch1024.complete
'''
(H/'AuditBatch1024.lean').write_text(audit,encoding='utf-8',newline='\n')
print(json.dumps(dict(certificate_nodes=len(cs),data_bytes=(H/'BatchData1024.lean').stat().st_size,
                     data_sha256=hashlib.sha256((H/'BatchData1024.lean').read_bytes()).hexdigest())))
