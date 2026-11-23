# Removing the separate CHL reciprocal-zero certificate

This paper/scalar result removes the extra reciprocal-zero sum from the proposed use of corrected CHL rows 55 and 60. It does not certify either complete prime-gap inequality or any RH interval. No zero or special-function values were evaluated.

## Source and exact target

[Cully-Hugill and Lee, corrected arXiv v3](https://arxiv.org/pdf/2103.05986v3), Theorem 2, Lemmas 4–5 and Table 2, define two low-zero bounds as minima of count and reciprocal-sum branches. The reported extra input is the positive-ordinate, multiplicity-weighted sum through T0=104537615, bounded by S0=21.98308, with N0=260000000. Section 5 selects n=1. The rows used here have (m,delta,T1)=(9,1.757070e-10,93307030000) and (30,4.873014e-11,989087200000). The paper uses RH height 3000175332800. These are source inputs for comparison, not independently certified spectral data.

Write D=exp(u/2)+1 and Fk=F(k,m,delta). The count branches add exactly:

\[
 4F_0N_0/D+4F_0(N(T_1)-N_0)/D=4F_0N(T_1)/D. \tag{1}
\]

Instead of splitting the zeros at T0, apply the same per-zero count estimate directly to the complete positive carrier through T1. Every order is counted. This proves (1) without needing numerical N0, S0, or T0. RH through the selected H, conjugate pairing, and the rest of the explicit-formula estimates remain required.

## Exact branch comparison

For f(t)=(4t(1-t))^m, symmetry gives F0=1+delta/2. The integral of |f'| is 2, so

\[
 F_1\ge \lambda_m=\frac{2(2m+1)!}{4^m(m!)^2}.
\]

The factorial expression exceeds 7 at m=9 and 12 at m=30. All comparisons below use rational arithmetic and elementary exponential-series brackets 19/7<e<87/32, together with 3<pi<7/2.

Let P(t)=t(log(t/(2pi))-1)/(2pi)+7/8 and R(t)=.110 log(t)+.290 log log(t)+2.290. The analytic count input gives N(t)<=P(t)+R(t). For the two T1 values, logT1<26 and <28 respectively; R(T1)<7. Hence N(T1)<T1*L/6+8 with L=26 or 28. The S1 expression is strictly larger than its positive logarithmic integral. The following table records conservative comparisons, not approximate evaluations.

| row | log(T1/T0) lower | log(sqrt(T0*T1)/(2pi)) lower | S1 lower | delta F0 N(T1) upper | F1 S1 lower |
|---|---:|---:|---:|---:|---:|
| 55 | 6 | 19 | 114/7 | 72 | 114 |
| 60 | 9 | 21 | 27 | 226 | 324 |

Therefore delta F0(N(T1)-N0)<F1S1 in both rows. Also delta F0N0<1<F1*21.98308. Both minima choose the count branches. This comparison uses the printed S0 only as a scalar in the published expression; correctness of the replacement proof never assumes that S0 bounds an actual zero sum.

The same comparison works if N(T1) is replaced by P(T1)+R(T1). To retain a rounded published table value, independently check the whole strict inequality using that analytic upper count and every remaining term. The present large branch gaps do not establish the final table margin. Endpoint conventions in the count theorem must match the closed zero carrier: either use a closed-count theorem, prove the endpoint nonzero, or pass to the right limit in a continuous count upper bound. No simplicity assumption or single-zero endpoint correction is used here.

## Cost and alternative sum interface

For these rows the added checked work for a separate S0 certificate is zero. The main RH sign/count certificate is unchanged. A scalar evaluation of the analytic count bound replaces this particular low-zero data leaf. No 260-million-term reciprocal stream, separate fine ordinate list, or numerical N(T0) is needed for this component.

For a future parameter row that genuinely benefits from the reciprocal branch, reuse complete count blocks. If each (a_j,b_j] contains exactly n_j positive zeros with multiplicity, a_j>0, then

\[
 \sum_j n_j/b_j\le\sum_\rho m_\rho/\gamma_\rho\le\sum_j n_j/a_j,
 \qquad
 \text{width of this enclosure}=\sum_j\frac{n_j(b_j-a_j)}{a_jb_j}.
\]

This needs complete disjoint coverage and true multiplicity counts, including the final cutoff. Sign intervals alone provide lower counts until a completeness theorem closes them. Accumulating the rational upper terms rounded upward on one dyadic grid adds at most J*2^(-p) for J blocks, avoiding a growing product of unrelated denominators. A printed decimal sum cap supplies no positive error allowance by itself. Its available slack must be proved or the consuming prime-gap parameters must be recertified.

## Reproducible evidence

The companion `chl_low_sum_branch_scalars_20261111.py` performs 22 integer/Fraction checks. Its JSON records exact scaled count bounds and branch gaps. It evaluates no exp, log, zeta, zeros, primes or interval special functions; log comparisons are deduced from checked integer powers. Elementary pi bounds and the analytic zero-count theorem remain mathematical inputs.

The producer report from independent-feasibility, `PRINCIPAL_FINITE_RH_LADDER_REPLACEMENT_2026-11-11.md`, SHA256 `6ED412B2F17E25FFCFA649C4D6F0F4C2169EC9F93258164FA00DF9D9ED6FD570`, also identifies an older KL count-branch route at lower height. This note settles the corresponding branch question for the two proposed CHL rows; it does not choose the end-to-end cheapest route.

Script SHA256: `7EAC9D03A0281A963E5878B02EDCAB3E4921AC9DA3EC948545EB46ED9DC29DAB`.

Receipt SHA256: `65FFE01A2C71C6D33E29CAA3CBCF38C2A2CE44F11AD0400222205931DF8207B0`.
