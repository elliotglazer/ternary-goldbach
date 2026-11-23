# Full-sum transfer for the averaged residual

Source commit is 23b2d68ca344203d4384e0aff7affa4ec034bef9. This note resolves the algebra and numerical budget of the transfer from the coprime-supported exponential sum to the full smoothed sum. The Lean proof scripts are prepared but have not yet been compiled. The character-error estimates remain unproved.

## Existing removal estimates

MajorArcs/ArcChars.lean gives the following chain without a Fact PlattGRH parameter.

- sum_noncoprime_etaPlus_le bounds the removed coefficients by 1.94*K*log(q)+1 whenever x>=1e4 and x^2<=2^K.
- exists_K at line239 chooses K for x>=4.9e26 and proves the bound <=1e-15*x uniformly for q<=300000.
- coprime_split at line298 gives the absolute coefficient sum.
- norm_S_sub_coprime_le at line314 gives, for every real alpha,

      |S_etaPlus(alpha,x)-expTsum(coprimePart q (cP x),alpha)| <=1e-15*x.

MajorArcs/ArcCharsStar.lean gives the corresponding chain.

- MinorArcs/BaseGap2.sum_noncoprime_le uses 6.2*K*log(q)+1.
- exists_K_star at line42 applies for y>=1e25.
- coprime_split_star at line85 proves the absolute coefficient bound <=1e-12*y.
- norm_S_star_sub_coprime_le at line100 gives, for every real alpha and y=x/49,

      |S_etaStar(alpha,x)-expTsum(coprimePart q (cU y),alpha)| <=1e-12*y.

Both apply for 1<=q<=300000 and x>=4.9e26. There is no major-arc restriction on alpha or beta. The source modules import Platt-dependent results, but these particular declarations have no such hypothesis. An eventual axiom audit should check their compiled dependency terms.

At the bottom endpoint and q=300000, choosing Kplus=178 and Kstar=167 in the sharper raw formulas gives exploratory normalized errors about8.88983e-24 and1.30590e-21. The proof drafts use the already established, looser uniform bounds.

## Exact algebraic transfer

For a finite set I, any f,g:I->Complex, complex main value M, t>0, and pointwise |f-g|<=D,

    sum_I |f-M|^2
      <= (1+t)*sum_I |g-M|^2 +(1+1/t)*#I*D^2.

This follows from |u+v|^2<=(1+t)|u|^2+(1+1/t)|v|^2 with u=g-M and v=f-g. The helper does not assume D nonnegative separately, since the squared-error argument does not need that additional assumption.

AveragedResidual.lean now includes sum_norm_sub_main_le and sum_units_perturbed_sub_main_le. Combining the helper with the exact character identity gives

    full residual squared
      <= (1+t)/phi(q) *
          sum_psi |tau_q(psi)|^2
            |S_{psi^-1,coprime}(beta)-1_{psi=1}*A|^2
          +(1+1/t)*#units(q)*D^2.

The main value on the rational arc is tau_q(1)*A/phi(q). The source identifies tau_q(1)=mu(q). The spectral average retains the exact Gauss norm. Rewriting by Bombieri.norm_sq_gaussSum gives the conductor times the squarefree/coprimality indicator. No maximum over characters is introduced.

FullResidualTransfer.lean specializes this inequality to the full etaPlus and etaStar sums, bounds #units(q)<=q<=300000, and uses the source removal lemmas above. It allows every complex A, so the Fourier main terms are obtained by direct specialization.

No new analytic hypothesis is introduced in these two eta corollaries. They require the source threshold, modulus range and t>0. The core perturbation lemma has only ordinary algebraic inputs.

## Normalized errors

Use the definitions in AVERAGING.md. Let Eplus and Estar denote the normalized squared spectral residuals for the coprime-supported coefficients, and Rplus and Rstar the full residuals. Take t=0.01. Then

    Rplus <= a*Eplus+bp
    Rstar <= a*Estar+bs

with

    a=1.01
    bp=3.03e-23
    bs=3.03e-17.

The normalization is by x^2 for plus and y^2 for star. The 1% coefficient is a deliberate budget choice. Keeping t symbolic in the Lean helper permits later optimization.

Let Aplus', Astar' and Cross' be the three integrals built from Eplus and Estar, while Aplus, Astar and Cross use the full residuals. The Fourier bounds give

    Aplus <= a*Aplus' + (49*7.78*2.85)*bp,
    Astar <= a*Astar' + (0.640208*2.85)*bs.

For the product term,

    Cross <= a^2*Cross'
             +a*bp*integral_sum Estar
             +a*bs*integral_sum Eplus
             +bp*bs*sum_q(2D_q).

Here D_q=1200000/qt(q), and integral_sum includes the delta integration and the modulus sum.

## Explicit mixed-error bound

The existing Qset facts give #Qset<=300000, q<=qt(q), and qt(q)>=2. Thus

    sum_q(2D_q) <=3.6e11,
    sum_q(2D_q*#units(q)) <=7.2e11.

These inequalities use only the finite set size and q<=qt(q). They do not use numerical enumeration of totients.

Retain the averaged-cubic premise J<=8.79 and the source main-term L2 bound M<=0.640208*13.59756. The pointwise inequality

    |Splus'/x-main|^2
       <=3*(|Splus/x|^2+|main|^2+|(Splus'-Splus)/x|^2)

then gives

    integral_sum Eplus
      <=3*(8.79+0.640208*13.59756+7.2e11*1e-30)
      <53.

The unconditional MinorTotal.norm_S_etaStar_le_uniform gives |Sstar|/y<=22.75. Together with the removal bound, |m_q|<=1, and |Fourier(etaU)|<=1.2534, it gives

    integral_sum Estar
      <=7.2e11*(22.75+1e-12+1.2534)^2
      <4.15e14.

The mixed additive term is consequently at most

    a*bp*4.15e14+a*bs*53+bp*bs*3.6e11
      = about1.270024662196e-8.

This bound is intentionally coarse and sufficient for the transfer. It depends on J<=8.79, which still requires a Platt-free replacement in the larger argument.

## Sufficient coprime spectral targets

The following targets leave room for all the removal terms above.

    Aplus' <=9.6e-7
    Astar'+Cross' <=1.88e-6.

They imply

    Aplus <=9.696000000000330e-7
    Astar+Cross <=1.930488246677245e-6.

Both are below the conservative full-sum caps

    Aplus <9.73116250079e-7
    Astar+Cross <1.936851913302e-6.

The script transfer_budget.py verifies all of these rational comparisons using fractions.Fraction. The decimal values displayed here are summaries of those exact computations.

There is no numerical obstruction in this removal transfer. The outstanding issue is proving the coprime spectral targets and the shared major/minor-arc bounds without PlattGRH.

## Files and validation

- AveragedResidual.lean contains the exact spectral identities and the two generic transfer lemmas.
- FullResidualTransfer.lean contains the source etaPlus and etaStar specializations.
- transfer_budget.py performs exact rational budget checks.
- transfer_results.json records the successful checks.

No Lean compiler was launched. The integration agent has queued the files behind the existing serialized jobs. The proposed scripts contain no sorry or axiom. Their elaboration and compiled axiom dependencies remain to be checked.



## Relaxed J budgets

UNIFORM_AND_HYBRID.md and relaxed_j_budget.py give exact-arithmetic checked replacements for J<=9 or10. Use integral_sum Eplus<57 for both. For J<=9, coprime targets Aplus'<=9.49e-7 and Astar'+Cross'<=1.83e-6 imply full Aplus<9.61574237407e-7 and Astar+Cross<1.89165870199e-6. For J<=10, coprime targets9e-7 and1.65e-6 imply full caps9.10167633416e-7 and1.70249283179e-6. These full caps are rounded downward from the exact equal-half budgets. The analytic spectral targets and J remain unproved.
