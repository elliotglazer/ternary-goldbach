# Next initializer and recurrence connections

This is an unproved implementation handoff. It does not enlarge the accepted inverse-root scope.

First connect the existing SourceArithmetic.source_initial option result to SourceStateError.source_pair_value. The intended universal contract is: if source_initial A D amplitude_bits state_bits = SOME initial, then its value on grid 2^state_bits differs in complex modulus from complex_of_real (sqrt ((&D:real)/&A)) by strictly less than 1/(2:real)^amplitude_bits; the exact target has modulus at most one.

The successful option guard itself supplies 0<D, D<=A and amplitude_bits<=state_bits. It implies A>0. Prove the exact integer shift/grid identity using 2^state_bits = 2^amplitude_bits * 2^(state_bits-amplitude_bits), transport both integer casts, then use the accepted root accuracy theorem and MODU_REAL. Do not add an assumed source-value equality. Raw parameters are D=1, A=x, amplitude_bits=98, state_bits=120. EM parameters are D=512, A=512+k, amplitude_bits=123, state_bits=140. The EM caller's k<=113152 domain gate remains separate.

Afterward relate sqrt(D/A) to the analytic amplitude 1/sqrt(A/D) using positive denominators and the existing SQRT_INV/SQRT_DIV results. The phase-step logarithm/exponential producer and its exact analytic recurrence still require proof. The existing generic recurrence consumes these contracts only after they are established.

A useful next EM specialization of source_envelope_linear_prefix has initialError=2^-123, delta=2^-140 and N=128000. Its rational endpoint is strictly below 2^-121 because 2^17+3*128000 = 515072 < 524288 = 2^19. This arithmetic was checked externally using exact Python fractions while preparing this note; it is not a HOL theorem. A separately proved conversion from persistent grid 2^140 to output grid 2^122 would add at most 2^-122 in complex modulus, so the copied output would remain below 2^-120. The copied value must never feed back into the persistent state.

No numerical source benchmark or aggregate forecast discount follows from this handoff. Actual source/step/transform/sign/count blocks remain required by CONFIDENCE_REQUIREMENTS.md.
