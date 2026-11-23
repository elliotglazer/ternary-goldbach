from pathlib import Path
import sys, math, json, subprocess
d=Path(__file__).resolve().parent
p=d.parent
s=(p/'PrefixCheck.lean').read_text(encoding='utf8')
cut=lambda a,b:s[s.index(a):s.index(b)]
head="""import PrefixJoin
namespace SmallGoldbach.LcmExperiment
open PrimeCoverage WideGoldbach
def support (d m : Nat) : Bool :=
  (List.range d).all fun j => decide (j+1 ∣ m)

theorem support_coprime {d m x : Nat} (hc : support d m = true)
    (hx : Nat.Coprime x m) : Nat.Coprime x d.factorial := by
  have hall : ∀ j < d, j+1 ∣ m := by
    intro j hj
    exact of_decide_eq_true (List.all_eq_true.mp hc j (List.mem_range.mpr hj))
  have aux : ∀ k, k ≤ d → Nat.Coprime x k.factorial := by
    intro k
    induction k with
    | zero => simp
    | succ k ih =>
      intro hk
      rw [Nat.factorial_succ, Nat.coprime_mul_iff_right]
      exact ⟨Nat.Coprime.of_dvd_right (hall k (by omega)) hx, ih (by omega)⟩
  exact aux d (Nat.le_refl _)

"""
helpers=cut('private theorem marks_member','/-- Translate')+cut('private theorem translates_witness','/-- A producer')
row=cut('private theorem row_sound','def span :')+cut('theorem rows_sound','theorem prefix_of_rows')
row=row.replace('hf : fac = d.factorial','hf : support d fac = true').replace('(by simpa only [hf] using hg.symm)','(support_coprime hf hg.symm)')
j=(p/'PrefixJoin.lean').read_text(encoding='utf8')
join=j[j.index('theorem checked_interval'):j.index('theorem join')].replace('hf : fac = d.factorial','hf : support d fac = true')
(d/'LcmBridge.lean').write_text(head+helpers+row+join+'\nend SmallGoldbach.LcmExperiment\n',encoding='utf8')
# Use the same original greedy decisions and offsets. Only the modular inverse uses lcm.
gen=(p/'generate.py').read_text(encoding='utf8')
gen=gen.replace('fac = factorial(cutoff)','fac = __import__("math").lcm(*range(1,cutoff+1))')
gen=gen.replace('["import "+dependency','["import LcmBridge"')
gen=gen.replace('theorem fac_eq : fac = Nat.factorial {cutoff}', 'theorem fac_eq : SmallGoldbach.LcmExperiment.support {cutoff} fac = true')
gen=gen.replace('  checked_interval (halo', '  SmallGoldbach.LcmExperiment.checked_interval (halo')
(d/'generate_lcm.py').write_text(gen,encoding='utf8')
cmd=[sys.executable,str(p/'check.py'),'--scope',str(d)]
subprocess.run([*cmd,'LcmBridge'],check=True)
subprocess.run([sys.executable,str(d/'generate_lcm.py'),'8','--width','98304','--halo','2048','--out',str(d)],check=True)
(d/'Audit.lean').write_bytes((p/'width-98304-study/Audit.lean').read_bytes())
subprocess.run([*cmd,'Power8','Audit'],check=True)
