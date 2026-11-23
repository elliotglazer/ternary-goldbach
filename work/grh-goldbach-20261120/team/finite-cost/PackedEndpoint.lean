import PackedGoldbach
import UpperBinaryPilot

/-! Reuse just the prime-certificate tree and its validity proof from the
1,024-target endpoint fixture. Reprove all coverage via the packed product. -/
namespace Goldbach.Packed.Endpoint

set_option maxRecDepth 65536

def flags : Nat := 0xd12d24584082880c100265108040029104a04904a69025320060a48b0116022500100886980c10d82420430916912006030092086d204044108348049221821a0034802132ca05144a4110412d841344b4084022480004c169960108264a0892110c009224b4026184c328244940928845005a05a04361821028a45244221128325841a4c90992120182514416894c308a25244b0902d021a6490cb4106c325261940b6894d325a65b7

def source (i : Nat) : Nat := if i < 1358 ∧ flags.testBit i then 1 else 0

def offsets : List Nat := [327,319,295,294,274,204,199,175,165,154,132,127,123,105,88,52,24,13,0]

theorem source_prime {i : Nat} (hi : 0 < source i) : (3 + 2*i).Prime := by
  have hg : (List.range 1358).all (fun j =>
      !(flags.testBit j) || BatchPrime.contains (3+2*j) UpperBinaryPilot.certificate) = true := by decide +kernel
  unfold source at hi
  split at hi
  next hj =>
    have h := List.all_eq_true.mp hg i (List.mem_range.mpr hj.1)
    exact BatchPrime.contains_prime UpperBinaryPilot.valid (by simpa [hj.2] using h)
  next => omega

theorem binary_interval : ∀ n : Nat, 9999999999997954 ≤ n → n < 10000000000000002 →
    n % 2 = 0 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n := by
  apply binary_interval_of_packed_product 5 1358 334 1024 9999999999997954 3 offsets source
  · intro i hi
    simp [source, Nat.not_lt.mpr hi]
  · intro i
    unfold source
    split <;> decide
  · exact fun _ hi => source_prime hi
  · decide
  · have ha : ∀ t ∈ offsets,
        BatchPrime.contains (9999999999997954-(3+2*(334-t))) UpperBinaryPilot.certificate = true ∧
        3+2*(334-t) ≤ 9999999999997954 := by decide +kernel
    intro t ht
    obtain ⟨hmem, hle⟩ := ha t ht
    exact ⟨BatchPrime.contains_prime UpperBinaryPilot.valid hmem, hle⟩
  · decide
  · decide
  · decide
  · decide +kernel

end Goldbach.Packed.Endpoint

#print axioms Goldbach.Packed.Endpoint.binary_interval
