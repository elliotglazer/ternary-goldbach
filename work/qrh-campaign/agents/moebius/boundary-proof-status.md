# Finite Schoenfeld boundary candidate

The scratch file FiniteBoundary.lean contains six proof candidates with no PlattGRH binder. It retains the original bTerm_le hypotheses and range, including 12 ≤ Y < 1000000000. The source repository remains unchanged. The file is not compiled.

The smaller FinitePsiCore.lean contains only the finite psi bounds as literal von Mangoldt sums. Its project import closure is 11 modules. It is the first bounded validation target once Mathlib is available.

## What the source already proves

PsiSieveMain.sieve_table3, line 28160, is unconditional and covers 1000000 ≤ t < 1000000000. It gives theta(t) ≤ t + 0.1 sqrt(t) and t - theta(t) ≤ 2 sqrt(t). The weaker 5e7 range described by some nearby comments is only a restriction of this stronger theorem.

SmallTab.small_table gives |psi(n)-n| ≤ sqrt(n) for 12 ≤ n < 1000000. Small.psi_lt_small_700 gives psi(n) < 1.03883 n for 1 ≤ n ≤ 700. Together they prove psi(n) ≤ 1.03883 n throughout n < 1000000.

The existing nonprime_mid proof is finite in substance. Its psi arguments are sqrt(N), floor(N^(1/3)), and floor(N^(1/4)), all below 1000000 when N < 10^12. It currently calls global psi estimates. The scratch candidate replaces those calls by the finite estimates. The bound N^(r) ≤ sqrt(N) for r ≤ 1/2 supplies the two new endpoint proofs.

## Proposed source edits after successful validation

1. Add an unconditional finite psi helper using SmallTab.small_table, and an unconditional linear bound below 1000000 using that helper and Small.psi_lt_small_700.
2. Remove the Fact PlattGRH binder from nonprime_mid and replace its three global psi calls by the finite helpers.
3. Remove the binder from nonprime_small. Its proof already combines nonprime_mid with SmallNP.nonprime_small_kernel.
4. Remove the binder from EOneRanges.psi_le_two. Replace its small branch by the direct finite psi helper. In its large branch use nonprime_small at the integer n, replacing the global sum_vonMangoldt_nonprime_lt call.
5. Remove the binder from SchoenfeldGen.bTerm_le and derive its rho bound directly from psi_le_two after rewriting rho_eq.

These edits preserve the original theorem ranges. In particular there is no added Y ≤ 1000000 hypothesis on bTerm_le.

## Validation status

The finite sieve statements and lack of PlattGRH binders were checked from pinned source. The scratch proof files were written but not elaborated. Their #print axioms commands must run successfully before these candidates count as proved work. No main-repository source has changed.

The rest of SchoenfeldJ.rho_le still needs replacement for arguments at least 10^9, and the tail still needs both the rho estimate and sum_Lambda_div_Ioc. Thus validating this finite boundary chain would remove one genuine dependency without closing the full Möbius-profile theorem.

