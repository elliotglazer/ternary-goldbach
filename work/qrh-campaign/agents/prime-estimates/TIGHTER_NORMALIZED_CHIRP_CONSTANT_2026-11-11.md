# A tighter normalized Bluestein constant under the retained peak guard

2026-11-11. Conditional paper successor and fixed symbolic checks only. No inventory, axis distribution, coefficient, root, transform or analytic value was generated or evaluated. No price fold, build, declaration, proof emission or frozen change occurred. This note changes neither the accepted precision assignment nor its cost run.

## 1. Result and retained circuit

For the already reviewed rounded normalized-kernel circuit, let E be its prechirp error numerator below. The integer coefficient

    C_B_tight = ceil(E/n)+2                              (1)

is valid provided the original local safety condition AND the retained old peak condition `C_B_old*u<=1/2` hold. It is no larger than the accepted C_B_sharp. It composes through the same ordered CT and tensor proofs while keeping the old selected-family safety and peak guards. The new bound selects no precision and proves no cost saving.

Separately, the existing sharp coefficient satisfies `C_sharp>=3*C_mix/4` on every full ordered plan. With identical monotone guards, targets and integer p range, its least admitted p can improve over the old mixed selector by at most one bit. This comparison concerns the existing sharp rule, not the new tight rule or actual errors.

The circuit is the positive unnormalized character transform with the reviewed negative inverse used inside Bluestein. The kernel is the actual rounded grid-p object `Ktilde=Round_u(Khat/P)`, with `|Khat-K|<=PAu`, and therefore `|Ktilde-K/P|<=(A+1)u`. Exact fine-grid scaling or the old unnormalized cache is a different interface. All root/chirp errors and complex arithmetic-gate errors remain separately at most u=2^-p; cached coefficient error is paid at every use. The normalization in the error statement is not a new runtime operation.

## 2. Leaf proof with the actual final chirp

For n>=2 set

    m=2n-1, P=2^k=nextPowerOfTwo(m), R=2k+4, A=1+3R,
    Q=3nPA+1, D_B=max(1,2k,PA,Q),
    C_B_old=6PA+2R(2n+1)+8,
    q=3nA+n+2,
    E=P*q+R*(n*(2n-1)+2P), X=E/n.

Here 2n<=P<4n, P>=4, R>=8, and A>=25. These parameters are exactly those of the rounded-cache proof, sections 1--3. Under `0<u<=1/D_B`, its point-product error is at most q*u*V and its unnormalized inverse error is at most E*u*V, for V=M+1 and M bounding the stored input centers. This retains the inverse factor P, both operand errors, the scaled-cache round and the operand cross term.

The selected exact convolution outputs have norm at most nM. The final approximate chirp and its product round give

    e_out <= (1+u)*e_I + u*nM + u.

After division by n for the error statement, a sufficient coefficient is

    X+u*X+(n+1)/n.                                  (2)

This is an upper coefficient, not an equality for actual error. The earlier proof replaced 1+u by 3/2. We instead use the explicitly retained peak guard.

First establish X<=C_B_old independently of that new use of the guard. The accepted polynomial inequalities are

    C_B_sharp=9PA/2+3P/2+3Rn+12R+14,
    2n*(C_B_sharp-(3X/2+(n+1)/n))
       =R*(27n-6P)+26n-6P-2 >0,
    C_B_old-C_B_sharp=R*(9P/2+n-10)-6 >=74.

Thus X<C_B_sharp<C_B_old. Requiring `u*C_B_old<=1/2` now gives uX<=1/2. Since n>=2, `(n+1)/n<=3/2`. Expression (2) is at most X+2, hence at most the integer (1). No new error term is dropped.

For the comparison with C_B_sharp, observe `X>=3PA>=300`. Therefore

    3X/2+(n+1)/n > X+2.

Since C_B_sharp is an integer and exceeds the left side, it is at least `ceil(X)+2`. This proves

    C_B_tight <= C_B_sharp <= C_B_old.                (3)

The ceiling is exact integer metadata: `ceil(E/n)=(E+n-1)//n`. It is not a floating estimate or a new analytic computation. The rational coefficient X+2 would also suffice, but (1) is the chosen concrete integer recurrence.

The extra guard is not a consequence of D_B alone. For the fixed example n=2, P=4, R=8, A=25, one has D_B=601 and C_B_old=688. The dyadic u=1/1024 satisfies the local D_B safety condition but violates `2*C_B_old*u<=1`. This is a guard-independence example, not a counterexample to the actual transform or to a possibly sharper bound.

## 3. Complete ordered recurrence and safety

Use pairs `(C_t,D_t)` on the same full ordered plan. Identity, radix-two and direct leaves retain their old pairs. A normalized Bluestein leaf uses

    C_t=ceil(E/n)+2,
    D_t=max(D_B,2*C_B_old).                          (4)

For a CT split n=rm, computing the m child first, define

    C_t(n)=C_t(m)+C_t(r)+2,
    D_t(n)=max(D_t(m),D_t(r),1,
               C_t(m)+C_t(r)*(2*C_t(m)+1)).          (5)

This explicitly carries the extra leaf condition; it does not relabel the old D_B theorem. The usual proof, for a=C_t(m), b=C_t(r), sets d=a(1+u)+1. The combined normalized coefficient is at most `a+b+1+u*(a+b*d)`. Since u<=1, d<=2a+1; (5) makes its last term at most one. This proves the intrinsic bound for arbitrary stored input centers with the same V=M+1 contract. No workload multiplicity replaces the two child roles.

Let `(C_mix,D_mix)` be the legacy pair for that same ordered plan, and C_sharp the accepted sharper pair's coefficient. Structural induction gives

    C_t<=C_sharp<=C_mix,
    D_t<=max(D_mix,2*C_mix).                         (6)

At a normalized Bluestein leaf this follows from (3)--(4); unchanged leaves also satisfy it. At CT nodes the safety polynomial `f(a,b)=a+b*(2a+1)` is increasing for nonnegative a,b. Increasing its inputs by x,y changes it by `x*(1+2b)+y*(2a+1)+2xy>=0`. Also each legacy child C is at most its parent's C. Thus every child D_t is covered by the right side of (6), and the new f is covered by legacy D_mix. This proves the stated bound, not the generally unjustified inequality D_t<=D_mix.

## 4. Selected-family old guards, peaks and tensor composition

For the saved full outer plans set `S_t=sum_i C_t(n_i)`, counting repeated axes. Let S_mix and S_base denote the old mixed and old whole-axis-baseline sums at those same axes. The new tree proof gives S_t<=S_sharp<=S_mix. The admitted family's separately reviewed comparison supplies S_mix<=S_base; it is not asserted here for arbitrary replacement plans.

KEEP the existing guards

    p>=100,
    2^p>=D_local_old,
    2^p>=2*S_base,                                 (7)

where D_local_old retains both old mixed and baseline axis denominators. Equations (6)--(7) cover all new D_t, including descendant Blue peak premises. Each legacy descendant C is at most its axis C, hence at most S_mix<=S_base. The old global fallback `2^p>=29961461170177` and `2^p>=2*424706204` is equally valid on its previously admitted family. These source bounds are inherited, not regenerated by this no-inventory note.

Consequently the existing magnitude/width proof remains in force, including CT second-child scaling, ordered outer-axis contexts, normalized inverse factor `Z_s=nm/P+2`, and postchirp bounds. Smaller C_t does not by itself shrink any stored or raw operand capacity. Retaining only D_B, only a reduced C sum, or an unproved new peak guard would not be this theorem.

The same norm-one exact normalized operators yield the tensor recurrence

    E_(i+1)<=E_i+C_t(n_(i+1))*u*(V+E_i),
    E_final<=V*(product_i(1+C_t(n_i)*u)-1)
           <=2*S_t*V*u.

The final inequality follows by finite product expansion and the geometric bound under `S_t*u<=S_base*u<=1/2`. Restoring the full group size phi(c), with the exact conductor factor magnitude 1/sqrt(c) and the retained V<=2^14 input bound, gives

    epsilon_t(c,p)=2*phi(c)*S_t*2^14*2^-p/sqrt(c).    (8)

Primitive-output counts do not replace phi(c). Source/input uncertainty, finite head, conductor-factor approximation and actual phase/completion errors remain separate.

One may replace only S_sharp by S_t in the previously reviewed p100--108 test,

    (2*phi(c)*S_t)^2 * 2^(2*(108-p))
        <= c*(1266*202305920)^2,                    (9)

while retaining (7). Every previously admitted sharp p still passes. This is a conditional paper admission, not an assigned precision. With the unchanged nontransform allocation R_fixed, (9) preserves

    R_fixed+135*epsilon_t(c,p) <= R_108,
    R_108/2^-45 =2804840254168152529/4294967296000000000
                <0.653052762<691/1024.

The full allocation and actual normalization are exactly those pinned in the accepted sharp rule section 4. One common p per conductor, grid100 source embedding, all requested positive/inverse-character samples and separately certified kernels remain required. No old centers, strict signs or successful count certificates are inherited by changing p. This note performs no selector or workload fold.

## 5. Why the existing sharp rule can gain at most one bit

At a normalized Bluestein leaf, exact subtraction gives

    C_B_sharp-3*C_B_old/4 =3P/2+21R/2+8 >0.          (10)

At an unchanged leaf C_sharp=C_mix>=3*C_mix/4. At a CT node the difference equals the sum of the two child differences plus `2-3*2/4=1/2`. Induction and summing repeated axes establish

    3*S_mix/4 <= S_sharp <= S_mix.                  (11)

This compares the same old mixed plans with the existing sharp rule, not a whole-axis baseline or C_t. If S_mix=0, both intrinsic sums vanish and the same remaining guards decide admission.

Otherwise consider the least admitted p_old and p_sharp in the same integer interval 100,...,108, with the same target and the same guards (7). Monotonicity first gives p_sharp<=p_old. If p_sharp<108, then at p_sharp+1 the old error is at most

    (4/3)/2 * epsilon_sharp(c,p_sharp)
       = (2/3)*epsilon_sharp(c,p_sharp),

which passes the same target. Every guard is monotone in p, so p_old<=p_sharp+1. At p_sharp=108, both equal 108. Thus the reduction for that existing selector is zero or one bit. This argument does not use a conductor distribution and cannot predict how often either case occurs. It is not a bound on what the new tighter coefficient can achieve, nor on a selector with changed guards, targets, cache interfaces or arithmetic assumptions.

## 6. Fixed evidence and remaining gates

The companion checks three formal polynomial identities and four fixed length examples (n=2,3,5,17), plus the explicit guard-independence and selector-ratio identities. It verifies six source hashes. There are 42 checks, no plan/inventory parsing, no analytic or coefficient values, and no production selection. The examples merely test the algebra; the general proof is sections 2--5.

| Artifact | SHA256 |
|---|---|
| tighter_normalized_chirp_constant_20261111.py | 7ECE987A0A0B8435B1F3B50D2DF44F6C2E68D4A51AFD1BCEC015377928A59A0E |
| tighter_normalized_chirp_constant_20261111.json | 638560280015BAC11419FFD4E00DDA00F65641C2681BBBAAE9217A5B7BB12FCF |
| ../audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md | 08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F |
| REVIEW_SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md | 3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3 |
| ../independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md | FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9 |
| ../integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md | 09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA |
| ../zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md | 4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4 |
| ../major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md | 1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A |

Actual ordinary arithmetic and root/gate certificates, normalized cache construction and imports, exact plan/source binding, all retained safety/peak proofs, new p-specific caches and centers, complete sign/count acceptance and producer/checker costs remain obligations. No recurrence field in an existing receipt is reinterpreted or modified by this successor.
