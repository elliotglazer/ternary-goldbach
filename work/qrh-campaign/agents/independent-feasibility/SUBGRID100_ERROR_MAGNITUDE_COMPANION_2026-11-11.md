# Use the stored-input margin in the error coefficient

2026-11-11. Narrow immutable companion to `SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md`, SHA256 `B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266`. The base packet and all predecessors remain unchanged. This is a stronger conditional paper selector, pending independent review. No metadata, assignment, cost or value evaluation is performed.

## Separate error and capacity bounds

The intrinsic theorem is linear in an augmented stored-input bound V. It does not require V to be a power of two. The local C/D proof, including uncertain normalized-kernel construction and rounded use, is valid for every V at least the actual input norm plus one. The old width argument is independently valid with any larger augmented bound. Hence one can use `V_error` in the error theorem and retain `V_width=16384` in all context capacities. This does not mix numerical input centers: both bounds concern the same newly regridded vector.

For completeness, the exact source margin is as follows. Under the base packet's raw-input producer contract, the stored polynomial center has norm below8192. The actual raw finite head `(a/c)^-s` has norm at most `sqrt(c)<633`; its stored center has error at most1 and hence norm below634. The original sum is formed exactly on grid100, so its norm is below8826. A checked complex regrid has error at most `rho_p*2^-p`, with `rho_p=1` for p<100 and zero otherwise. Therefore, for every p in80..108,

    max_a |z'_a|+1 < 8827+rho_p*2^-p
                     <= 8827+2^-80 < 8828.               (1)

The chosen sharper bound is `V_error=8828`. This conclusion uses exact assembly and the actual stored-polynomial magnitude producer, not merely an analytic error radius or the weaker old bound `M+1<=16384`. Any extra raw-input round must be accounted for before applying (1). The base source/head accuracy and grid100 encoding obligations are unchanged. Full P20 is a sufficient selected polynomial interface; other evaluators require their admitted source, height and magnitude contracts.

## Generic and instantiated selectors

More generally, if a proved rational V_e satisfies

    max |z'_a|+1 <= V_e <= 16384,        V_e>=1,

the base theorem may replace its total allowance by

    E_c(p;V_e) = phi(c)/sqrt(c) * (2*S(c)*V_e+rho_p)*2^-p. (2)

The unchanged target is `Cg*2^-108`, with

    Cg=1266*202305920*16384=4196258524692480.

All terms are nonnegative, so the exact sufficient test is

    [phi(c)*(2*S(c)*V_e+rho_p)]^2 * 2^(2*(108-p))
           <= c*Cg^2.                                   (3)

Rational V_e may be cleared by its positive denominator. At the selected integer V_e=8828 this becomes

    [phi(c)*(17656*S(c)+rho_p)]^2 * 2^(2*(108-p))
           <= c*Cg^2.                                   (4)

Retain the base local D and old semantic peak guards, the same finite range80..108, and choose the least passing p only after all producer contracts have been supplied. Every assignment passing the base16384 selector passes this stronger test. The old exact p108 fallback remains available. The converter term rho is not reduced by the magnitude ratio: exact input uncertainty is transported once through the operator, independently of S or V_e.

Equation (2) replaces the combined intrinsic-plus-regrid term in the base complete error formula. Thus the same old `Rfixed+135*Cg*2^-108` ceiling and all downstream magnitude bootstraps follow. It does not consume new head/source reserve or weaken the alpha budget. The exact global R108 ratio remains `2804840254168152529/4294967296000000000` in units of `2^-45`.

The intrinsic coefficient ratio to the base allowance is `8828/16384=2207/4096`. This does not establish a universal extra bit: `2*8828>16384`, even before adding regrid error. Fixed sufficient examples using the conservative conductor factor633 are S<=1 at p80, S<=2 at p81, and S<=5 at p82. These are conditional scalar implications, not claims about actual plans, selected rows or their frequency. No precision or price distribution is asserted.

## Unchanged implementation boundaries

All runtime capacity formulas continue to use V_width=16384. The exact normalized contexts, input and coefficient grid distinction, raw presums/products, final rounding witnesses and signed representations remain those of the base packet. No old width histogram is changed here. All p-specific input conversion, cache, root, scaled-kernel and exact cached-sum obligations remain charged. No shared-high-cache or tighter tensor factor is imported. A future combination with a new tensor bound must prove the common p range and selector explicitly; this note retains the original factor two.

The base paper's twelve source pins, actual-function split, shifted finite-polynomial qualification, unchanged guard/sample obligations and prohibition on sign transfer apply verbatim. Principal and finite-coverage obligations are untouched.

## Fixed evidence

Owned `subgrid100_error_magnitude_20261111.py`, SHA256 `9B316F1718C4695D3B45B18E02D565009CB303F712A18021CBA4AAF15E45A9E6`, checks96 fixed rational/hash assertions. It reads only the pinned base paper, not any source-value or inventory data. Its first run produced the345-byte exclusive receipt `subgrid100_error_magnitude_20261111.json`, SHA256 `AE3AAD40AB7DE3D4D537D263AE3FA7F13C99968794B10A5C9F6550DB556FD6C8`. These checks supplement the quantified paper derivation; no compiled theorem or performance claim follows.
