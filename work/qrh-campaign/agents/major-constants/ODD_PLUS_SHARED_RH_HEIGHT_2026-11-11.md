# A lower odd-conductor plus profile under shared RH

2026-11-11. Conditional paper/source result with exact rational witnesses. No finite-RH instance, prime, zero, L-value, Mellin value or transform was evaluated, and no Lean source or build was changed. This is only the odd-conductor component. The separately proposed even profile and shared-RH cubic assembly require their own review.

For odd primitive nonprincipal conductors c<=132900, the profile below implies a Gauss-weighted coprime plus coefficient bound **7.41e-7**, below the shared-RH budget's sufficient **8.385e-7**. It dominates the reduced base-gap and star cutoffs. The previously reviewed coupled profile remains a valid fallback.

## Statement and parameter choice

Retain R=132900, x=49y>=4.9e26, the actual etaPlus smoothing, and the closed GRHUpTo convention. Put

    d_c=531600/c,
    u(c)=21    for c<100,
         20    for 100<=c<1000,
         19.5  for 1000<=c<10000,
         19.2  for 10000<=c<=132900,
    Todd(c)=ceil(200+max(240,3.1416*u(c)*d_c)).          (1)

Assume actual RH for every primitive nonprincipal chi of each such odd conductor through Todd(c), including both ordinate signs, central zeros, boundary zeros and true multiplicities. Modulus one is excluded; its original principal RH-through1e8 and principal finite inputs are retained separately.

For every |delta|<=d_c and every x in the unbounded domain, the source Prop942 argument then gives

    sqrt(c)*|Schar(chi,Lambda*etaPlus_x,delta/x)|/x
         <3.47e-7+3.93e-7+2e-17.                     (2)

After the actual coprime/Gauss transfer, every ambient character with odd inducing conductor and nonzero Gauss factor has normalized weighted coefficient less than7.41e-7. No primality, squarefreeness or real-character hypothesis is imposed on c.

All constants in (1) are rational, with3.1416=3927/1250. First take this integer certificate-height ceiling; any later grid ceiling is separate. In fact the240 branch is inactive on this odd domain because d_c>=4 and3.1416*19.2*4>240. Keeping it in the formula records the EB proof parameter. The uniform lower bound Todd>=440 is sufficient below; actual highest odd conductors have Todd=442.

## The four source errors

The source error is E0/x+E1(c,T)/sqrt(x)+E2(c,T,delta)+V/(2*pi*x*sqrt(x)), with the definitions of Prop942.lean:50-53. Admissibility follows from u>=19.2>10, T-200>=240 and pi<3.1416.

For every c the u in (1) is no larger than the corresponding u in the reviewed coupled profile, and240<=255. Therefore Todd is no larger than that profile's integer height and hence no larger than the original endpoint1e8/c. The old positive E1g bound is nondecreasing in T, so it gives E1(c,Todd)<=7.66e6/sqrt(c). Since sqrt(x)>2.21e13, its scaled contribution is less than3.47e-7. The same endpoint comparison gives Z3g(BP c,Todd)<=177.26. Neither comparison calls an RH theorem at the old higher endpoint.

E0 and V do not depend on T. Their source bounds stay at most1e-17/sqrt(c) each, because c<=300000, |delta|<=600000 and x>=4.9e26 still hold. The high-zero error must instead be recomputed as follows.

Use Thm714.E2_gen_le:101 with T1=240, Z=177.26, C0=.1, IB=2.1768 and prefactor129.24. The changed growth constant is justified by

    11*4.4 <= .1*440*1.2039.

Thus c3g<=.1 at every required height. The prior value .09 is not silently reused at the lower floor. From IA_le:208 and the actual odd twist,

    IA<=1+3.1416*(|delta|+1)/8.492
       <=a+K/c,  a=1.371, K=196700.                  (3)

Both comparisons defining a,K are rational and strict. The halved K compared with the all-parity proof is justified by d_c=531600/c.

The endpoint tail witnesses are

    EB(240)<=4.727e-15,
    .588*u^2*exp(-.1065*u^2)<=EA_cap(u),

| u | EA_cap |
|---:|---:|
|21|1.039e-18|
|20|7.422e-17|
|19.5|5.781e-16|
|19.2|1.93e-15|

For each nonnegative rational z, the exact checker uses P(z)=sum_(k=0)^16 (z/64)^k/k! and exp(z)>=P(z)^64. It verifies each upper tail bound by multiplying through by this positive rational lower bound. No exponential routine is called. The source monotonicities of t*exp(-.1598t) for t>=240 and u^2*exp(-.1065u^2) for u>=10 then apply at all heights/twists. At delta=0 the source EA branch is zero and needs no quotient.

For a band L<=c<=U choose sl^2<=L, su^2>=U. Expansion before estimation gives

    sqrt(c)*(2Z*IA+2C0*IA^2)
       <=(2Za+2C0*a^2)*su
           +(2ZK+4C0*aK)/sl+2C0*K^2/(L*sl)=G(L,U).

All coefficients are nonnegative, so each term is bounded in its correct direction. Use the following closed bounding bands, enlarging the half-open bands in (1):

| L | U | sl | su |
|---:|---:|---:|---:|
|3|100|1.732|10|
|100|1000|10|32|
|1000|10000|31.62|100|
|10000|132900|100|365|

For every row, direct rational substitution gives

    129.24*[365*(4.727e-15)*(2Z*IB+2C0*IB^2)
                  +EA_cap(u)*G(L,U)] <3.93e-7.        (4)

This proves sqrt(c)*E2<3.93e-7 over the entire odd domain, not just the table endpoints. The global365 in the EB term uses132900<365^2. Both geometric denominators, all count terms and both tails are retained. Equations (2)-(4) therefore account for every Prop942 term.

## Ambient characters and the shared budget

For an ambient q in Qset R, the source inverse-character induction preserves the primitive conductor c. When c is odd, its Gauss-supported contribution satisfies2c<=qt(q), so the ambient |delta|<=1063200/qt(q) lies in the domain of (2). This includes ambient even q; it is not restricted to odd moduli. The actual Gauss bound is |tau_q(psi)|<=sqrt(c). The inner coprime removal costs at most516e-15 after this multiplication (a deliberately loose uniform bound). Hence

    weighted coprime coefficient
        <3.47e-7+3.93e-7+2e-17+516e-15 <7.41e-7.

The principal coprime constant2.83e-7 and outer additive removal remain separate. The local odd contribution therefore obeys the shared budget's8.385e-7 cap. For a complete family, the even component must independently meet its appropriate uniform or supported-energy cap; this odd-only theorem does not assert that fact.

The exact scalar implications used by the pending SHARED_RH_STAR_BUDGET are

    (8.385e-7)^2 <7.03135e-13,
    7.03135e-13+(2.83e-7)^2 <(8.85e-7-516e-15)^2.

Thus a complete valid odd/even energy join preserves rho8.85e-7. The old smaller upper-J coefficient cannot simply be retained; the reviewed direct residual integration supplies Z<.006^2 and X<=8.79x instead. The shared-RH star argument restricts its complete low carriers to Hstar, not Todd. Subject to that argument and the even component, it supplies sqrt(A)<1.284e-6 and sqrt(B)<.004 and preserves the original cubic/Fourier-tail budget. This note neither re-proves that assembly nor assumes its pending independent review has completed. It uses no direct-B1915 or etaU coefficient-sieve premise.

## Cutoff union and exact examples

The explicit safe common odd height is max(Todd,Hbase,Hstar), where Hbase=ceil(27e6/c) and Hstar=ceil(max(300,704*d_c/343)). In this domain that maximum equals Todd:19.2*3*531600>27e6,19.2*3>704/343, and Todd>=440>300. The inequalities apply before ceiling, hence also afterwards. They do not replace the separate base-gap and star analytic proofs.

| c | Todd | Reviewed coupled fallback |
|---:|---:|---:|
|3|11690722|12804105|
|5|7014514|7682543|
|101|330908|355711|
|1001|32734|34403|
|10001|3407|3457|
|60001|735|743|
|132899|442|455|

These are integer metadata, not verified zeros or a cost inventory. Principal inputs, Turing auxiliary extensions and all exact-count consumers remain separate. No universal successful auxiliary width is implied. The construction is one conservative profile, not a claim of optimal height or end-to-end efficiency.

## Evidence

The companion odd_plus_shared_rh_height_20261111.py/JSON contains42 exact checks, the full rational band bounds,11 height examples and six source/report SHA256 pins. It reuses the already reviewed coupled-profile E1/low-count and origin/vertical proof, but supplies new odd IA, EB, EA and growth witnesses. Substantive source entry points remain Prop942:50-82, Thm714:101/:208/:221/:247/:430-482 and ArcChars:314-440, at the unchanged source baseline23b2d68ca344203d4384e0aff7affa4ec034bef9. No earlier frozen artifact was modified. Independent review is required before using this odd component in a merged profile.
