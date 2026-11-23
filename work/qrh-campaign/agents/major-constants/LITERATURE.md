# Literature check: fixed zero-free lines and the current threshold

Checked 2026-11-10. This is a bounded primary-source search, not a proof audit of the new papers. No source or compiler changes were made. None of the results below closes the current Lean goal or supplies a proved replacement for the required averaged residual estimates.

The search found no explicit ternary-Goldbach theorem at the current N = 10^27 threshold using only a uniform fixed zero-free line beta <= 7/8. Recent exceptional-set results are relevant to an eventual argument. Small improvements to the zero-free boundary are too small to repair the current numerical losses. One attractive explicit prime-counting estimate still uses finite RH verification and must not be imported as Platt-free.

## Fixed-line exceptional-set results

Pintz and Althofer, *The Goldbach exceptional set: an exponent of 7/12 and conditional refinements*, arXiv:2610.15559v1, Theorem 1, assumes every nontrivial zero of every primitive Dirichlet L-function has real part at most the same fixed theta < 1. It concludes

    E(X) <<_(theta,epsilon) X^(7/12 + epsilon).

The conductor-one function is included. Their Corollary 2 applies theta = 7/8. Theorem 3 improves the exponent further for theta <= 2/3, which does not include our hypothesis. The paper explicitly says theta affects the lower threshold for X. It gives no usable numerical X0 or implied constant for our threshold. Its numerical threshold in the refinement concerns theta, not X. [Primary source](https://arxiv.org/html/2610.15559v1).

Li and Liu, *Fourth moments of prime exponential sums and exceptional sets for sums and differences of primes*, arXiv:2610.26756v1, Theorems 1 and 2, assumes uniform theta < 11/12. For a specified compact Gevrey weight w and some kappa(theta) in (4/9,9/20), it proves

    integral_minor(X^kappa) |S_w(alpha)|^4 d alpha <<_(w,theta) X^(5/2) (log X)^100,
    E_+(N), E_-(N) <<_theta N^(1/2) (log N)^100.

The fixed logarithmic power is explicit; the implied constants and starting point are not numerical. Its fourth-moment treatment of Gauss weights and common character sums is conceptually relevant to our unresolved Cross term, but the weight, arcs and normalization differ. At N = 10^27, the displayed exceptional-set majorant with constant 1 exceeds N by about 10^165.858. No finite-threshold conclusion follows. [Primary source](https://arxiv.org/html/2610.26756v1).

An eventual ternary consequence of either E(N) = o(N/log N) follows by comparing the number of candidate primes p with the exceptional even numbers N-p. This sentence is our deduction, not an explicit finite-threshold theorem in either paper. It requires an explicit lower prime count and explicit constants to help at N = 10^27. Neither paper was audited or formalized here.

## Boundary refinements

Baiying Liu, *Improved zero-free half-planes for the quasi-Riemann hypothesis*, arXiv:2610.12234v2, changes parameters in the original QRH proof machinery and reports

    Bnew = 0.874957019420098946...

It is not a theorem that the bare statement beta <= 7/8 automatically implies RH. The refinement uses the underlying analytic method. Its own claim about Lean formalization was not checked during this search. If all other error constants stayed fixed, replacing x^(7/8) by x^Bnew at x = 4.9e26 multiplies the error by 0.997362051759. This exploratory comparison gives only a 0.264% improvement. [Primary source](https://arxiv.org/html/2610.12234v2).

Xu and Sang, *Amplified moments and a refinement of the quasi-Riemann hypothesis*, arXiv:2610.15291v2, Theorem 1.1, explicitly assumes the original work's analytic inputs. It reports the rational boundary

    B1 = 8748867 / 10000000 = 0.8748867.

The added ingredient is an amplified moment argument within that analytic framework. Bare QRH is not the complete hypothesis. At x = 4.9e26, the same fixed-constant comparison multiplies the error by 0.993061170109, a 0.694% improvement. This does not address the orders of magnitude lost in the current pointwise-to-average route. [Primary source](https://arxiv.org/html/2610.15291v2).

Bhowmik and Ruzsa, *Average Goldbach and the Quasi-Riemann Hypothesis*, arXiv:1711.06442v1, proves a converse from a power-saving average Goldbach asymptotic to a fixed zero-free half-plane for zeta. It does not supply a QRH-to-full-RH bootstrap or a numerical ternary threshold. [Primary source](https://arxiv.org/html/1711.06442v1).

## Explicit prime-counting result and its finite-verification dependency

Fiori and Jaskari, *Explicit bounds for the prime number theorem*, arXiv:2609.23222v2, Theorem 1.4, gives under the fixed line the attractive estimate

    |psi(x)-x| < .04934 x^(3/4) log(x)^2 + .02636425 x^(7/8), x >= 21.

However, Section 5.2 covers 10^19 < x <= exp(191), including our x, through Buthe's bound pi/(3e12) + 113.67/sqrt(x). Section 2.2 records Platt-Trudgian finite RH verification to H0 = 3000175332800. Proposition 3.6 also uses that verified height. Thus its published numerical constants cannot serve as a Platt-free replacement without replacing the finite-verification step. Generic zero-density and zero-sum formulas may still be useful ingredients. Both the parent and prime-estimates worker were notified. [Primary source](https://arxiv.org/html/2609.23222v2).

## Historical quantitative comparison

Deshouillers, Effinger, te Riele and Zinoviev, *A complete Vinogradov 3-primes theorem under the Riemann hypothesis*, 1997, assumes full GRH for the all-odd-integers conclusion. Its explicit large-number stage and finite computation do not apply under beta <= 7/8 alone. [Original AMS article source](https://www.maths.tcd.ie/EMIS/journals/ERA-AMS/1997-01-015/1997-01-015.tex.html).

Ming-Chit Liu and Tianze Wang, *On the Vinogradov bound in the three primes Goldbach conjecture*, Acta Arithmetica 105, 2002, Theorem 1, unconditionally proves every odd n >= exp(3100) is a sum of three odd primes. This is an actual explicit threshold, about 10^1346.313. It leaves an enormous finite gap above 10^27. [Publisher PDF](https://www.impan.pl/shop/publication/transaction/download/product/82946).

The distinction is between an explicit bound, an asymptotic statement with unspecified constants, and an ineffective constant. The search did not establish ineffectivity of the recent fixed-line results, so this note does not label them ineffective.

## Consequence for the campaign

No result found eliminates the numerical averaged-residual obligations at x >= 4.9e26. The Li-Liu fourth-moment argument is the most relevant new structural lead, but extracting a finite bound for our actual eta weights and arc widths would be new work. The Fiori-Jaskari example shows why an explicit QRH claim still needs a finite-RH dependency audit. No theorem above implies full GRH from QRH.
