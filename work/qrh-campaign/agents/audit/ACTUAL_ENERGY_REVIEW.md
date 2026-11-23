# Actual etaPlus energy: independent mathematical audit

Reviewed note: agents/major-constants/ACTUAL_ENERGY.md
SHA256: 51E3323FFDD0BA7A6B7B12593CD986994950104E4F9EF44B4DE470080575F645
Verdict: no mathematical defect found in the proposed derivation. This is a paper/source audit, not a Lean theorem or compilation verdict. Several analytic bridges remain to formalize, listed below. The logarithmic growth is essential and must be retained.

## Source and normalization checks

The comparison theorem at entries/bombierivinogradov1965/LeanLab/PNTPort/LargeSieve/Multiplicative.lean:246 sums primitive characters for moduli1,...,Q with weight c/phi(c), integer coefficients on Ioc M(M+N), and constant N+2Q^2. Therefore the Hilbert norm in the note is exactly the square root of that weighted character sum divided by x. Multiplication by the additive twist has modulus1 and changes no coefficient energy. The comparison theorem has no prime-distribution premise in its signature; this review did not compile its proof closure.

Mathlib Chebyshev.psi_le requires z>=1 and bounds psi(z) by log4*z+2sqrt(z)log(z). It is used only for t in[1,2], hence xt>=x>=4.9e26. Chebyshev.psi_ge' requires z>=0 and gives(x-1)log2-log(x+2), with the plus2 inside the logarithm. It is used on t in[0,1], where that domain is valid. The natural/floor conversion to repository psiR remains a bridge to formalize. Source PsiSandwich.psiR_le supplies psiR(z)<=4z for z>=0 without Platt.

## Compact smoothing and summation by parts

EtaCirc defines P0(t)=(t(2-t))^3 exp(-(t-1)^2/2), with derivative P1(t)=-(t-1)(t(2-t))^2(7-(t-1)^2)exp(-(t-1)^2/2). This verifies positivity and monotonicity on the two halves. For f=etaO^2, f(0)=f(2)=0, f(1)=1, and f' has the stated signs. CMain.P0_symm and EtaONum.integral_P0_sq supply symmetry and m<=.640205998, respectively.

The exact finite summation-by-parts identity is

    sum Lambda(n)f(n/x)=-integral_0^2 psi(xt)f'(t)dt.

There is no missing boundary term because f vanishes at both endpoints. A jump at n/x=1 or2 changes no Lebesgue integral; the last coefficient at2 is zero anyway. Integrating t f' and using symmetry gives A=1-m/2 and B=1+m/2.

On the increasing half, multiplication by-f' reverses the lower Chebyshev bound. On the decreasing half, multiplication by-f' preserves the upper bound. Thus the leading coefficient is log2*(-A+2B)=log2*(1+3m/2). Both derivative variations equal1. The error bounds log2+log(x+2) and2sqrt(2x)log(2x) are consequently valid. Prime powers are already included in Lambda and psi; none have been omitted.

For n>=2, Lambda(n)<=log n<=log(2x), and n=1 contributes zero. The compact sequence has integer interval length floor(2x)<=2x. Dividing the sieve bound by x^2 yields exactly the displayed factor(2+2Q^2/x), not its square or an extra factor x.

The coefficient2.719 is numerically sound:2log2*(1+1.5*.640205998) is about2.71756531. At x0=4.9e26 the residual coefficient is below1e-10; monotonicity of log(x+2)/x and log(2x)/sqrt(x) on this range makes the bound uniform. Certifying these inequalities with exact rational logarithm/square-root bounds remains part of the Lean work.

## Fourier remainder

HHFourier.gL is hBase(exp u), and gC is its complex coercion. HHFourier2 supplies integrability of both derivatives and the pointwise Fourier derivative identities, with multiplier2*pi*i*xi. Plancherel plus integral_gL''_sq_le therefore gives

    integral (2*pi*xi)^4 |ghat(xi)|^2 <=368.

The complement of the truncated interval is |xi|>H/(2*pi). Its inverse-weight integral is

    integral_(|xi|>H/(2*pi)) (2*pi*xi)^(-4) dxi=1/(3*pi*H^3).

Hence Cauchy-Schwarz produces the claimed L1 Fourier tail. Integrability on the central interval follows from boundedness/continuity of the transform of integrable gC. This proves global integrability of ghat, enabling full inversion at every point because gC is continuous. HHFourier.hH_eq_fourier_K evaluates the truncated inverse transform at log t (written as the forward transform at-log t), so there is no Fourier sign or2*pi discrepancy.

HHFourier.etaO_eq and the definition of etaPlus then give the pointwise Gaussian remainder. The bound at t=0 follows separately because both smoothings vanish there. The rational.0023 bound is safe since .0023^2*3*3.14*200^3>368 and pi>3.14. The earlier L2 smoothing approximation by itself would not establish this pointwise result; the note correctly uses the stronger derivative/inversion argument.

## Infinite Gaussian blocks

The blocks floor(jx)<n<=floor((j+1)x) cover all positive integers without overlap. Their integer lengths are<=x+1. On the zeroth block, t exp(-t^2/2)<=exp(-1/2); on all subsequent blocks the function is decreasing for t>=1, giving Gj=j exp(-j^2/2). Floors do not alter these real inequalities because integer n>floor(jx) implies n>jx.

The inequality Lambda(n)^2<=Lambda(n)log((j+1)x), together with psi((j+1)x)<=4(j+1)x, gives the coefficient-energy bound stated in the note. Applying the sieve and dividing the norm by x gives exactly

    2*.0023*sqrt(1+(1+2Q^2)/x)
       *Gj*sqrt(j+1)*sqrt(logx+log(j+1)).

For j>=4, each S0 and S1 summand is at most j(j+1)exp(-j^2/2), using sqrt(log(j+1))<=sqrt(j+1). The successive ratio is((j+2)/j)exp(-(2j+1)/2)<=1.5exp(-4.5)<1/40. Thus the full infinite tail is bounded by20*.000336/(1-1/40). It is not silently truncated.

Independent rational checks give S0<=26147853/13000000<2.1 and S1<=16847937557/13000000000<1.4. Since logx>61 and sqrt61>7.81, the residual norm coefficient is strictly below.0105. The comparison sqrt(2.719)<1.649 and(1.649+.0105)^2<2.8 is also correct.

Minkowski should first be applied to finitely many blocks. Their scalar majorants are summable by the displayed Gaussian bounds. ArcChars.summable_cP supplies absolute summability of the actual etaPlus coefficients; the etaO sequence has finite support. Character values and additive twists have modulus<=1. Therefore the block sums converge to each actual character sum. The set of characters is finite for fixedQ, so passage to the finite weighted Hilbert norm is justified. There is no unproved infinite-tail truncation assumption.

## Thin-conductor consequence

For D=149900, any relevant odd squarefree c>=D has only itself as an odd multiple<=150000. Hence K_D=2/min(phi(c))^2. An independent totient sieve (separate from the author's trial-division script) confirms minimum73728 attained at149955.

The Fourier integration interval has length1200000/D; norm_FU<=1.2534 gives I_D<=1200000*1.2534^2/D. Alternatively, the full integral is<=49*7.78=381.22 from MajorTotal's Plancherel bound with the delta/49 change of variable. This checks the normalization of both bounds.

Combining the interval bound, K_D and2.8log(2x) gives exactly

    (30547447/2357723136000000)*log(2x).

The1% quadratic splitting loss multiplies this coefficient by1.01, which remains below1.31e-8. ArcChars.coprime_split directly bounds the sum of absolute removed coefficients by1e-15*x; multiplying each by a character of modulus<=1 preserves this bound. For squarefree q, the weighted character removal factor is bounded by sum |Gauss|^2/phi(q)^3=1/phi(q), since sum |Gauss|^2=phi(q)^2. After summing q and integrating the Fourier weight, the discarded correction is bounded by101*1e-30*381.22*13.59756<1e-24. This explains the removal bound rather than treating the pointwise exponential-sum theorem alone as automatically character-uniform.

The resulting target1.31e-8log(2x)+1e-24 is therefore consistent. It is below9e-7 for log(2x)<=68, but grows without bound as x grows. It provides no uniform all-x error cap, no estimate for the complementary conductors, and no mixed fourth-moment/Cross bound.

## Exact checks and remaining work

check_actual_energy.py ran successfully and saved actual_energy_checks.json. It verifies the block constants, residual and final coefficient comparisons, the independent finite totient minimum and exact rational conductor coefficient. Those arithmetic checks do not prove the analytic bridges or replace kernel certificates.

Still to formalize: the Chebyshev floor conversion; compact weighted summation by parts and derivative signs; the weighted Fourier L2 identity, Fourier L1 tail and pointwise inversion; integer-block sieve/Minkowski limit; uniform numerical coefficient comparisons; character reconstruction and finite totient certificate. The underlying comparison large-sieve theorem must also be integrated and compiled with audited types/axioms. The note identifies these as proof work, not new assumptions in a proved theorem.

## Separate tight-numeric source update

PsiFixedTightNumeric.lean now has SHA2560A023F266F7111267370FC16596350D628B1B9F1E222C5576B8022FF8E957112. Its narrower imports and inlined exp_nat_ge'80 argument preserve the previously reviewed statements and mathematical proof. This audit did not inspect the concurrently running compiler result.
