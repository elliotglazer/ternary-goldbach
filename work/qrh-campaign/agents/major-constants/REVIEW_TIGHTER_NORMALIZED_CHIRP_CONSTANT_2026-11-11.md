# Independent review: tighter normalized final-chirp constant

2026-11-11. **PASS for the conditional paper theorem; no correction required.** Reviewed author: `prime-estimates/TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md`, SHA256 `5E3B9FCDC374998149ABBF3262BF925E0D02C6BFBF399462D1C34ABB68218F6F`. No inventory, precision population, numerical value, price, build, declaration or proof emission is included in this verdict.

I read the full frozen author and its scalar source, and checked its joins to the accepted rounded-cache, ordered mixed-error, sharper-coefficient and conductor-local interfaces. The independent evidence below checks eight artifact/source pins, three formal coefficient identities and two fixed parameter examples. The examples are not substituted for the general proof.

## Leaf inequality and the extra premise

The actual normalized-cache proof bounds inverse error by `E*u*V`, where

    E=P*(3nA+n+2)+R*(n*(2n-1)+2P), X=E/n.

It retains the data error, scaled-cache error, their cross term and the unnormalized inverse factor P. The final chirp gives

    e_out <=(1+u)e_I+unM+u.

After dividing by n and by uV for the error coefficient, the stated upper expression `X+uX+(n+1)/n` is valid. It is conservative: the exact M/V contribution can be smaller. It is not an equality for the actual numerical error.

The author establishes X<C_sharp<C_old from the already proved formal inequalities before using the peak condition, so there is no circular bound. Under the EXPLICIT condition `u*C_old<=1/2`, one gets uX<=1/2. Since n>=2, `(n+1)/n<=3/2`; therefore the total coefficient is at most X+2 and hence at most

    C_tight=ceil(E/n)+2.

The ceiling is exact integer arithmetic. To compare with C_sharp, X>=3PA>=300 implies `3X/2+(n+1)/n>X+2`. Since the integer C_sharp exceeds that expression, it is at least `ceil(X)+2`. This handles integral and nonintegral X alike. No fractional error or rounded ceiling is hidden.

The extra peak premise cannot be replaced by the old local D_B alone. The supplied n=2 example independently checks: P=4,R=8,A=25,D_B=601,C_old=688, and u=1/1024 obeys `u<=1/D_B` but violates `u*C_old<=1/2`. This is a correct premise-independence example, not a failure of the transform itself. The leaf pair must therefore include `D_t=max(D_B,2*C_old)` as written.

## Ordered tree, old guards and tensor composition

The CT rule preserves the actual m-first ordering. With a=C_t(m), b=C_t(r), the same first-child/twiddle analysis yields d=a(1+u)+1 and coefficient at most `a+b+1+u(a+b*d)`. Since u<=1, the selected safety expression `a+b(2a+1)` bounds the last factor. The recurrence C_t=a+b+2 is therefore valid on arbitrary admitted stored inputs, without a workload multiplicity or missing unnormalized factor.

The structural claim is correctly

    C_t<=C_sharp<=C_mix,
    D_t<=max(D_mix,2*C_mix),

not D_t<=D_mix. At each child its D_t is bounded by the parent's old D_mix or twice the parent's C_mix. The new CT safety polynomial is no larger than the legacy one because it is increasing in both nonnegative child coefficients. Repeated child roles remain repeated even when a memoized plan node is shared.

The chosen conductor guards retain both D_local_old and2*S_base. These cover the new tree D_t and every descendant old Bluestein peak premise, since a descendant C_mix is at most its axis C_mix and S_mix<=S_base on the admitted family. The old peak/context proof is therefore still available, including the normalized inverse and postchirp bounds. The result does not infer narrower stored or raw widths merely from a smaller error coefficient.

The exact normalized tensor operators still have sup norm at most one. The ordinary product bound gives normalized intrinsic error at most `2*S_t*V*u` under the retained old sum guard. Restoring phi(c) and the exact conductor factor yields `2*phi*S_t*2^14*2^-p/sqrt(c)`. Primitive-output counts do not replace phi. Input/source, conductor-factor approximation and all actual completion/interpolation errors stay separate.

Replacing only S_sharp by S_t in the accepted squared selector is consequently sufficient, with the SAME guards, p>=100, input-grid contract and complete global-p108 radius. It does not authorize a new precision assignment or cache-cost fold. The numerical variant remains the normalized rounded cache; no old unnormalized or exact finer-grid leaf may use this new coefficient without its own theorem. Actual root/gate/cache producers and strict signs remain required.

## Separate one-bit result

The three-quarter comparison is independently correct:

    C_B_sharp-3*C_B_old/4=3P/2+21R/2+8>0.

Unchanged leaves satisfy the corresponding weak inequality, and a CT parent adds a positive1/2 to the sum of its child gaps. Hence `3*S_mix/4<=S_sharp<=S_mix` on the same full ordered plans, including repeated axes.

With the same target, same monotone guards and candidate range100..108, let p_sharp be the least passing sharp precision. If p_sharp<108, raising it by one makes the mixed intrinsic bound at most `(4/3)/2=2/3` of the passing sharp bound. The old guards also pass at the larger p. Thus p_mix<=p_sharp+1; monotonicity gives the other inequality. At p_sharp=108 both equal108. The zero-S case is decided by the common guards. This proves a zero-or-one-bit reduction for the EXISTING sharp selector relative to mixed, without a population calculation.

This theorem does not bound the improvement of the new C_tight selector, a whole-axis comparator, or a selector with different guards, targets or cache semantics. The author's explicit separation is essential and correct. It also makes no prediction about actual rounding errors or runtime.

## Frozen evidence and scope

Independent script `major-constants/review_tighter_normalized_chirp_20261111.py`, SHA256 `82E48EF4327E2C2E0153EC280013C7C834D1886FB1586F7B621C8AE93D3BD580`; receipt `major-constants/review_tighter_normalized_chirp_20261111.json`, SHA256 `A42DB8CE47032D19D7AE55A417B89103DCBDF570B72C6DB1B62865F132C91FE6`. All27 checks pass. The three formal identities were reconstructed from independently expanded monomial coefficients; the fixed n=2,3 examples check premise separation and nonintegral ceiling handling. No author program was imported or run.

The author scalar pins are `7ECE987A0A0B8435B1F3B50D2DF44F6C2E68D4A51AFD1BCEC015377928A59A0E` / `638560280015BAC11419FFD4E00DDA00F65641C2681BBBAAE9217A5B7BB12FCF`. Consumed mathematical source pins include sharper author/review `08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F` / `3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3`, normalized-cache author/review `FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9` / `09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA`, and mixed error `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`. Full paths/pins are retained in the receipt.

The tighter recurrence and the separately stated old one-bit theorem pass at paper scope. Existing assignment files and price runs remain unchanged. Formal proof implementation, actual enclosures, new centers/signs, completeness and complete producer/checker prices remain outside this review.
