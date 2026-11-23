# Next actual raw phase connection

This is the next proof plan, not an accepted exponential theorem or a runtime
measurement. Retain the actual source producer and its current precision.

The next required contract uses q = source_raw_log129 k x and
theta = -(5/64)*ln(&x). Under source_log_domain x 1 k and k<=18, prove

    modu (source_pair_value (2**122) (source_raw_step q)
          - (cos theta,sin theta)) <= 2^-120.

SourceStateBounds.source_raw_state_error_lt_dyadic96 already consumes this
step contract. The actual initializer has its separate accepted theorem.
The exact analytic target recurrence and concrete input gates still need their
own joins. This contract alone does not close a source/sign/count block.

## Existing definitions and library facts inspected

SourceArithmetic.source_raw_step q is source_regrid 9 applied to
source_exp_horner (2**131) (-5*q) (2**135) 72 0. The terminal Horner value is
(grid,0). Each update divides by d*(k+1), adds the real constant grid and
rotates/scales the recursive pair. Thus 72 updates represent degree 72,
including the constant term, before rounding. The ideal recurrence and this
polynomial identity need proofs against the executable definition.

The imported complexTheory already provides EXP_IMAGINARY, MODU_UNIT,
COMPLEX_MUL_ARG and COMPLEX_EXP_ADD. Its complex_exp definition reduces to
real exp times the sine/cosine pair. No new complex differentiation library
is necessary just to establish the raw unit phase.

transcTheory.MCLAURIN_ALL_LE supplies a real Taylor remainder from an explicit
sequence of successive derivatives. SIN_BOUND and COS_BOUND are also present.
It remains to instantiate that theorem for both components, relate its sum to
the ideal Horner recurrence, and prove the finite factorial bound. Library
availability is not a completed instantiation.

## A deliberately loose raw-only budget

Use an absolute phase bound of 2 to avoid requiring a sharp bound on ln(x).
The actual domain and k<=18 imply 1<=x<=2^19. Prove 0<=ln(x)<=19 using
ln(2)<=1, then include the raw-log error to show the rounded phase also has
absolute value at most 2. All these inequalities remain implementation tasks.

A local rounded complex update has unscaled modulus error at most 1, from
the coordinate half-unit bounds. For starting indices k>=2, contraction by
at most 2/(k+1)<=2/3 permits a uniform accumulated bound 3. At k=1 the bound
is 4, and at k=0 it is 9. This proposed induction works for any term count
and avoids bounding a large geometric expression or evaluating the updates
inside the generic theorem. Prove the denominator and cast identities first.

With 73 Taylor terms, each real component's remainder is at most 2^73/73!,
so the sum-of-coordinate bound gives complex error at most 2^74/73!. The
raw logarithm error contributes at most (5/64)*2^-128 in phase. A coarse
sine/cosine Lipschitz estimate gives twice that error in complex modulus.
The final nine-bit regrid contributes at most 2^-122. Therefore the proposed
budget to prove is

    9/2^131 + 2^74/73! + 2*(5/64)*2^-128 + 2^-122 < 2^-120.

A separate exact-rational Python calculation passed this strict inequality;
the left side is approximately 0.2550048828125 of the allowance. This arithmetic
check does not prove the proposed component bounds or their HOL composition.

This is only a route to the current contract, not a reduction in the existing
72 updates or grid widths. The EM phase has period reduction, a pi producer,
different widths and two output regrids. It needs a separate specialization;
the raw bound of 2 must not be silently transferred to it.
