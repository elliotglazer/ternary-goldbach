module

public import TotientGrid
public import BudgetCore

@[expose] public section

namespace GoldbachEnergy
theorem principal_ratio (N : ℝ) (q : ℕ) (hN : 10^20 ≤ N)
    (hq : 1.1*(Real.log N)^2 < q) : Real.log N/(q.totient:ℝ) < 0.088 :=
  principal_ratio_of phi_ratio N q hN hq
theorem sup_budget {N p err s : ℝ} (hN : 10^20 ≤ N) {q : ℕ}
    (hq : 1.1*(Real.log N)^2 < q) (hp : p ≤ N / q.totient)
    (he : err ≤ 0.122 * N / Real.log N) (hs : s ≤ p+err) :
    s ≤ 0.21*N/Real.log N := sup_budget_of phi_ratio hN hq hp he hs
#print axioms principal_ratio
#print axioms sup_budget
end GoldbachEnergy
